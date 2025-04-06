+++
description = "Understanding Backtrader's StrategyForComparison: A Comprehensive Guide to Building Flexible Trading Systems"
title = "Making the Most of Backtrader's Strategy Class: A Deep Dive into StrategyForComparison"
date = "2022-04-06T00:00:00+08:00"
categories = ["finance"]
keywords = ["python", "backtrader", "algorithmic trading", "trading strategy", "technical analysis", "ATR", "trailing stops", "bracket orders", "relative strength", "position sizing", "risk management", "backtesting"]
draft = false
tags = ["python", "backtrader", "algorithmic-trading", "trading-strategies", "technical-analysis", "risk-management"]
+++

If you're serious about algorithmic trading and backtesting in Python, you've likely encountered Backtrader - an excellent framework that gives you the freedom to test trading strategies with historical data. Today, I want to walk through a comprehensive strategy implementation I've been working with called `StrategyForComparison`. This strategy showcases many of Backtrader's powerful features while implementing a flexible trading approach with various risk management options.

## Understanding the Core Strategy

`StrategyForComparison` is designed to be a flexible trading framework with multiple configurable components. At its core, it:

1. Uses ATR (Average True Range) for volatility-based position sizing
2. Can filter trades based on relative strength
3. Offers multiple order management approaches including trailing stops and bracket orders
4. Implements various risk management techniques

Let's break down each component to understand how they can be used in your own trading systems.

## Position Sizing and Cash Management

The strategy offers two approaches to position sizing:

```python
def buy_by_size(self):
    if self.fixed_sizing:
        amount_to_invest = min(self.broker.cash * 0.85, self.initial_broker_cash)
    else:
        amount_to_invest = self.broker.cash * 0.85
```

This gives you two options:
- **Fixed sizing**: Uses a consistent amount for each trade (capped at 85% of initial broker cash)
- **Proportional sizing**: Always uses 85% of the current available cash

This feature is particularly useful when testing different position sizing methods. Fixed sizing helps isolate strategy performance from compounding effects, while proportional sizing allows your account to naturally compound over time.

## Order Management Options

One of the most powerful aspects of this strategy is its flexible order management system. It offers three main approaches:

### 1. Trail Orders

```python
if self.enable_trails:
    buy_order = self.buy(size=size, transmit=False, exectype=bt.Order.Market)
    trail_amount = px * self.trail_percent
    self.trail_order = self.sell(
        exectype=bt.Order.StopTrail,
        trailamount=trail_amount,
        size=size,
        parent=buy_order)
```

This creates a trailing stop that follows the price up as it moves in your favor, helping to lock in profits while allowing winners to run.

### 2. Bracket Orders

```python
elif self.use_bracket:
    validity = datetime.timedelta(self.validity_days)
    bracket_validity = datetime.timedelta(self.bracket_validity_days)

    buy_order = self.buy_bracket(
        size=size,
        price=px,
        valid=validity,
        stopprice=self.get_bracket_stop_price(),
        stopargs=dict(valid=bracket_validity),
        limitprice=self.get_bracket_limit_price(),
        limitargs=dict(valid=bracket_validity),
    )
```

Bracket orders automatically set both a take-profit and stop-loss level when entering a position, creating a complete trade management system in a single order.

### 3. Standard Orders with Optional Stop Loss

```python
else:
    buy_order = self.buy(size=size, exectype=bt.Order.Market)

    if self.stop_loss:
        stop_price = px * (1.0 - self.stop_loss)
        self.stop_order = self.sell(
            exectype=bt.Order.Stop, size=size, price=stop_price)
```

This offers a simpler approach with a market entry and optional stop loss.

## Relative Strength Filtering

The strategy can filter trades based on relative strength, which is a popular method for finding strong performers:

```python
def is_relative_strength_valid(self):
    if self.filter_by_relative_strength:
        dt_str = self.get_curr_date_str()
        px_close = self.data.close
        rs_val = self.get_rs()
        logger.info(f"Buying 00 <{dt_str}>; at: {px_close}; rs_val={rs_val}")
        return rs_val > 0
    return True
```

This allows you to only take trades when the relative strength indicator is positive, potentially improving your win rate by focusing on stronger performers.

## Practical Use Cases

### 1. Testing Different Exit Strategies

By toggling between trailing stops and bracket orders, you can compare which exit strategy works best for your trading approach:

```python
strategy = StrategyForComparison(
    enable_trails=True,  # Use trailing stops
    use_bracket=False,   # Don't use bracket orders
    trail_percent=0.1    # 10% trailing stop
)

# vs

strategy = StrategyForComparison(
    enable_trails=False,
    use_bracket=True,
    # ATR-based stop and limit prices will be used
)
```

### 2. Comparing Position Sizing Methods

```python
# Fixed position sizing
strategy = StrategyForComparison(
    fixed_sizing=True
)

# vs

# Proportional position sizing
strategy = StrategyForComparison(
    fixed_sizing=False
)
```

### 3. Evaluating Relative Strength as a Filter

```python
# With RS filter
strategy = StrategyForComparison(
    filter_by_relative_strength=True,
    relative_strength_offset=55
)

# vs

# Without RS filter
strategy = StrategyForComparison(
    filter_by_relative_strength=False
)
```

### 4. Risk Management Experimentation

```python
# With fixed stop loss
strategy = StrategyForComparison(
    enable_trails=False,
    use_bracket=False,
    stop_loss=0.05  # 5% stop loss
)

# vs

# With ATR-based brackets
strategy = StrategyForComparison(
    use_bracket=True
)
```

## Advanced Features

### Order State Management

The strategy carefully tracks order states to prevent overlapping buy/sell signals:

```python
def are_orders_in_flight(self):
    if self.sell_in_progress or self.buy_in_progress:
        logger.info(
            f'<{self.counter}>: <{self.data.datetime.datetime(0)}>: Buy/Sell in progress '
            f'; IsBuy={self.buy_in_progress}; IsSell={self.sell_in_progress}')
        return True
    return False
```

This is crucial for preventing multiple conflicting orders that could cause issues in live trading.

### Extensibility Points

The strategy has several methods designed for subclassing and extension:

- `can_buy()` - Override to add custom buy conditions
- `can_sell()` - Override to add custom sell conditions
- `get_bracket_limit_price()` - Customize take-profit levels
- `get_bracket_stop_price()` - Customize stop-loss levels

## Implementation Tips

When using this strategy, consider these tips:

1. **Logging Configuration**: The strategy has extensive logging - adjust the logger level to control verbosity
2. **Parameter Tuning**: Many parameters can be optimized - consider using Backtrader's built-in optimization features
3. **Indicator Integration**: While this strategy uses ATR, it can be extended with additional indicators
4. **Relative Strength Data**: Ensure your RS data files are properly formatted and located in the expected directory

## Conclusion

The `StrategyForComparison` class demonstrates how to build a flexible, robust trading strategy framework in Backtrader. By combining various order types, position sizing methods, and filtering techniques, it provides a solid foundation for systematic trading experimentation.

Whether you're just getting started with algorithmic trading or looking to enhance your existing strategies, this code provides valuable patterns and techniques to incorporate into your own trading systems.

Remember that backtesting is just the first step - always paper trade and rigorously validate your strategies before deploying them with real capital. Happy trading!


## Update

I've open-sourced the whole repo at [abhi1010/backtrader-strategies-compendium](https://github.com/abhi1010/backtrader-strategies-compendium).


---

*Disclaimer: This code and analysis are provided for educational purposes only. Always conduct your own analysis and risk management when implementing trading strategies.*