+++
description = "Building an Iron Condor Options Screener with TastyTrade API"
title = "Understanding Iron Condor Screener with TastyTrade API"
date = "2023-09-02T10:30:00+08:00"
categories = [ "finance"]
keywords = ["iron condor", "options trading", "tastytrade", "python", "screener", "options api", "trading algorithm"]
tags = ["python", "finance", "options", "tastytrade", "trading"]
+++



In this blog post, I'll break down a Python program that screens for iron condor options trading opportunities using the TastyTrade API. The code retrieves options data, calculates metrics for iron condor spreads, and ranks the results to find potentially profitable trades.

## What is an Iron Condor?

Before diving into the code, let's quickly review what an iron condor is. It's an options trading strategy that involves:

1. Selling an out-of-the-money put
2. Buying a further out-of-the-money put
3. Selling an out-of-the-money call
4. Buying a further out-of-the-money call

All options typically have the same expiration date. Iron condors are market-neutral strategies that profit when the underlying asset stays within a certain price range.

## Key Components of the Code

### 1. The `LivePrices` Class

This class is central to the program. It manages live market data by:

```python
@dataclass
class LivePrices:
  quotes: Dict[str, Quote] = field(default_factory=dict)
  greeks: Dict[str, Greeks] = field(default_factory=dict)
  streamer: DXLinkStreamer = None
  puts: Dict[str, List[Option]] = field(default_factory=dict)
  calls: Dict[str, List[Option]] = field(default_factory=dict)
  tickers: List[str] = field(default_factory=list)
  pickle_file: str = "data/greeks_data.pickle"
  _update_task: asyncio.Task = None
  subscription_items: List[str] = field(default_factory=list)
```

The class connects to TastyTrade's DXLinkStreamer to get real-time data on options. It stores:
- Options quotes (bid/ask prices)
- Options Greeks (delta, gamma, theta)
- Call and put options for selected tickers

### 2. Data Collection Pipeline

The code follows a specific pipeline to collect and process options data:

1. **Initialize the streamer**:
   ```python
   async def _initialize_streamer(self, session: Session):
     self.streamer = await DXLinkStreamer.create(session)
   ```

2. **Get option chains for tickers**:
   ```python
   def _get_option_chain(self, session: Session, symbol: str):
     chains = None
     try:
       chains = get_option_chain(session, symbol)
     except Exception as e:
       logger.error(f'Exception : {str(e)}')
     return chains
   ```

3. **Filter options by expiration date**:
   ```python
   def _filter_options_by_expiration(self, symbol, chain, expiration: date):
     closest_expiry = get_closest_expiry(symbol, chain, expiration)
     logger.info(f'[{symbol}]:: closest_expiry = {closest_expiry}'
                 f' all chains = {chain}')
     return [o for o in chain[closest_expiry]]
   ```

4. **Subscribe to data streams**:
   ```python
   async def _subscribe_to_event(self, streamer_symbols: List[str],
                                 event_greeks_or_quotes: EventType):
     logger.info(
         f'About to subscribe {event_greeks_or_quotes} to: {streamer_symbols} for greeks'
     )
     self.subscription_items.append(streamer_symbols)
     await self.streamer.subscribe(event_greeks_or_quotes, streamer_symbols)
   ```

### 3. Converting Greeks to Option Holders

The `convert_greeks_to_optionholders` function transforms the raw Greek data into a standardized format:

```python
def convert_greeks_to_optionholders(greeks_list, tasty_monthly):
  option_holders = []

  # Regex pattern to match the eventSymbol format
  pattern = r"\.(\w+)(\d{6})([CP])(\d+(?:\.\d+)?)"

  for greek in greeks_list:
    option_holder = option_utils.OptionHolder()

    # Extract ticker, strike, expiry, and option type from the eventSymbol
    # ...

    # Set other attributes from the Greeks object
    option_holder.IV = float(greek.volatility)
    option_holder.Theta = float(greek.theta)
    option_holder.Delta = float(greek.delta)
    option_holder.Gamma = float(greek.gamma)

    # ...
```

