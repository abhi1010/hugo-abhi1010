+++
categories = ['code']
tags = ['git']
date = "2015-09-10T00:18:24+08:00"
title = "Using External Tools with Git Diff"
+++

If you want to view what has changed since one commit to another, it is quite easy to view the diff.

{{< highlight bash >}}
git diff 5fad06c..0a504fa
{{< /highlight >}}

You will get something like this:

{{< highlight diff >}}
diff --git a/modules/file_1.erb b/modules/file_1.erb
index 0538da0..6621d93 100644
--- a/modules/file_1.erb
+++ b/modules/file_1.erb
@@ -5,8 +5,8 @@
 
   // Algo settings
   "Carbo": {
-    "active-instrument": "SGX/NK15",
-    "hedge-instrument": "SGX/NK16",
+    "active-instrument": "SGX/NK17",
+    "hedge-instrument": "SGX/NK18",
     "owner-app-id": "abhi1010",
{{< /highlight >}}

What if you wanted a use an external tool like `meld` to view the diff, in a nice beautiful side by side view? You'd have to modify your settings to tell that to `git`.
{{< highlight bash >}}
git config --global diff.tool meld
{{< /highlight >}}

Finally, then to view the diff:
{{< highlight bash >}}
git difftool 5fad06c..0a504fa
{{< /highlight >}}


