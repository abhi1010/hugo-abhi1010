+++
description = "Exploring a versatile Python file utilities module for everyday development tasks"
title = "Mastering File Operations in Python: A Deep Dive into a Practical Utils Module"
date = "2018-05-20T09:30:00+08:00"
categories = ["code"]
keywords = ["python", "file operations", "utilities", "development", "file handling", "csv", "json", "automation"]
tags = ["python", "utilities", "file-operations"]
+++


File operations are the bread and butter of many Python applications. Whether you're working with data processing, automation, or building robust applications, having a reliable set of utilities to handle files can save you countless hours of development time.

In this post, I'll explore a versatile file utilities module that I've been refining for various projects. This collection of functions demonstrates practical approaches to common file operation tasks that you might encounter in your day-to-day development.

## The File Utilities Arsenal

Let's start by looking at what this module offers. Here's a breakdown of the key functionalities:

1. Finding latest files by patterns or extensions
2. Reading files with different encodings
3. Processing CSV files
4. Handling JSON data
5. Working with compressed files
6. Directory and file pattern matching
7. File writing operations
8. Path manipulation
9. File compression and FTP uploads

## Finding the Latest Files

One of the most common tasks in file operations is finding the most recent file in a directory, especially when dealing with automated data imports or log processing. The module provides two handy functions for this purpose:

```python
def get_latest_file_in_folder_by_pattern(folder_path, pattern):
    """Find the most recently modified file containing a specific pattern."""
    files = [
        os.path.join(folder_path, f)
        for f in os.listdir(folder_path)
        if pattern in f
    ]
    if len(files):
        latest_file = max(files, key=os.path.getctime)
        return latest_file
```

```python
def get_latest_file_in_folder(base_dir, folder_path, extension_to_filter):
    """Find the most recently modified file with a specific extension."""
    extension_to_filter = extension_to_filter if extension_to_filter.startswith(
        '.') else '.' + extension_to_filter
    files = [
        os.path.join(base_dir, folder_path, f)
        for f in os.listdir(os.path.join(base_dir, folder_path))
        if f and f.endswith(extension_to_filter)
    ]
    if len(files):
        latest_file = max(files, key=os.path.getctime)
        return latest_file
```

These functions are particularly useful when dealing with time-series data or log files that are generated periodically.

## Reading Files with Error Handling

Reading files sounds simple, but in practice, you often need to handle different encodings, compressed formats, and more. Here's how this module tackles these challenges:

```python
def get_file_text(file_path):
    """Read file content, handling ZIP files appropriately."""
    f_first, ext = path.splitext(file_path)
    if ext.upper() == '.ZIP':
        with ZipFile(file_path) as zfile:
            for finfo in zfile.infolist():
                ifile = zfile.open(finfo)
                return ifile.read()
    lines = get_file_lines(file_path)
    text = ''.join(lines)
    return text

def get_file_lines(file_path):
    """Try reading file lines with multiple encodings."""
    enc_list = ['utf-8', 'iso-8859-1']
    for encode in enc_list:
        try:
            with open(file_path, 'rt', encoding=encode) as file_placeholder:
                return file_placeholder.readlines()
        except:
            pass
    return []
```

The `get_file_lines` function is particularly clever as it tries different encodings - a common issue when working with files from various sources.

## Working with CSV Files

CSV files are ubiquitous in data processing. This module includes specialized functions for handling them:

```python
def get_csv_lines(file_path):
    """Read CSV files with encoding fallbacks."""
    enc_list = ['utf-8', 'iso-8859-1']
    for encode in enc_list:
        try:
            with open(file_path, 'rt', encoding=encode) as file_placeholder:
                reader = csv.reader(file_placeholder, delimiter=',')
                return [line for line in reader]
        except:
            pass
    return []
```

There's even a special function for dealing with the dreaded BOM (Byte Order Mark) that can cause issues when processing CSV files:

