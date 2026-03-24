# Monetary Health and Inflation Reference
Deep reference material for money supply, purchasing power, wealth distribution, liquidity, and inflation detection.
## Your Purview: Economic Health
### Monetary Framework
Design and monitor money supply management:
**Money Supply Targets:**
```
Healthy money supply growth = goods production growth rate
Example:
  Week 1: 1M gold in world, 1000 swords in circulation
  Week 2: 1.2M gold in world, 1200 swords in circulation
  -> Money supply +20%, goods +20% -> Price stable OK
  Week 1: 1M gold in world, 1000 swords
  Week 2: 1.5M gold in world, 1000 swords
  -> Money supply +50%, goods +0% -> Inflation incoming NO
```
**Policy levers:**
- **Tax rate adjustments**: Increase % tax on marketplace trades to drain excess gold
- **Sink acceleration**: Increase repair costs, consumable prices, or territory taxes
- **Money supply caps**: Hard limits on total circulating currency (advanced)
- **Interest rates** (if applicable): NPC lending, time-based rewards
- **Quantitative easing**: Strategic injection of resources to combat deflation
**Detection framework:**
```
MONETARY HEALTH CHECK (weekly):
  1. Total gold in world: [measure]
  2. Gold farmed this week: [new sources]
  3. Gold sunk this week: [removed via sinks]
  4. Net change: [sources - sinks]
  5. % growth: [(this week - last week) / last week]
  Targets:
    OK Weekly growth: 0% to +5% (mild, expected)
    OK Volatile weeks: monitor for 2-3 weeks
    NO Weekly growth >10%: ALERT (inflation accelerating)
    NO Weekly decline >5%: ALERT (deflation risk)
```
### Currency Valuation & Purchasing Power
Monitor how much value each unit of currency holds:
**Purchasing Power Parity (Virtual):**
```
What can 1 gold buy|
  Week 1: 1 gold = 0.1 ore (ore at 10g each)
  Week 2: 1 gold = 0.08 ore (ore at 12.5g each)
  -> Purchasing power declined 20% (inflation detected)
Tracking basket of goods:
  Ore: 10g -> 12.5g (+25%)
  Swords: 500g -> 625g (+25%)
  Potions: 5g -> 6.25g (+25%)
  -> Across-the-board inflation of 25% (balanced inflation, not isolated spikes)
```
**Price stability metrics:**
```
CPI equivalent (Consumer Price Index):
  Baseline: Week 1 average prices = 100
  Week 2 average prices = 101-105 (1-5% drift acceptable)
  Week 2 average prices = 120+ (20% drift = hyperinflation risk)
Volatility index:
  Measure standard deviation of price changes across goods
  Low volatility (<5%): Stable, predictable prices
  High volatility (>15%): Players unsure of prices, trading slows
```
### Wealth Distribution Analysis
Monitor for monopoly formation and inequality:
**Gini Coefficient (Inequality Measure):**
```
Gini = 0 (perfect equality): Everyone has same wealth
Gini = 1 (perfect inequality): One player owns everything
Healthy ranges:
  Gini <0.50: High equality (may be TOO equal; no progression feel)
  Gini 0.50-0.65: Healthy inequality (some stratification, but accessible)
  Gini >0.75: DANGER (monopoly forming, wealth trapped)
Example distribution analysis:
  Bottom 50% of players: 10% of total wealth
  50-90%: 25% of total wealth
  90-99%: 35% of total wealth
  Top 1%: 30% of total wealth
  -> Gini ~= 0.60 (healthy)
  Bottom 50%: 1% of wealth
  50-90%: 5% of wealth
  90-99%: 20% of wealth
  Top 1%: 74% of wealth
  -> Gini ~= 0.85 (monopoly emergency)
```
**Wealth percentile tracking:**
```
Track by percentile, not absolute:
P10 (bottom 10%): median wealth = 10k gold
P50 (median): median wealth = 100k gold
P90 (top 10%): median wealth = 500k gold
P99 (top 1%): median wealth = 5M gold
Healthy progression:
  P99 / P10 ratio: 100-500x (top player 100-500x richer than bottom)
Unhealthy progression:
  P99 / P10 ratio: >1000x (extreme gap, newer players hopeless)
Monitor velocity:
  Median wealth growth: +5% per week (healthy)
  Median wealth growth: +20% per week (inflation or compounding)
  Median wealth growth: -5% per week (deflation, hoarding)
```
### Market Structure & Liquidity
Monitor if markets function efficiently:
**Liquidity depth:**
```
Bid-ask spread (difference between buy/sell price):
  Tight spread <1%: Highly liquid, easy to trade
  Medium spread 2-5%: Adequate liquidity
  Wide spread >10%: Illiquid, traders avoid market
Example:
  Sword trading:
  Week 1 market: Bids at 490g, Asks at 510g (2% spread)
  Week 2 market: Bids at 450g, Asks at 550g (10% spread)
  -> Liquidity is declining (fewer active traders)
Volume analysis:
  Weekly marketplace volume: X trades
  Target: Stable volume or growing
  Alert: If volume drops >20% (market abandonment)
Order book depth:
  At current price (500g sword):
    Can I instantly sell 1,000 swords| (check order book)
    Can I buy 1,000 swords instantly|
  Healthy: Yes to both (deep liquidity)
  Unhealthy: Must wait for orders to fill (illiquid)
```
**Price discovery efficiency:**
```
Do prices reflect real supply/demand|
If ore supply increases 50%:
  Efficient market: Ore price drops 10-20% within 1-2 days
  Inefficient market: Price takes 1-2 weeks to adjust (or doesn't)
Monitor price lag:
  Historical price trend vs. current price
  If price is 50% higher than "fair value", bubble likely
```
### Inflation/Deflation Detection
Identify and diagnose price spirals:
**Inflation signatures:**
```
EARLY WARNING (Week 1-2):
  OK Median wealth growing >10%/week
  OK New players report prices rising faster than they earn
  OK Wealth distribution (Gini) widening
  OK Marketplace fees not offsetting faucets
ACTION: Increase sink pressure (taxes, repair costs)
MODERATE (Week 3-4):
  OK Prices rising across all goods (20-50%)
  OK Top players accumulating wealth exponentially
  OK Newer players abandoning economy (can't catch up)
  OK Market volatility increasing
ACTION: Emergency sink increases, monitor daily
SEVERE (Week 5+):
  OK Prices rise faster than wages (workers can't afford anything)
  OK Players shift to barter or alternative currencies
  OK RMT black markets emerge
  OK Economy collapses if unchecked
ACTION: Hotfix sinks, consider wealth reset, or demand destruction event
```
**Deflation signatures:**
```
EARLY WARNING:
  OK Prices dropping >5% week-over-week
  OK Players hoarding (velocity declining)
  OK Farming slowing (not worth the effort)
  OK New players can't get gear (nobody selling)
ACTION: Reduce taxes, increase faucets or activity rewards
MODERATE:
  OK Prices drop 20-50%
  OK Farmers completely stop (farming unprofitable)
  OK Marketplace volume plummets
  OK Players focus on hoarding (velocity <10%)
ACTION: Emergency faucet injection, stimulus spending
SEVERE:
  OK Economy approaches zero activity (no trades, no farming)
  OK Players abandon in droves
  OK Currency becomes worthless (players switch to resources as barter)
ACTION: Full economy reset or radical stimulus
```
