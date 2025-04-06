+++
description = "Building Robust Trading Strategies with a Python Backtesting Framework"
title = "Building Robust Trading Strategies with a Python Backtesting Framework"
date = "2022-04-11T00:00:00+08:00"
categories = ["finance"]
keywords = ["python", "backtrader", "algorithmic trading", "trading strategy", "technical analysis", "ATR", "trailing stops", "bracket orders", "relative strength", "position sizing", "risk management", "backtesting"]
draft = false
tags = ["python", "backtrader", "algorithmic-trading", "trading-strategies", "technical-analysis", "risk-management"]
+++
A few days ago we saw how to build a simple backtesting framework for algorithmic trading using the `backtrader` Python library.
I showcased a special class called `StrategyForComparison` that allowed for a flexible trading approach with various risk management options.
Now let's see how you'd utilize it in `backtest.py` code.

I'll walk through a powerful backtesting framework I've been using that offers comprehensive testing capabilities for algorithmic trading strategies, with code examples to help you understand how it all works.

## What is This Backtesting Framework?

At its core, this framework leverages the popular `backtrader` Python library alongside other essential packages like `pandas`, `quantstats`, and various technical analysis tools. Let's look at the main components:

```python
import backtrader as bt
import backtrader.analyzers as btanalyzers
import pandas as pd
import quantstats
import inflect
```

## Key Features That Make This Framework Valuable

### 1. Strategy Ecosystem

The framework includes over 25 trading strategies, all organized in a central dictionary for easy selection:

```python
_STRATEGIES = {
    'bb': BollingerAndRsi,
    'bb_fib': BollingerBands_Fib_Strategy,
    'cpr': CprSingleTimeframe,
    'golden_cross': GoldenCross,
    'ichimoku': Ichimoku,
    'mean_reversion': MeanReversion,
    'vwap': VWAP_RSI,
    # Many more strategies available...
}
```

This makes it incredibly simple to test different approaches - just change the strategy parameter when executing the script.

### 2. Command-Line Interface with Argument Parsing

The framework uses `argparse` to provide a flexible command-line interface:

```python
def parse_args():
  parser = argparse.ArgumentParser(description='Backtest Runner')

  parser.add_argument('--interval', '-i', default='1d')
  parser.add_argument('--fromyear', '-f', default=2000, help='Starting date in YYYY format')
  parser.add_argument('--toyear', '-t', default=2021, help='Starting date in YYYY format')
  parser.add_argument('--cash', default=100000, type=int, help='Starting Cash')
  parser.add_argument('--comm', default=0, type=float, help='Commission for operation')
  parser.add_argument('--plot', '-p', action='store_true', help='Plot the read data')
  parser.add_argument("-sym", '--symbols', nargs='+', help='<Required> Set flag', default=['AAPL'])
  parser.add_argument("-s", "--strategy", help="which strategy to run", type=str)

  # More arguments available...

  return parser.parse_args()
```

This allows for extensive customization of your backtests from a single command line.

### 3. Fractional Position Sizing

Unlike many basic frameworks, this one supports fractional position sizing, which is essential for realistic testing:

```python
class CommInfoFractional(bt.CommissionInfo):
  def getsize(self, price, cash):
    '''Returns fractional size for cash operation @price'''
    return self.p.leverage * (cash / price)

# Later in the code:
cerebro.broker.addcommissioninfo(CommInfoFractional(commission=args.comm))
```

### 4. Comprehensive Analysis with Multiple Analyzers

The framework adds a battery of analyzers to evaluate strategy performance:

```python
def add_analyzers(cerebro):
  # Add analyzers
  cerebro.addanalyzer(btanalyzers.SharpeRatio, _name='mysharpe')
  cerebro.addanalyzer(btanalyzers.Returns, _name='myreturn')
  cerebro.addanalyzer(btanalyzers.DrawDown, _name='mydrawdown')
  cerebro.addanalyzer(btanalyzers.Transactions, _name='mytransactions')
  cerebro.addanalyzer(btanalyzers.TradeAnalyzer, _name='myanalyzer')
  cerebro.addanalyzer(btanalyzers.SQN, _name='mysqn')
  cerebro.addanalyzer(bt.analyzers.PyFolio, _name='pyfolio')
```