```python
def get_csv_lines_without_ominous_mark(file_path):
    """Removes BOM mark and handles line breaks in CSV files."""
    s = open(file_path, mode='r', encoding='utf-8-sig').read()
    open(file_path, mode='w', encoding='utf-8').write(s)
    # Replace ^M line break
    lines = get_file_lines(file_path)
    new_lines = []
    for l in lines:
        new_lines.append(
            l.replace(r'\r',
                      '').replace('\n',
                                  '').replace('/', '_').replace('"', '').split(','))
    return new_lines
```

## Pattern Matching for Files and Directories

Finding files that match specific patterns is another common task:

```python
def find_dirs_and_files(
    pattern, where='.', include_dirs=True, include_files=True, debug=False):
    """Returns list of filenames matched by pattern (case-insensitive)."""
    if not where or not path.exists(where):
        return []
    if debug:
        logging.debug("where={}; pattern={};".format(where, pattern))
    rule = compile(translate(pattern), IGNORECASE)
    list_files = [name for name in listdir(where) if rule.match(name)]

    if include_dirs and not include_files:
        list_files = [
            name for name in list_files if path.isdir(path.join(where, name))
        ]
    if include_files and not include_dirs:
        list_files = [
            name for name in list_files if path.isfile(path.join(where, name))
        ]
    if include_files:
        list_files = add_folder_to_list_of_files(where, list_files)
    return list_files
```

This function leverages Python's `fnmatch.translate` to convert shell-style wildcards to regular expressions, making it powerful yet intuitive to use.

## File Validation

Sometimes you need to check if a file matches expected formats:

```python
def is_valid_file(file_name):
    """
    Matching filename either based on extension or the filename in digits and/or dash
    """
    pattern = compile('(\.(csv|xls|txt|pdf)$)|(20\d{2})-?(\d{1,2})-?(\d{1,2})')
    res = pattern.search(file_name)
    return res is not None
```

This function checks for common file extensions or date patterns in filenames, which is useful for automated processing workflows.

## Practical Applications

Let's look at a few practical examples of how you might use these utilities in real-world scenarios:

### Example 1: Processing the Latest Data File

```python
# Find the latest CSV report and process it
def process_latest_report(reports_folder):
    latest_report = get_latest_file_in_folder(os.getcwd(), reports_folder, 'csv')
    if latest_report:
        csv_data = get_csv_lines(latest_report)
        # Process your data here
        print(f"Processed {len(csv_data)} rows from {latest_report}")
    else:
        print("No reports found!")
```

### Example 2: Archiving Log Files

```python
# Archive old log files and upload to FTP
def archive_logs(log_dir, pattern="*.log"):
    log_files = find_dirs_and_files(pattern, log_dir, include_dirs=False)
    if log_files:
        archive_name = f"logs_{datetime.datetime.now().strftime('%Y%m%d')}.zip"
        create_zip(archive_name, log_files)
        print(f"Created archive: {archive_name}")

        # Upload if needed
        # upload_to_ftp_service(my_sftp, archive_name)

        # Clean up original files if needed
        # remove_files(log_files)
```

## Areas for Improvement

While the module provides a solid foundation, there are some improvements I'd suggest:

1. **Better error handling**: Many functions silently fail or return empty lists/strings. Adding more explicit error handling could help debugging.

2. **Type hints**: Adding type hints would make the code more maintainable and IDE-friendly.

3. **Documentation**: While the function names are descriptive, proper docstrings would make the module more accessible.

4. **Modularization**: Some functions could be broken down further or grouped into classes for better organization.

## Conclusion

File operations are fundamental to many Python applications, and having a robust utility module can significantly streamline your development process. The utilities presented here cover many common scenarios you'll encounter in real-world projects.

Feel free to adapt these functions for your own needs or contribute improvements. What file operations do you find yourself repeatedly implementing? Share your thoughts in the comments!

---

## Resources

- [Python's os.path documentation](https://docs.python.org/3/library/os.path.html)
- [Working with ZIP files in Python](https://docs.python.org/3/library/zipfile.html)
- [Python's CSV module](https://docs.python.org/3/library/csv.html)