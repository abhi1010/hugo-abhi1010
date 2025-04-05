+++
description = "Triple Momentum Trading Strategy: A Python Implementation"
title = "Upgrading from dual momentum"
date = "2023-03-11T00:33:29+08:00"
categories = ["finance"]
keywords = ["python", "trading", "quant", "quantitative", "finance", "momentum"]
draft = false
tags = ["strategy", "python"]
+++

In the world of algorithmic trading, momentum strategies hold a special place for their simplicity and effectiveness. Today, I want to share a Python implementation of a "Triple Momentum" strategy that I've been working with. This approach allows you to dynamically switch between three different assets based on their relative momentum.

## What is Momentum Trading?

Before diving into the code, let's briefly understand what momentum trading is. The core idea is simple: assets that have performed well recently tend to continue performing well in the near future. By measuring and comparing the momentum of different assets, we can allocate our capital to the one showing the strongest trend.

## The Triple Momentum Approach

The strategy I'm sharing allows you to compare three different assets - typically this could be:
- A primary market index (like NIFTY)
- An alternative asset (like USD/INR currency pair)
- A third option (like Gold)

The algorithm calculates normalized momentum for each asset and allocates 100% of the portfolio to whichever is showing the strongest momentum at the time.

## The Python Implementation

Let's walk through the key components of the implementation:

### Setting Up the Environment

The code uses several popular Python libraries for financial analysis:
- pandas for data manipulation
- yfinance for fetching market data
- matplotlib and plotly for visualization

### Calculating Momentum

The heart of the strategy lies in how we calculate momentum:

```python
def calc_returns(df, suffix=''):
    df = df.copy()

    # Rename columns with suffix
    rename_dict = {col: f"{col}{suffix}" for col in df.columns}
    df = df.rename(columns=rename_dict)

    # Calculate momentum metrics
    returns_col = f'returns{suffix}'
    mean_col = f'mean{suffix}'
    std_col = f'std{suffix}'
    norm_returns_col = f'norm_returns{suffix}'

    df[returns_col] = df[f'Close{suffix}'].pct_change(21)  # 21-day returns
    df[mean_col] = df[returns_col].rolling(4).mean()        # 4-period average
    df[std_col] = df[mean_col].rolling(4).std()             # Standard deviation
    df[norm_returns_col] = df[mean_col] / df[std_col]       # Normalized returns

    return df
```

The key metrics here are:
1. 21-day price returns
2. 4-period rolling average of these returns
3. 4-period standard deviation of the average
4. Normalized returns (mean divided by standard deviation)

This normalization helps compare assets with different volatility profiles on equal footing.

### Determining the Best Asset

Once we have the normalized returns for each asset, we simply identify which one has the highest value:

```python
# Calculate highest returns using aligned comparisons
df_merged['norm_returns_first_is_highest'] = ((norm_first > norm_second) &
                                             (norm_first > norm_third))

df_merged['norm_returns_second_is_highest'] = ((norm_second > norm_first) &
                                              (norm_second > norm_third))

df_merged['norm_returns_third_is_highest'] = ((norm_third > norm_first) &
                                             (norm_third > norm_second))
```

### Portfolio Management

The strategy then calculates portfolio metrics based on the chosen asset:

```python
# Calculate strategy returns (only one position will be active at a time)
df['strategy_returns'] = (
    df['first_position'].shift(1) * df['first_returns'] +
    df['second_position'].shift(1) * df['second_returns'] +
    df['third_position'].shift(1) * df['third_returns'])

df['cumulative_returns'] = (1 + df['strategy_returns']).cumprod()
df['portfolio_value'] = initial_capital * df['cumulative_returns']
```

Notice that we use `shift(1)` to ensure we're making decisions based on previous signals, not current ones, avoiding look-ahead bias.

## Running the Strategy

You can run the strategy with different asset combinations. For example:

```bash
python trading/strategies/triple_momentum.py \
  --main-col NIFTY \
  --main-ticker ^NSEI \
  --alt-col USDINR \
  --alt-ticker USDINR=X \
  --third-col GLD \
  --third-ticker GLD \
  --output-dir data/triple-momentum \
  --initial-capital 100000
```

## Results and Monitoring

The code includes functionality to generate notifications about position changes. Here's how the final output looks:

```
Triple Momentum =
```
Edit: Updated the output to be more readable. Followed by a table showing the prices of the three assets and which one to buy according to the strategy.
According to this sample below, `NIFTY` was a good buy on 02-Apr-2025.

```bash
Triple Momentum :
               NIFTY  USDINR     GLD     BUY
Date
2024-12-11  24641.80   84.87  250.96   NIFTY
2024-12-18  24198.85   84.92  239.26  USDINR
2024-12-19  23951.70   85.17  239.60   NIFTY
2024-12-31  23644.80   85.79  242.13  USDINR
2025-01-31  23508.40   86.65  258.56     GLD
2025-02-05  23696.30   87.13  264.13  USDINR
2025-02-14  22929.25   86.75  266.29     GLD
2025-03-05  22337.30   87.22  269.62  USDINR
2025-03-27  23591.95   86.10  281.97     GLD
2025-04-02  23332.35   85.61  288.16   NIFTY
```

## Key Features of the Implementation

1. **Dynamic Asset Selection**: Automatically switches between three assets based on momentum
2. **Risk Management**: Standard deviation normalization helps account for volatility
3. **Clean Position Switching**: Only trades when momentum leadership changes
4. **Backtesting Capabilities**: Calculates portfolio value over time with initial capital

## Potential Improvements

While this implementation works well as a starting point, here are some ways you might enhance it:

1. Add transaction costs to make the backtest more realistic
2. Implement a trailing stop-loss for each position
3. Add a threshold to prevent excessive switching between assets
4. Incorporate volume or other technical indicators to confirm momentum

## Conclusion

The Triple Momentum strategy offers a straightforward yet powerful approach to asset allocation. By measuring relative momentum across three different assets, you can potentially enhance returns while maintaining a simple trading system.

Remember that any trading strategy should be thoroughly tested with historical data and gradually implemented with proper risk management. No strategy works in all market conditions, and past performance doesn't guarantee future results.

Happy trading!