### 5. Detailed Transaction Logging

Every trade is meticulously logged with all relevant details:

```python
def show_transactions(backtest, interval):
  logger.info("*** Transactions ***")
  analysis = backtest.analyzers.mytransactions.get_analysis()
  for key in backtest.analyzers.mytransactions.get_analysis().keys():
    ticker_analysis = backtest.analyzers.mytransactions.get_analysis()[key][0]
    side_text_s = ["Buy " if x < 0 else "Sell" for x in [ticker_analysis[4]]][0]
    side_sign = ' ' if 'Buy' in side_text_s else ''
    date_s = _get_date(key, interval)
    logger.info(
        f'Symbol:{ticker_analysis[3]}; '
        f'Date: {date_s}; '
        f'Price: {ticker_analysis[1]:5.2f}; '
        f'Type: {side_text_s}; '
        f'# Shares:{side_sign} {ticker_analysis[0]:.2f}')
```

### 6. Enhanced Analytics with QuantStats Integration

The framework creates beautiful HTML reports using the QuantStats library:

```python
def create_quant_stats(backtest_finished, strategy, output_file_name, interval, symbols):
  strat = backtest_finished[0]
  portfolio_stats = strat.analyzers.getbyname('pyfolio')
  returns, positions, transactions, gross_lev = portfolio_stats.get_pf_items()
  returns.index = returns.index.tz_convert(None)
  metrics = quantstats.reports.metrics(returns, mode='full', display=False)

  # Save metrics to tracking system
  algo_metrics = metrics['Strategy']
  algo_metrics['Symbol'] = symbols
  algo_metrics['Algo'] = strategy
  algo_metrics['Timeframe'] = interval
  tracker.save_df(algo_metrics)

  # Generate HTML report
  quantstats.reports.html(
      returns,
      output=output_file_name,
      download_filename=output_file_name,
      title=strategy)
```

## A Practical Example: Running the Framework

Let's say I want to test a Golden Cross strategy (50-day/200-day MA crossover) on Apple stock from 2018-2023 with $10,000 initial capital:

```bash
python backtest_runner.py --strategy golden_cross --symbols AAPL --fromyear 2018 --toyear 2023 --cash 10000 --analysis --quant
```

Under the hood, here's what happens in the `runstrategy()` function:

```python
def runstrategy():
  start = time.time()
  args = parse_args()

  # Create directories for reports
  os.makedirs(os.path.join(_REPORTS_DIR, args.strategy), exist_ok=True)
  os.makedirs(os.path.join(_TRADES_DIR, args.strategy), exist_ok=True)
  os.makedirs(os.path.join(_TRANSACTIONS_DIR, args.strategy), exist_ok=True)

  # Set up logging
  # ...

  # Create cerebro engine
  cerebro = bt.Cerebro(cheat_on_open=args.cheat_on_open)

  # Add strategy
  STRATEGY = [_STRATEGIES[args.strategy]]
  for strategy in STRATEGY:
    cerebro.addstrategy(strategy)

  add_analyzers(cerebro)

  # Get stock data
  stock_data_dict = data_reader.get_stock_data(
      args.symbols, args.fromyear, args.toyear, args.interval, args.data_style,
      args.data_dir, args.timezone)

  # Add data to cerebro
  for stock in stock_data_dict:
    cerebro.adddata(stock_data_dict[stock], stock)

  # Set starting cash and commission model
  cerebro.broker.setcash(args.cash)
  cerebro.broker.addcommissioninfo(CommInfoFractional(commission=args.comm))

  # Run backtest
  backtest_finished = cerebro.run()
  backtest = backtest_finished[0]

  # Generate reports
  if args.report:
    create_report_csv(cerebro, backtest, args.strategy)
    create_transactions_csv(cerebro, backtest, args.interval, args.strategy)

  if args.quant:
    symbols = '_'.join(args.symbols)
    output_file_name = os.path.join(
        _REPORTS_DIR, args.strategy,
        f'quantstats-{args.strategy}-{symbols}-{args.interval}.html')
    create_quant_stats(
        backtest_finished, args.strategy, output_file_name, args.interval,
        symbols)

  # Display results
  if args.analysis:
    show_results(cerebro, backtest, beginning_cash)

  if args.plot:
    cerebro.plot(iplot=False)
```

