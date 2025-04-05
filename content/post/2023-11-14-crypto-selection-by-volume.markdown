+++
description = "Building a data-driven crypto trading tool that selects cryptocurrencies based on trading volume and market activity"
title = "Crypto Volume Selector: Building a Data-Driven Tool for Cryptocurrency Trading"
date = "2023-11-14T09:30:00+08:00"
categories = ["crypto", "finance"]
keywords = ["cryptocurrency trading", "trading volume", "crypto selection", "KuCoin API", "market analysis", "crypto liquidity", "trading automation", "CCXT", "crypto data analysis", "Python trading"]
tags = ["python", "cryptocurrency", "trading", "data-analysis", "automation", "CCXT", "KuCoin", "market-data", "trading-volume", "liquidity"]
+++


In the fast-paced world of cryptocurrency trading, making informed decisions based on market data is crucial. Today, I want to share a Python tool I've built that helps select cryptocurrencies based on their trading volume - a key metric that can indicate market interest and liquidity.

## Why Trading Volume Matters

Trading volume is one of the most important metrics when selecting cryptocurrencies for trading strategies. High volume typically indicates:

- Better liquidity (easier to enter and exit positions)
- More market interest
- Potentially lower slippage
- More reliable technical indicators

Volume, combined with price information, gives us the trading value - a measure of the total money flowing through a particular trading pair. This is often a more reliable indicator than just looking at price or volume in isolation.

## How the Volume Selector Works

My tool connects to the KuCoin exchange API, downloads trading data for all USDT pairs, analyzes their trading volume, and helps identify the most actively traded cryptocurrencies. Here's a breakdown of how it works:

### 1. Data Collection

The script can gather data in two ways:
- Using the CCXT library (a universal cryptocurrency exchange API)
- Using the Freqtrade trading bot's data download functionality

```python
def download_data_ccxt(kucoin_pairs, data_dir, num_of_days, timeframe='1d'):
    """
    Download OHLCV data using CCXT library directly
    """
    # Initialize Kucoin exchange
    exchange = ccxt.kucoin()

    # Calculate start timestamp
    end_date = datetime.now()
    start_date = end_date - timedelta(days=num_of_days)
    since = int(start_date.timestamp() * 1000)  # Convert to milliseconds

    # Process each pair
    for pair in kucoin_pairs:
        logger.info(f'Downloading data for: {pair}')

        try:
            # Fetch OHLCV data
            ohlcv = exchange.fetch_ohlcv(
                symbol=pair,
                timeframe=timeframe,
                since=since,
                limit=1000
            )

            # Convert to DataFrame
            df = pd.DataFrame(
                ohlcv,
                columns=['timestamp', 'open', 'high', 'low', 'close', 'volume'])

            # Save to JSON file
            pair_filename = pair.replace('/', '_')
            file_path = os.path.join(data_dir, f'{pair_filename}-{timeframe}.json')
            df.reset_index().to_json(file_path, orient='records', date_format='iso')

        except Exception as e:
            logger.error(f'Error downloading data for {pair}: {str(e)}')
```

### 2. Filtering and Data Processing

After collecting the data, the script:
- Filters out leveraged tokens (3L, 3S, UP, DOWN suffixes)
- Excludes stablecoins and special tokens (like USDC_USDT)
- Calculates trading value (price × volume)

```python
def create_symbols(vol_pairs_file, dir):
    files = os.listdir(dir)
    valid_names = _filter_out_leveraged_pairs(files)
    pairs = []

    with open(vol_pairs_file, 'wt') as vol_file:
        for file in files:
            file_path = os.path.join(dir, file)
            if os.path.isdir(file_path):
                continue

            with open(file_path, 'rt') as f:
                data = f.read()
                json_s = json.loads(data)
                pair_name = file.replace('-1d.json', '').replace('-1w.json', '')

                if pair_name.replace('_USDT', '') not in valid_names:
                    continue
                if 'USD_USDT' in pair_name or pair_name in IGNORED_SYMS:
                    continue

                if not (json_s) or len(json_s) == 0:
                    continue
                last_px = json_s[0][4]  # Close price
                vol = json_s[0][5]      # Volume
                pair = PairInfo(pair_name, last_px, vol)
                pairs.append(pair)

                vol_file.write(f'{pair_name},{last_px},{vol},{pair.trading_value}\n')

    return pairs
```

### 3. Final Selection

The script then selects the top cryptocurrencies based on trading value, with a minimum threshold to ensure sufficient liquidity:

```python
def get_filtered_pairs(pairs, args):
    sorted_pairs = sorted([p for p in pairs if p.trading_value > 100000],
                      key=lambda x: x.trading_value,
                      reverse=True)
    return sorted_pairs[:args.num_of_tokens]
```

### 4. Output Generation

Finally, the tool can save the results in several formats:
- A CSV with all the data
- JSON files with sorted pairs
- Split files for different market cap segments

```python
def save_list(filename, pairs):
    DIR_NAME = 'data'
    if not os.path.exists(DIR_NAME):
        os.mkdir(DIR_NAME)
    file_path = os.path.join(DIR_NAME, filename)
    with open(file_path, 'wt') as f:
        for pair in pairs:
            normalized_name = pair.name.replace('_USDT', '/USDT')
            f.write(f'"{normalized_name}",\n')
```

## Usage Workflow

A typical workflow for using this tool looks like:

1. Get a list of all available trading pairs on KuCoin
2. Download daily data for each pair
3. Process and analyze the volume data
4. Select the top tokens by trading value
5. Save and categorize the results

The command-line interface makes it easy to customize:

```bash
python trading/crypto/volume_selector.py \
  --dir /tmp/p \
  --vol-pairs-file /tmp/pairs.json \
  --num-of-tokens 200 \
  --save-filtered-pairs-names True
```

## Benefits for Trading Strategy Development

Using this volume selector provides several advantages:

1. **Data-driven selection**: Instead of picking cryptocurrencies based on news or popularity, you're selecting based on actual market activity.

2. **Segmentation capabilities**: You can easily split tokens into categories like high-cap, mid-cap, and low-cap, allowing for different trading strategies.

3. **Automation**: The entire process is automated, saving hours of manual data collection and analysis.

4. **Consistency**: By running this tool regularly (e.g., weekly), you can maintain an up-to-date list of actively traded cryptocurrencies.

## Implementation Details

The script includes several key components:

- `PairInfo` class to store information about each trading pair
- Data downloading functions using both CCXT and Freqtrade
- Filtering functions to remove unwanted pairs
- Sorting and selection based on trading value
- Output functions to save results in various formats

The full code is modular and extensible, allowing you to adapt it to different exchanges or criteria.

## Conclusion

Having a systematic approach to selecting trading pairs based on volume is invaluable for cryptocurrency trading. This tool provides a data-driven method to identify the most liquid and actively traded cryptocurrencies on KuCoin, which can be the foundation for building robust trading strategies.

By focusing on pairs with significant trading volume, you can reduce the risks associated with low liquidity and increase the reliability of your technical analysis. The tool is flexible enough to be adapted to different exchanges and can be integrated into a broader trading workflow.

Whether you're a day trader looking for active markets or a swing trader seeking reliable price action, understanding and utilizing volume data can give you an edge in the volatile world of cryptocurrency trading.

---

*Note: This tool is meant for educational purposes. Always do your own research before making trading decisions.*