This standardization makes it easier to perform calculations and comparisons across different options.

### 4. Finding Iron Condor Candidates

The core of the iron condor screening is in the `update_options_with_bid_ask_from_tasty` function:

```python
async def update_options_with_bid_ask_from_tasty(session, tasty_monthly_expiry,
                                               ticker, option_holders_list,
                                               use_pickle):

  call_to_sell, call_to_buy, put_to_sell, put_to_buy = yf_option_ic.get_calls_and_puts_for_ic(
      option_holders_list, ticker, delta_for_search=0.2)

  if call_to_sell is None or call_to_buy is None or put_to_sell is None or put_to_buy is None:
    logger.info(f'[{ticker}]:: Missing call or put with delta of 50 for IC')
    return False

  # ...
```

This function:
1. Finds suitable calls and puts for an iron condor based on delta values
2. Gets real-time bid/ask quotes for those options
3. Updates the option holders with live price data

The `delta_for_search=0.2` parameter is particularly important - it looks for options with approximately 0.2 delta (or -0.2 for puts), which typically have around a 20% chance of expiring in-the-money.

### 5. Calculating Iron Condor Metrics

The actual iron condor calculations happen in external functions called from the main code:

```python
if options_updated_successfully:
  yf_option_ic.get_iron_condor_credit(option_holders_list,
                                      ticker,
                                      delta_for_search=0.2)
  all_ticker_options_dict[ticker] = option_holders_list
else:
  logger.info(f'Some issues with {ticker}. Skipping IC calculation')
```

And then:

```python
iron_condor_data = yf_option_ic.generate_iron_condor_stats(
    all_ticker_options_dict)

yf_option_ic.tabulate_ic_data(iron_condor_data, liq_ticker_metrics)
```

These functions (imported from `yf_option_ic` module) handle:
- Calculating the credit received for the iron condor
- Determining the maximum risk
- Computing risk/reward ratios
- Calculating probability of profit
- Generating a ranked table of iron condor opportunities

### 6. Asynchronous Execution

The code leverages Python's async features extensively, allowing it to:
- Stream multiple data feeds simultaneously
- Process multiple tickers in batches
- Handle timeouts and cleanup gracefully

```python
async def run_main():
  # ...
  loop = asyncio.get_running_loop()
  loop.add_signal_handler(signal.SIGINT, handle_sigint)
  # ...
  try:
    await main(session, args.use_pickle)
  except asyncio.CancelledError:
    logger.info("Main task cancelled")
  finally:
    logger.info("Cleanup complete")
```

### 7. Iron Condor findings
Here's a sample result while finding out the potential tickers to trade with high IVR.