## Output Analysis: Understanding the Results

The framework generates comprehensive performance metrics:

```python
def show_results(cerebro, backtest, beginning_cash):
  analysis = backtest.analyzers.myanalyzer.get_analysis()

  # Calculate performance metrics
  portfolio_value = cerebro.broker.getvalue()
  roi = (int)((portfolio_value - beginning_cash) * 100 / beginning_cash)

  logger.info(f'Final Portfolio Value: {show_numbers(portfolio_value)}')
  logger.info(f'ROI = {roi_s} %')

  # Show win/loss statistics
  logger.info(f"Number of winners: {analysis['won']['total']}")
  logger.info(f"Total profit - winners: {show_numbers(analysis['won']['pnl']['total'])}")
  logger.info(f"Number of losers: {analysis['lost']['total']}")
  logger.info(f"Total loss - losers: {show_numbers(analysis['lost']['pnl']['total'])}")

  # Calculate accuracy
  total_accuracy = (analysis['won']['total'] /
      (analysis['won']['total'] + analysis['lost']['total'])) * 100
  logger.info(f"Total accuracy: {total_accuracy}")

  # Show key metrics
  logger.info(f"Sharpe Ratio: {backtest.analyzers.mysharpe.get_analysis()['sharperatio']}")
  logger.info(f"Max drawdown (pct): {_get_analysis_value('mydrawdown', 'max')['drawdown']:.2f}")
  logger.info(f"SQN: {_get_analysis_value('mysqn', 'sqn'):.3f}")
```

## Why This Framework Matters

### For Individual Traders

With just a few lines of code, you can test sophisticated strategies:

```python
# Test multiple strategies on a single stock
python backtest_runner.py --strategy golden_cross --symbols AAPL --quant
python backtest_runner.py --strategy rsimacd --symbols AAPL --quant
python backtest_runner.py --strategy supertrend --symbols AAPL --quant

# Compare the HTML reports to determine the best approach
```

### For Quants and Researchers

The framework makes it easy to implement custom strategies. All you need to do is:

1. Create a new strategy class that inherits from `bt.Strategy`
2. Add it to the `_STRATEGIES` dictionary
3. Run your backtest

```python
# Add to strategies directory, then add to _STRATEGIES dictionary:
_STRATEGIES['my_custom_strategy'] = MyCustomStrategy
```

### For Teams

The CSV exports create a standardized format for sharing results:

```python
def create_report_csv(cerebro, backtest, strategy):
  # ...
  trades = []
  trade_column = [
      'symbol', 'buy_date', 'buy_price', 'sell_date', 'sell_price', 'size',
      'profit', 'profit_pct'
  ]

  # Extract trade data
  # ...

  # Write to CSV
  report_csv_name = os.path.join(
      _TRADES_DIR, strategy, f'trades-{symbol}.csv')
  with open(report_csv_name, 'wt') as f:
    f.write(','.join(trade_column) + '\n')
    f.write('\n'.join(trades))
    f.write('\n')
```

## Conclusion

This backtesting framework represents a significant time-saver for anyone serious about algorithmic trading. The code examples shared above demonstrate how accessible yet powerful this system is, combining the strengths of `backtrader` with enhanced reporting through `quantstats`.

Whether you're a casual trader exploring technical indicators or a professional quant developing proprietary algorithms, this framework provides the foundation needed to thoroughly validate trading approaches before committing real capital.

In future posts, I'll dive deeper into specific strategies and show how to extend this framework with custom indicators and risk management techniques.

Happy trading!

## Update

I've open-sourced the whole repo at [abhi1010/backtrader-strategies-compendium](https://github.com/abhi1010/backtrader-strategies-compendium).


---

*Disclaimer: This code and analysis are provided for educational purposes only. Always conduct your own analysis and risk management when implementing trading strategies.*