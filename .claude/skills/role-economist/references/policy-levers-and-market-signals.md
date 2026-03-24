# Policy Levers and Market Signals Reference
Deep reference material for equilibrium modeling, RMT risk, fiscal levers, and recurring health checks.
### Equilibrium Modeling
Diagnose whether the economy tends toward stability or spiral:
**General equilibrium analysis:**
```
Supply side:
  - How much ore can be farmed per day|
  - How many swords can be crafted from available ore|
  - What's the maximum sustainable production rate|
Demand side:
  - How many swords do players need/want per day|
  - What's the velocity of swords (how fast they're traded)|
  - Are swords consumed (durability decay) or hoarded|
Equilibrium:
  If supply = demand: Stable price, active market
  If supply > demand: Prices drop (inflation of ore, deflation in gold)
  If supply < demand: Prices rise (scarcity, bottleneck)
Feedback loop:
  Ore expensive -> fewer players farm -> ore becomes scarce -> prices spike
  Ore cheap -> many farm -> oversupply -> prices crash
  Strong negative feedback: Market self-corrects in 1-3 days
  Weak feedback: Takes 1-2 weeks to rebalance
  Broken feedback: Never rebalances (stuck cycle)
```
**Stability assessment:**
```
Stable equilibrium:
  - Small shocks (e.g., +50% farming for 1 day) are absorbed
  - Market adjusts within 1-2 weeks
  - No exponential spirals
Unstable equilibrium:
  - Small shocks create runaway effects
  - Market overshoots and crashes
  - Example: Farm 50% more ore -> ore price crashes -> ALL farmers quit -> ore shortage
Test for stability:
  Scenario: Nerf farming rate by 50%
  Prediction:
    Stable system: Farmers reduce activity, prices rise modestly, economy adjusts
    Unstable system: Farmers quit entirely, markets collapse
```
### RMT (Real Money Trading) Risk
Analyze the implicit exchange rate between virtual and real currency:
**RMT exposure:**
```
If gold is tradeable for real money:
  Current exchange rate: 1M gold = $10 USD
  -> 100k gold = $1
Risk assessment:
  <$1 per 100k gold: Viable RMT market, low gold value
  $1 per 100k gold: RMT spam becomes tempting for farmers
  >$1 per 100k gold: High gold value, RMT black markets explode
Mitigation:
  - Keep gold sinks high (drain value faster)
  - Ban RMT officially, detect and suspend accounts
  - If RMT unavoidable: Accept it, price it into balance
Example concern:
  Farmer earns 100k gold per day
  100k gold = $1 -> $7/week income (tempting for gold spammers)
  -> RMT bots infiltrate, spam messages
  Response: Increase sink rate to drain 100k faster, make farming less valuable
```
### Fiscal Policy Levers
Recommend taxation and subsidy mechanisms:
**Tax design:**
```
Marketplace tax (5-10% per trade):
  Who pays: Seller or buyer|
  When: On transaction completion
  Destination: Sink (gold removed from economy)
  Effect: Reduces high-volume traders; incentivizes hoarding
Wealth tax (0.1-1% per week on accumulated gold >threshold):
  Who pays: Wealthy players
  When: Weekly auto-deduction
  Threshold: To protect new players (only tax top 10%)
  Effect: Discourages hoarding; may cause deflation if too high
Trading tax (% of sale value):
  Per-transaction: Adds friction, reduces churning
  Per-item-type: Can target specific inflation
  Regional: City A taxes higher -> gold flows to cheap regions
Territorial tax (weekly cost to hold land):
  Who pays: Guild or player controlling territory
  Rate: % of territory value or flat fee
  Effect: Balances power (rich can't hoard territory forever)
```
**Subsidies & stimulus:**
```
Activity bonus (temporary):
  "Farming bonus week: +50% ore drops"
  Effect: Boosts faucet during deflation
  Duration: 1-2 weeks only
  Alert: Monitor for over-correction into inflation
NPC buyback programs:
  "We're buying ore at 15g (20% above market) for 1 week"
  Effect: Removes glut, supports farmers
  Risk: If extended, creates artificial price floor
Seasonal grants (one-time):
  "New seasonal reward: 10k gold to all active players"
  Effect: Stimulus injection
  Cost: Usually comes from external funds (real-money operations)
  Risk: Can trigger inflation if not balanced with sink
```
## Framework: Economist's Weekly Health Check
Run this every Monday:
```
ECONOMIC HEALTH DASHBOARD (Weekly)
===================================
MONETARY METRICS:
  [ ] Total gold in world: [measure]
  [ ] Gold farmed this week: [sources total]
  [ ] Gold sunk this week: [sinks total]
  [ ] Net change: [+/- %]
  Status: [OK Healthy / Warning Watch / NO Critical]
PRICE STABILITY:
  [ ] Average price change (basket of goods): [+/-%]
  [ ] Volatility (std dev of price changes): [%]
  [ ] CPI equivalent (vs. baseline): [index]
  Status: [OK Stable / Warning Drift / NO Volatile]
WEALTH DISTRIBUTION:
  [ ] Gini coefficient: [0.0-1.0]
  [ ] Top 1% wealth %: [X%]
  [ ] P99/P10 ratio: [X times]
  [ ] New player catch-up time: [X weeks to 50th percentile]
  Status: [OK Healthy / Warning Concentrating / NO Monopoly]
MARKETPLACE LIQUIDITY:
  [ ] Weekly trade volume: [X trades]
  [ ] Bid-ask spread (median): [X%]
  [ ] Order book depth: [healthy/depleted]
  [ ] Market abandon risk: [low/medium/high]
  Status: [OK Liquid / Warning Tightening / NO Illiquid]
VELOCITY:
  [ ] Median wealth growth rate: [+/-%/week]
  [ ] Daily circulation (% of gold traded): [X%]
  [ ] Hoarding rate (wealth locked 30+ days): [X%]
  Status: [OK Healthy / Warning Declining / NO Stagnant]
CRITICAL ALERTS:
  [ ] RMT risk score: [1-5]
  [ ] Deflation pressure: [low/medium/high]
  [ ] Inflation pressure: [low/medium/high]
  [ ] Monopoly forming: [low/medium/high]
RECOMMENDATION:
  [No action / Monitor / Adjust sinks / Boost faucets / Emergency intervention]
```
## Concrete Output Format
When presenting economic analysis:
```
ECONOMIC ASSESSMENT REPORT
===========================
CURRENT STATE:
  - Money supply: 50M gold (+15% week-over-week) Warning
  - Average prices: Up 12% (CPI 112) Warning
  - Gini coefficient: 0.68 (inequality rising) Warning
  - Top 1% wealth: 35% of total (above target 25%) Warning
  - Marketplace volume: Stable at 1000 trades/day OK
ROOT CAUSE ANALYSIS:
  1. Farming rate (faucet) increased in last patch
  2. Repair costs (sink) were not adjusted
  3. Net result: +2M gold/week entering economy
  4. Prediction: Hyperinflation if unchecked in 4 weeks
POLICY RECOMMENDATION:
  Immediate (this week):
    - Increase marketplace tax: 5% -> 7% (-0.5M gold/week)
    - Increase repair costs: 10% -> 15% (-0.7M gold/week)
  Result: Net flow -> -0.2M/week (deflation pressure)
  Monitor: 2-3 weeks for rebalancing
  If still rising after 3 weeks:
    - Implement 0.5% weekly wealth tax on top 10% (confiscates hoards)
    - Or reduce farming rate to pre-patch levels
    - Or accelerate consumable sink (higher potion prices)
MONITORING:
  Check daily: Median wealth growth rate
  Alert threshold: >10%/week (escalate to critical)
  Rebalancing window: Monitor 2-3 weeks post-adjustment
```
## What This Role Does NOT Do
- **Does NOT design the system.** That's the Economy Designer. You monitor what they built.
- **Does NOT set progression curves or combat balance.** That's the Game Balance Designer.
- **Does NOT predict player psychology or behavior.** That's the Behavioral Economist. You model the rational incentives; they model how players actually respond.
- **Does NOT implement policy changes.** Engineers and game designers execute your recommendations.
- **Does NOT manage real-money transactions or payment systems.** That's Finance and Compliance.
---
## Reference: Policy Levers at a Glance
| Problem | Lever | Effect | Risk |
|---------|-------|--------|------|
| Inflation | Increase tax rate | Drain gold faster | May hurt traders |
| Inflation | Increase repair costs | Create mandatory sink | May frustrate PvP |
| Inflation | Reduce faucet (farm rate) | Less gold enters | Farmer resistance |
| Deflation | Reduce tax rate | Encourage trading | May flip to inflation |
| Deflation | Reduce repair costs | Encourage activity | PvP-light players suffer |
| Deflation | Increase faucet | Boost farming | Inflation risk |
| Deflation | Inject stimulus | One-time gold grant | Short-term fix only |
| Monopoly | Implement wealth tax | Redistribute from top 1% | Political backlash |
| Monopoly | Cap marketplace price | Force fair trade | Market distortion |
| Monopoly | Reduce early-adopter advantage | Nerf past gains | Trust erosion |
| Liquidity crisis | Reduce trade friction | Encourage marketplace | May increase spam |
| Bubble | Increase sink on luxury items | Drain speculative wealth | May crash collector value |
---
## Monitoring Checklist
Each week, verify:
- [ ] Money supply tracking: Faucets vs. sinks aligned?
- [ ] Price trend: CPI stable or drifting?
- [ ] Wealth concentration: Gini acceptable?
- [ ] Market volume: Healthy activity level?
- [ ] Velocity: Gold circulating, not hoarded?
- [ ] New player catch-up: Achievable progression?
- [ ] RMT risk: Implicit exchange rate reasonable?
- [ ] Feedback loops: Market self-correcting or spiraling?
- [ ] Policy levers: Any adjustments needed?
- [ ] Alert thresholds: Any triggered?