```bash
Filtered List of tickers with BPE < 350 or RR > 1:

Ticker      Credit    Max Loss     RR     BPE    IVP    IVR
--------  --------  ----------  -----  ------  -----  -----
BITX          0.73        0.27   2.77   26.50   0.46   0.47
GBTC          0.92        0.08  12.33    7.50   0.54   0.60
UVXY          0.47        0.53   0.87   53.50   0.65   0.22
XLG           0.40        0.60   0.67   60.00   0.52   0.40
IBB           0.38        0.62   0.60   62.50   0.77   0.46
XLB           0.37        0.63   0.59   63.00   0.54   0.28
AMZN          1.83        3.17   0.58  316.50   0.87   0.57
XOP           0.37        0.63   0.57   63.50   0.60   0.23
CFLT          0.35        0.65   0.54   65.00   0.90   0.80
EWW           0.35        0.65   0.54   65.00   0.55   0.27
IWM           0.35        0.65   0.54   65.00   0.74   0.51
MAT           0.35        0.65   0.54   65.00   0.95   0.67
XLK           1.75        3.25   0.54  325.50   0.58   0.21
AMD           1.71        3.29   0.52  328.50   0.82   0.67
PINS          0.34        0.66   0.52   66.00   0.92   0.78
TLT           0.34        0.66   0.52   66.00   0.80   0.52
VUG           1.67        3.33   0.50  332.50   0.60   0.28
PLTR          1.63        3.37   0.49  336.50   0.93   0.58
SNAP          0.33        0.67   0.49   67.00   0.91   0.76
AAXJ          0.32        0.68   0.48   67.50   0.17   0.24
GDX           0.32        0.68   0.48   67.50   0.07   0.28
GLD           0.33        0.67   0.48   67.50   0.45   0.50
IJR           0.32        0.68   0.48   67.50   0.61   0.23
PYPL          0.81        1.69   0.48  169.00   0.90   0.57
RSP           0.32        0.68   0.48   67.50   0.55   0.35
XLC           0.33        0.67   0.48   67.50   0.78   0.50
XLI           0.32        0.68   0.48   67.50   0.54   0.42
XME           0.32        0.68   0.48   67.50   0.51   0.29
ALK           0.80        1.70   0.47  170.00   0.91   0.72
EEM           0.16        0.34   0.47   34.00   0.52   0.24
QQQ           1.59        3.41   0.47  341.00   0.77   0.38
XLY           1.61        3.39   0.47  339.00   0.77   0.34
ARKK          0.32        0.68   0.46   68.50   0.73   0.41
GOOGL         1.54        3.46   0.45  346.00   0.95   0.54
GOOG          1.53        3.47   0.44  347.50   0.95   0.59
XLV           0.30        0.70   0.44   69.50   0.56   0.28
ARKG          0.30        0.70   0.43   70.00   0.93   0.54
VSAT          0.30        0.70   0.43   70.00   0.89   0.65
XLP           0.30        0.70   0.43   70.00   0.38   0.23
XLE           0.29        0.71   0.42   70.50   0.69   0.33
INTC          0.29        0.71   0.41   71.00   0.95   0.58
SYY           0.70        1.80   0.39  180.00   0.91   0.71
UBER          0.70        1.80   0.39  180.50   0.82   0.53
XLU           0.28        0.72   0.39   72.00   0.46   0.34
XLF           0.27        0.73   0.36   73.50   0.82   0.31
```

## Key Insights from the Code

1. **Delta-Based Selection**: The code uses delta as a primary metric for selecting options, targeting approximately 0.2 delta options for both calls and puts.

2. **Monthly Expiration Focus**: It specifically targets monthly options expirations using helpers like `get_tasty_monthly()`.

3. **Batch Processing**: The code processes tickers in small batches (`sub_group_size`) to manage API limits and memory usage.

4. **Data Persistence**: The code allows for caching results with pickle files to avoid repeated API calls during development/testing.

5. **Error Handling**: The code has robust error handling to skip tickers with missing or problematic data.

## Potential Improvements

Looking at the code, a few potential improvements could be:

1. **Parallel Processing**: The code processes ticker groups sequentially. Using more parallel processing could speed things up.

2. **Configurable Delta Values**: Making the delta target (currently hardcoded at 0.2) a command-line parameter would increase flexibility.

3. **Risk Management Parameters**: Adding more configurable risk parameters like maximum acceptable loss could help filter results.

4. **Persistent Database**: Using a database instead of pickle files would better support historical analysis.

## Conclusion

This code represents a sophisticated options screening tool that leverages the TastyTrade API to find potentially profitable iron condor opportunities. It combines real-time market data, options Greeks analysis, and automated filtering to identify high-probability setups.

The asynchronous design allows it to efficiently process multiple tickers, making it practical for scanning the entire market for trade opportunities. For options traders looking to find iron condor candidates, this tool provides a data-driven approach to identify trades with favorable risk/reward characteristics.