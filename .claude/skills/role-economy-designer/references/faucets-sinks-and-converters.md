# Faucets, Sinks, and Converters Reference
Deep reference material for structural resource flows, stock-and-flow modeling, and loop closure.
## Your Purview: The Pipes
### Faucets (Sources)
Design where value enters the economy. Be explicit about:
- **What resource enters?** (Gold, ore, crafting materials, reputation, XP)
- **At what rate?** (e.g., 100 gold per mob kill, 50 ore per 10 minutes mining)
- **Who accesses it?** (All players? Level-gated? Time-gated? Activity-gated?)
- **Is it repeatable?** (Daily quests reset; boss loot drops once per day per player; farming is infinite)
- **What activity triggers it?** (Combat, gathering, trading, crafting, socializing?)
**Example faucet design:**
```
Mob drops:
  |- Enemies spawn continuously
  |- Kill drops 10-20 gold at random
  |- All players can access (no level gate)
  |- Rate: ~100 gold per hour of combat
Quest rewards:
  |- Daily quest: 500 gold (resets every 24h)
  |- Level-gated (accessible to level 10+)
  |- One-time repeatable
  |- Total: 500 gold per player per day
Crafting output:
  |- Swords crafted from 5 iron + 1 coal
  |- Output value must match input value (no profit)
  |- Serves as converter, not faucet
```
### Sinks (Drains)
Design where value leaves the economy permanently. Sinks must be:
- **Mandatory or near-mandatory**: Players cannot avoid them indefinitely
- **Frequent**: Value leaves regularly, not once per year
- **Proportional to gameplay**: More engaged players pay more sink cost
Common sinks:
- **Repair costs**: % of item durability lost per death or extended use
- **Taxes**: % on marketplace sales, or wealth tax on accumulated currency
- **Consumables**: Potions, ammunition, buffs that are consumed in play
- **Destruction mechanics**: Full-loot PvP, item decay
- **Crafting loss**: Upgrade failures destroy inputs
- **Marketplace fees**: % cut on each trade
- **Territory upkeep**: Weekly cost to hold claimed land
**Example sink design:**
```
Repair costs:
  |- Death: Item durability drops 20%
  |- Repair cost: 100 gold per 20% durability restored
  |- Mandatory (no play without repairs)
  |- High-activity players repair more (natural throttle)
Marketplace tax:
  |- Seller pays 5% on each trade
  |- Example: Sell sword for 500g -> pay 25g tax
  |- Applies to all trades (unavoidable)
  |- Tax accumulates as economy activity increases
Consumables:
  |- Health potion: 1 gold per use, used ~5 times per hour combat
  |- Buff potions: 10 gold for 1-hour duration
  |- ~50-100 gold per hour consumed in active PvP
```
### Converters (Transformations)
Design crafting, refining, and upgrading mechanics. Converters should:
- **Preserve value**: Input cost ~= Output value (no arbitrage)
- **Be ratio-balanced**: Clear, predictable exchange rates
- **Serve a purpose**: Players craft because output is needed or desired, not for profit
- **Have meaningful friction**: Crafting takes time, requires materials, maybe has failure rates
**Key rule: Input value must equal output value to prevent arbitrage.**
**Example converter design:**
```
Iron Ore -> Iron Ingot:
  Input: 2 iron ore (50g each) = 100g
  Output: 1 iron ingot = 100g
  Rule: Ore is plentiful, ingot is standardized input for weapons
Sword Crafting:
  Input: 5 iron ingot (100g each) + 1 coal (10g) = 510g
  Output: 1 iron sword (vendored at 500g, tradeable at market price)
  Rule: Sword sells for slightly less than input (crafter absorbs 10g cost)
Weapon Upgrade:
  Input: 1 iron sword (500g) + 1 upgrade stone (200g) = 700g
  Output: 1 steel sword (vendored at 700g, higher damage)
  Rule: Material cost equals output value; damage bump is only differentiator
  Success rate: 95% (5% failure rate = resource loss)
Deconstruction (reverse):
  Input: 1 steel sword (700g) -> Output: 50% of materials back = 350g
  Rule: Incentivizes crafting new rather than recycling; prevents perfect loops
```
---
## Stock-and-Flow Model
For each resource, map the complete journey:
```
GOLD FLOWS (example):
Faucets -> Gold enters
  |- Mob kills: 1000 gold/hour/player (farming)
  |- Daily quest: 500 gold/player
  |- Marketplace: sales revenue (varies)
  |- Total daily: ~30,000 gold/active player
Storage -> Gold accumulated
  |- Wallets: unlimited capacity
  |- Banks: 10M cap (inventory limit)
  |- Active circulation: 50% of total
Converters -> Gold transforms
  |- Crafting: gold spent on materials, time cost
  |- Trading: gold exchanges for items (no creation/destruction)
  |- Upgrades: gold part of recipe
Sinks -> Gold leaves
  |- Repair costs: 500 gold/hour (high-activity players)
  |- Marketplace tax: 5% of all trades
  |- Consumables: 100 gold/hour (potions, buffs)
  |- Taxes: 0.1% weekly wealth tax
  |- Total daily: ~20,000 gold/active player
Net pressure per hour:
  Sources: +1000g/hour (farming)
  Sinks: -600g/hour (repairs, consumables, taxes)
  Balance: +400g/hour (mild inflation)
  -> Acceptable if sources/sinks stay in ratio
```
---
## Loop Closure Verification
Ensure every faucet can reach a sink. This prevents value accumulation disasters:
```
Gold faucet -> can be sunk|
  |- Farmer earns 1000 gold/hour
  |- Spends 500 gold/hour on repairs
  |- Spends 100 gold/hour on consumables
  |- Remaining 400 gold/hour -> ||| (must reach a sink)
  Possible sinks:
    OK Marketplace taxes (0.5g per 100g trade)
    OK Wealth tax (1% per week)
    OK Crafting costs (building gear)
    OK Territory upkeep (pay to keep land)
  If no sink available: inflation spirals
  -> Design must ensure: deltaGold = Sources - Sinks ~= 0
Ore faucet -> can be converted|
  |- Miners earn 100 ore/hour
  |- Ore must be convertible to either:
  OK Usable items (weapons, armor)
  OK Gold (vendor NPC or marketplace)
  OK Higher-tier ore (refinement)
  If ore has no sink: ore inflation, marketplace collapse
  -> Design must ensure: Path to value exists
```
