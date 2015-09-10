+++
categories = ['code']
tags = ['git']
date = "2015-09-10T00:18:24+08:00"
description = ""
keywords = []
title = "using external tools with git diff"
draft = true
+++

{{< highlight bash >}}
git diff 5fad06c..0a504fa
{{< /highlight >}}

{{< highlight diff >}}
diff --git a/modules/higgs_config/templates/carbo/tosestage-ems02.carbooxose-t01.json.erb b/modules/higgs_config/templates/carbo/tosestage-ems02.carbooxose-t01.json.erb
index 0538da0..6621d93 100644
--- a/modules/higgs_config/templates/carbo/tosestage-ems02.carbooxose-t01.json.erb
+++ b/modules/higgs_config/templates/carbo/tosestage-ems02.carbooxose-t01.json.erb
@@ -5,8 +5,8 @@
 
   // Algo settings
   "Carbo": {
-    "active-instrument-id-key": "FUTURE|XOSE|FUT_NK225_1509|1509",
-    "hedge-instrument-id-key": "FUTURE|XOSE|FUT_NK225M_1509|1509",
+    "active-instrument-id-key": "FUTURE|XOSE|FUT_NK225_1512|1512",
+    "hedge-instrument-id-key": "FUTURE|XOSE|FUT_NK225M_1512|1512",
     "owner-app-id": "web/chuck/alice",
     "order-book-id": "uatRonald.carbo.ne",
{{< /highlight >}}

git config --global diff.tool meld

git difftool 5fad06c..0a504fa

