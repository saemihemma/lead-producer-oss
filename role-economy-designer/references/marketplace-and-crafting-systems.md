# Marketplace and Crafting Systems Reference
Deep reference material for marketplaces, currency design, crafting systems, trade routes, and resource distribution.
### Marketplace Mechanics
Design how players exchange value with each other:
- **Order book vs. instant trade**: Do buyers place standing orders, or buy from sell listings instantly?
- **Fee structure**: Who pays? Buyer, seller, or both?
- **Price visibility**: Can players see historical price data?
- **Listing limits**: Can one player list unlimited items, or are there caps?
- **Trading pairs**: What currencies can trade? Cross-currency exchange rate rules?
**Example marketplace design:**
```
Gold marketplace:
  |- Seller lists item at chosen price (e.g., sword for 500g)
  |- Buyer sees listing, accepts instantly (no negotiation)
  |- Seller pays 5% commission (500g - 25g = 475g received)
  |- Buyer pays listed price (500g deducted from wallet)
  |- Fee goes to: sink, faucet, or tax pool|
  |- Daily listing limit: 50 items per player (prevents spam)
Cross-currency exchange:
  |- Ore <-> Ore trades allowed (no profit)
  |- Ore <-> Gold allowed only at market-determined rates
  |- If ore farmers monopolize, price equilibrates supply
  |- System doesn't enforce price caps (market-driven)
Price discovery:
  |- Players see last 100 trades' prices (transparency)
  |- Moving average price calculated daily (reference point)
  |- Anchors expectations; reduces extreme pricing
  |- Does not prevent scarcity-driven spikes
```
### Currency Design
Design what currencies exist and what role each plays:
- **Fungibility**: Can this currency be traded? To whom?
- **Binding**: Once earned, is it account-bound or tradeable?
- **Primary vs. secondary**: Is gold the universal medium, or are there specialized currencies?
- **Inflation vs. scarcity**: How does the currency supply grow?
**Example currency design:**
```
Gold (primary currency):
  |- Universal medium for all trades
  |- Tradeable between players (not bound)
  |- Earned from: farming, quests, marketplace sales
  |- Spent on: repairs, consumables, crafting, marketplace buys
  |- Supply grows with farming; drained by sinks
Reputation (secondary currency):
  |- Earned from: specific activities (faction quests, PvP, exploration)
  |- Bound to account (not tradeable)
  |- Spent on: faction-gated gear, titles, cosmetics
  |- No supply inflation (earned = capped by activity time)
  |- Serves as time-lock: prestigious items only for dedicated players
Ore (resource currency):
  |- Earned from: mining activity only
  |- Tradeable for gold or other ore types
  |- Perishable (degrades over time if not processed)
  |- Supply constrained by mining locations and respawn rates
  |- Creates farming economy; ties into crafting loop
```
## Crafting Ratio Balancing
For each recipe, verify no arbitrage exists:
**Standard rule:** (Sum of input values) = (Output value)
**Example validation:**
```
5 iron ore x 50g = 250g
+ 1 coal x 10g = 10g
= Total input cost: 260g
Output: 1 sword sells to NPC for 250g (or trades at ~250g)
Analysis: Crafter loses 10g per sword (sink). OK Balanced
Implication: Crafting is not a profit method; it converts ore into usable form
```
**Failure rates create sink pressure:**
```
Upgrade recipe: 1 sword (500g) + 1 stone (100g) = potential 600g output
Success rate: 80%
Expected output value: 600g x 0.80 = 480g
Cost to attempt: 600g
Loss on failure: 120g (20% of input)
Over 100 attempts: ~80 successes (480g value each) = 38,400g
Costs: 100 x 600g = 60,000g
Net drain: 21,600g / 100 = 216g loss per upgrade attempted
-> This is a sink, not arbitrage
```
---
## Trade Route Incentives
Design spatial or faction-based trading dynamics:
```
Regional economies (example):
City A (mining hub):
  |- Ore is cheap (500 gold per unit)
  |- Weapons are expensive (2000g, all ore-based)
  |- Miners farm ore here; smiths buy and export
City B (trading hub):
  |- Ore is expensive (600g per unit due to transport)
  |- Weapons are cheaper (1800g after import)
  |- Traders arbitrage ore; locals buy weapons
Incentive mechanics:
  |- Transport cost: 50g per ore (cost to move between cities)
  |- Travel time: 10 minutes (time cost to earn arbitrage)
  |- Profit per ore: 600 - 500 - 50 = 50g per unit
  |- Reward: 50g per ore is worth the 10-minute journey (5g/min)
  |- Result: Ore naturally flows from cheap to expensive, equalizing prices
```
## Resource Distribution
Design how resources enter the world:
```
Geographic gating (example):
Copper ore:
  |- Spawns in green zones (safe, no PvP)
  |- All players can mine
  |- Respawn rate: 1 ore per 5 minutes per node
  |- Easy access, low farming rate -> abundant -> cheap
Silver ore:
  |- Spawns in yellow zones (contested, some PvP)
  |- Level 20+ required
  |- Respawn rate: 1 ore per 10 minutes (slower)
  |- Medium access, medium farming -> moderately scarce -> medium price
Gold ore:
  |- Spawns in red zones (PvP enabled, full loot)
  |- Level 50+ required
  |- Respawn rate: 1 ore per 30 minutes (rare)
  |- High risk, scarce -> expensive
  |- Farming incentive: High risk, high reward
Time-gated access (example):
Rare ore:
  |- Boss drops only (once per 24 hours per player)
  |- Crafting time: 1 week to process (gating scarcity)
  |- Output: Very valuable, limited supply
  |- Ensures prestige items stay exclusive
```
---
## Anti-Patterns to Avoid
**1. "The Optimal Path Bypasses Core Loops"**
- Red flag: Fastest way to wealth avoids intended content (e.g., farmers ignore dungeons, ignore PvP, ignore trading)
- Fix: Make core loops efficient enough to compete with farming
**2. "Converters Create Infinite Value"**
- Red flag: Crafting 5 items yields profit (e.g., buy ore for 100g, craft sword, sell for 150g)
- Fix: Ratio-check every recipe; input cost must >= output value
**3. "Sinks are Optional"**
- Red flag: Players can completely avoid costs and accumulate unbounded wealth
- Fix: Sinks must be mandatory (repair or be unable to fight; pay taxes or lose efficiency)
**4. "Currency Can't Flow to Sinks"**
- Red flag: Players earn gold from farming but have no way to spend it beyond accumulation
- Fix: Design meaningful sinks that drain the faucet's output
**5. "Markets Have No Friction"**
- Red flag: Players place infinite orders, list unlimited items, trade instantly with zero cost
- Fix: Add fees, listing limits, trade delays
**6. "Early Adopters Lock Out Newcomers"**
- Red flag: First week's farmers monopolize rare resources, pricing out all new players
- Fix: Respawn rates should favor newcomers; level gates should lock out early access
## Concrete Output Format
When designing an economy system, produce this structure:
```
ECONOMY DESIGN DOCUMENT
=======================
FAUCETS (Sources)
  |- Mob drops: X gold/hour per player
  |- Quests: Y gold per quest (repeatable/one-time)
  |- Mining: Z ore/hour (scalable with effort)
  |- Crafting output: [list recipes and rates]
SINKS (Drains)
  |- Repair: X% of item durability cost per death
  |- Taxes: Y% marketplace fee / Z% wealth tax
  |- Consumables: X gold/hour spent on potions/buffs
  |- Destruction: [full-loot rules, item decay, etc.]
CONVERTERS (Transformations)
  |- Crafting recipes: [5 ore -> 1 ingot, input = output value]
  |- Upgrades: [input cost = output value + rarity]
  |- Decay/destruction: [failure rates that create sinks]
CURRENCIES
  |- Gold: universal, tradeable, earned and sunk
  |- Ore: tradeable resource, farmed and consumed
  |- [Other specialties: reputation, faction tokens, etc.]
MARKETPLACE
  |- Fee structure: [who pays what %]
  |- Listing limits: [caps per player/per day]
  |- Trading pairs: [what can trade for what]
STOCK-AND-FLOW MODEL
  |- Daily gold faucet per player: +X gold
  |- Daily gold sink per player: -Y gold
  |- Net pressure: +/-Z gold/day (target: ~=0)
LOOP CLOSURE CHECKLIST
  |- [Can gold reach a sink| OK/NO]
  |- [Can ore reach a converter| OK/NO]
  |- [Can every item type be sunk| OK/NO]
  |- [Are there arbitrage loops| OK/NO (should be NO)]
EXPLOIT VULNERABILITY
  |- Botting potential: [Low/Medium/High] + mitigation
  |- Arbitrage paths: [none / [list] + mitigation]
  |- Early-adopter advantage: [limited/unlimited] + mitigation
```
## What This Role Does NOT Do
- **Does NOT predict player behavior.** That's the Behavioral Economist's job. You design the plumbing; they model how players use it.
- **Does NOT set monetary policy.** That's the Economist. You design the pipes; they regulate what flows through them.
- **Does NOT recommend tax rates, monetary policy changes, or fiscal adjustments.** Designs the mechanism (e.g., "a marketplace transaction tax exists as a sink"); the Economist sets the dial (e.g., "the tax rate should be 5% based on inflation").
- **Does NOT balance combat stats.** That's the Game Balance Designer. You don't touch damage formulas, progression curves, or gear power levels-only how currency/resources flow.
- **Does NOT manage live operations.** Once designed, your specs go to engineers and game designers. You don't patch; they do.
- **Does NOT handle real-money trading.** If RMT is a concern, the Economist and Legal team own that.
---
## Review Checklist
When auditing an economy design:
1. **Faucets**: Can you name every source? At what rate?
2. **Sinks**: Can you name every drain? Are they mandatory?
3. **Converters**: Do all recipes preserve value (no arbitrage)?
4. **Circulation**: How fast does gold move per day?
5. **Loop closure**: Can every faucet output reach a sink?
6. **Storage**: Do inventory caps exist? Do they brake accumulation?
7. **Marketplace**: Is friction (fees, limits) sufficient?
8. **Trade routes**: Do geographic/faction incentives exist?
9. **Distribution**: Is resource access fair to newcomers?
10. **Exploit vectors**: Are there infinite loops or arbitrage paths? (Should be: No)
