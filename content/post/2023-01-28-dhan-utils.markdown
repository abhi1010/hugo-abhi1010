+++
description = "A comprehensive guide to automating trades with Python and the Dhan Trading API"
title = "Mastering Automated Trading with Python and the Dhan API"
date = "2023-01-28T14:30:00+08:00"
categories = ["finance"]
keywords = ["python", "dhan api", "algorithmic trading", "trading automation", "portfolio management", "trading bot", "order execution", "position management", "financial markets", "stock trading"]
draft = false
tags = ["python", "trading", "automation", "api"]
+++

In today's fast-paced financial markets, algorithmic trading has become increasingly accessible to retail investors. With the right tools and knowledge, you can automate your trading strategies and execute orders with precision. In this post, I'll walk you through a comprehensive Python implementation for interacting with the Dhan trading platform's API, which enables automated order placement, portfolio tracking, and more.

## What is Dhan?

Dhan is an Indian trading platform that provides access to various financial markets through its API. This allows developers and traders to build custom trading applications, automate strategies, and manage portfolios programmatically.

## The DhanTracker: A Python Wrapper for the Dhan API

The code showcased here builds a robust Python wrapper around the Dhan API, encapsulating its functionality into an easy-to-use class called `DhanTracker`. Let's explore the key features of this implementation:

### Core Functionality

1. **Authentication and Connection**: The code initializes a connection to the Dhan API using client credentials.
2. **Order Management**: Place, modify, and cancel orders with various parameters (market/limit, CNC/intraday, etc.).
3. **Portfolio Tracking**: Retrieve information about current holdings, positions, and order history.
4. **Trade Analysis**: Access and analyze trade history and performance data.
5. **After Market Orders (AMO)**: Schedule orders to be executed when the market opens.

### Key Components

#### 1. DhanTracker Class

The central component is the `DhanTracker` class, which provides methods for interacting with all aspects of the Dhan API:

```python
class DhanTracker:
    def __init__(self):
        self.dhan = dhanhq("client_id", TOKEN)

    # Methods for various operations...
```

#### 2. Order Placement

The class implements functions to place various types of orders:

```python
def place_order(
    self,
    security_id,
    qty,
    exchange_segment=dhanhq.NSE,
    transaction_type=dhanhq.BUY,
    quantity=1,
    order_type=dhanhq.MARKET,
    product_type=dhanhq.CNC,
    after_market_order=False,
    price=0,
    trigger_price=0,
    tag=None):
    # Implementation...
```

#### 3. Position and Holdings Management

There are methods to retrieve current positions and holdings:

```python
def get_positions(self):
    positions = self.dhan.get_positions()
    if positions:
        return positions['data']
    else:
        return []

def get_holdings(self):
    holdings = self.dhan.get_holdings()
    if holdings:
        return holdings['data']
    else:
        return []
```

#### 4. Automated Position Closing

One particularly useful feature is the ability to automatically close all positions:

```python
def close_all_assets(
    self,
    assets,
    asset_tag,
    after_market_order=True,
    product_type=dhanhq.INTRA,
    dry_run=True,
    close_column_name='availableQty'):
    # Implementation...
```

#### 5. Data Normalization

The code includes a `NormalizeDataFrame` class to clean and aggregate the data returned by the API:

```python
class NormalizeDataFrame:
    def __init__(self, df):
        self.df = df

    def normalize_trades_df(self):
        # Implementation...

    def normalize_trades_df_by_ticker(self):
        # Implementation...
```

## Utility Functions

Beyond the main classes, there are several utility functions that enhance the functionality:

### 1. Scrip Management

Functions to handle the mapping between security IDs and trading symbols:

```python
def get_dhan_scrips_as_dict_id_as_key(exchange_to_use='NSE'):
    df = get_all_dhan_scripts(exchange_to_use)
    sem_mapping = dict()
    for index, row in df.iterrows():
        sem_security_id = row['SEM_SMST_SECURITY_ID']
        sem_trading_symbol = row['SEM_TRADING_SYMBOL']
        sem_mapping[sem_security_id] = sem_trading_symbol
    return sem_mapping
```

### 2. Debug Information

Functions to log and save debug information:

```python
def show_debug_info(
    info, txn_type, save_to_file=False, save_to_db=False, tag='trial'):
    # Implementation...
```

### 3. Command Line Interface

The code includes an argument parser for command line usage:

```python
def get_args():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument(
        '--view',
        '-v',
        choices=[
            'orders', 'positions', 'holdings', 'trades', 'edis', 'tradebook',
            'test', 'scrips'
        ],
        default='orders',
        required=True,
        help='What info do you want to view')

    # More arguments...

    return parser.parse_args()
```

## Practical Applications

This code can be used for several practical trading applications:

1. **Automated Trading Strategies**: Implement algorithms to place orders based on technical indicators or other signals.
2. **Portfolio Rebalancing**: Automatically adjust your portfolio to maintain desired asset allocations.
3. **After-Hours Order Scheduling**: Set up orders to be executed when the market opens.
4. **Trade Monitoring and Analysis**: Track and analyze your trading history and performance.
5. **Risk Management**: Automatically close positions based on predefined criteria.

## Special Features

### 1. Gainer-Based Decision Making

The code includes logic to avoid selling stocks that are identified as "gainers":

```python
df_gainers = read_gainers_list()
gainer_tickers = df_gainers['ticker'].to_list() if not df_gainers.empty else []

if ticker in gainer_tickers:
    logger.info(f'Not selling {ticker} as it is a Gainer')
    full_update.append(f'{ticker} - Not selling as it is a Gainer')
    continue
```

### 2. Selective Position Closing

The implementation allows for certain tickers to be excluded from automatic closing:

```python
TICKERS_TO_AVOID_CLOSING = ['DEEPAKNTR', 'JUBLFOOD', 'AUBANK', 'KANORICHEM']
```

### 3. Dry Run Mode

The code supports a "dry run" mode that simulates actions without actually executing them:

```python
if not dry_run:
    res = self.place_order(
        security_id,
        qty,
        transaction_type=order_txn_type,
        after_market_order=after_market_order,
        product_type=product_type)
    # Process results...
else:
    full_update.append(f'{ticker} - Not placing order as dry_run = {dry_run}')
```

## Getting Started

To use this code for your own trading automation, you'll need:

1. A Dhan trading account with API access
2. The Dhan API client library (`dhanhq`)
3. Python 3.x with pandas and other dependencies

Once you have these prerequisites, you can:

1. Replace the placeholder authentication credentials
2. Customize the trading logic for your specific strategies
3. Run the script with appropriate command-line arguments

## Conclusion

The Python implementation presented here provides a powerful framework for automating trading activities on the Dhan platform. While the code is complex and feature-rich, it's organized in a way that makes it adaptable to various trading strategies and requirements.

As with any automated trading system, it's important to thoroughly test your implementation with small amounts before deploying it with significant capital. The dry run feature included in the code is particularly useful for this purpose.

By leveraging this code as a starting point, you can build sophisticated trading systems that execute your strategies with precision and consistency, potentially saving time and reducing emotional decision-making in your trading activities.

## Next Steps

Consider extending this framework with:

1. Machine learning models for predictive trading signals
2. Integration with additional data sources for more informed decision-making
3. Advanced risk management features
4. A web interface for easier monitoring and control
5. Notification systems for important events and trade executions

Happy automated trading!