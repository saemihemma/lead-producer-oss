# PvP, TTK, and Fairness Reference
Deep reference material for combat balance, difficulty tuning, destruction mechanics, and catch-up systems.
### Combat Balance
Design damage formulas, TTK, and fairness:
**Damage calculation:**
```
Example formula:
  Damage = (Weapon_Damage + Strength_Bonus) x (1 + Crit_Chance) - Armor_Reduction
Sample calculation:
  Player A (level 20 warrior):
    Weapon damage: 40
    Strength bonus: +30
    Crit chance: 10% (1.1x multiplier)
    Total damage: (40 + 30) x 1.1 = 77 damage
  Enemy (level 20 mob):
    Armor reduction: 30% (0.7x multiplier)
    Effective damage taken: 77 x 0.7 = 54 damage per hit
TTK calculation (time to kill):
  Enemy health: 200 HP
  Time to kill: 200 / 54 = 3.7 hits ~= 7.4 seconds (at 2 hits/second)
Design targets for balance:
  OK TTK 5-10 seconds: Feels responsive, skill-based
  NO TTK 1 second: Too quick, luck-based (no skill expression)
  NO TTK 30+ seconds: Boring, grindy, tests patience not skill
Adjustment levers:
  - Increase damage: Reduces TTK (faster kills)
  - Increase armor: Increases TTK (longer fights)
  - Increase attack speed: Increases DPS (more hits/second)
  - Increase health: Increases TTK (longer fights)
```
**Damage type balance:**
```
Example system: 3 damage types, 3 resistances
Swords deal slashing damage:
  |- Very effective vs. cloth armor (90% armor reduction -> 10% gets through)
  |- Weak vs. heavy armor (70% reduction -> 30% gets through)
Spears deal piercing damage:
  |- Weak vs. cloth armor (95% reduction -> 5% gets through)
  |- Very effective vs. heavy armor (50% reduction -> 50% gets through)
Magic deals elemental damage:
  |- Effective vs. cloth AND heavy (75% reduction -> 25% gets through)
  |- Weak vs. magical armor (85% reduction -> 15% gets through)
Balance check:
  Sword user vs. clothed enemy: High damage (good)
  Sword user vs. heavy enemy: Low damage (must adapt)
  -> Forces build diversity (can't one-build everything)
Design intent:
  - No "always best" weapon (all are situational)
  - Players encouraged to carry multiple weapons or specs
  - Counters create interesting PvP dynamics
```
**PvP fairness:**
```
Gear advantage vs. skill advantage:
Example matchup:
  Player A: Level 50, legendary gear (+20% stats vs. common gear)
  Player B: Level 30, common gear
Raw power difference:
  Level difference: 20 levels = ~2x power difference
  Gear difference: +20% advantage
  Combined: ~2.4x power difference
Is this fair|
  NO Not for 1v1 PvP (level 30 has no chance)
  OK For world PvP with escape mechanics (can run away)
  OK For group PvP (teammates help, not 1v1)
Mitigation strategies:
  1. Gear normalization: PvP brackets normalize gear (removes gear advantage)
  2. Skill-based ranking: Ladder separates skilled from casuals
  3. Asymmetric balance: Higher level can't "gank" lower level (hard limit)
  4. Penalty zones: World PvP only in contested zones (safer travel available)
Design intent: Choose based on game philosophy
  - Hardcore: Level/gear advantage is real, play at own risk
  - Casual: Skill matters most, gear/level is negligible
  - Balanced: Gear/level advantage exists but not insurmountable
```
### Difficulty Scaling
Design challenge escalation:
**Enemy scaling by zone:**
```
Zone design (world regions):
Safe zone (starter area):
  |- Mob level: 1-5
  |- DPS per mob: 5 damage/second
  |- Health per mob: 50 HP (TTK ~= 10 seconds)
  |- Reward: 10 gold per mob
  |- Difficulty: Tutorial level
Yellow zone (mid-game area):
  |- Mob level: 20-30
  |- DPS per mob: 30 damage/second
  |- Health per mob: 300 HP (TTK ~= 10 seconds)
  |- Reward: 100 gold per mob
  |- Difficulty: Requires gear, skill
Red zone (dangerous area):
  |- Mob level: 40-50
  |- DPS per mob: 80 damage/second
  |- Health per mob: 800 HP (TTK ~= 10 seconds)
  |- Reward: 500 gold per mob
  |- Difficulty: Requires team or high skill
Design pattern:
  - TTK stays consistent (~10 seconds)
  - Reward scales with difficulty (5x reward = 5x harder)
  - All zones have same "feel" (not arbitrarily harder)
  - Progression feels natural (not sudden difficulty cliffs)
Catch-up mechanic:
  New player in yellow zone: Struggles early, improves with leveling
  Veteran in yellow zone: Trivial, moves to red zone for challenge
  -> Zones remain engaging across entire level range
```
**Difficulty curves (scaling by player level):**
```
Scaling approach 1: HORIZONTAL (all zones same difficulty)
  Zone designed for level 20
  Level 10 player: Too hard (dies frequently)
  Level 50 player: Too easy (trivial)
  Problem: New/old players have wrong challenge level
Scaling approach 2: VERTICAL (zones scale with player)
  Zone designed for current player level
  Level 10 player: Zone mobs are level 10 (appropriate difficulty)
  Level 50 player: Zone mobs are level 50 (appropriate difficulty)
  Problem: No sense of progression (always same difficulty)
  -> But rewards also scale, so progression exists numerically
Scaling approach 3: BRACKETED (multiple difficulty tiers)
  Zone A (Easy): Mobs level 5-15, low reward
  Zone B (Normal): Mobs level 15-35, medium reward
  Zone C (Hard): Mobs level 35-50, high reward
  Zone D (Nightmare): Mobs level 50+ elite, extreme reward
  Solution: Players pick difficulty, mix of scaling and choice
Design choice for EVE Frontier (assume):
  OK Bracketed approach (safe/yellow/red zones = difficulty tiers)
  OK Skill-based variance (experienced players do better in same zone)
  OK Gear-based variance (better gear -> better performance)
```
### Destruction & Loss Mechanics
Design how death, durability, and loss feel:
**Death penalty (full-loot vs. item durability):**
```
System 1: FULL-LOOT (lose items on death)
  Death mechanic:
    - All items in inventory dropped at death location
    - Players can retrieve if they get back (corpse retrieval)
    - Alternative: Permanent loss to killer
  Severity: EXTREME
  Engagement: High (stakes matter)
  Player retention: Low (frustrating losses)
  Balance: Requires rebalancing economics entirely (different faucets/sinks)
System 2: ITEM DURABILITY (gear degrades, must repair)
  Death mechanic:
    - Items lose 20% durability on death
    - Repair costs: 100 gold to restore 20% durability
    - Can still use degraded items (reduced effectiveness)
  Severity: MODERATE
  Engagement: Medium (cost to death, but not permanent loss)
  Player retention: Better (frustrating, but recoverable)
  Balance: Creates consistent sink (repairs are mandatory)
System 3: SOFT PENALTY (XP loss, temporary debuff)
  Death mechanic:
    - Lose 5% XP progress on death
    - Temporary "weakened" debuff for 5 minutes (reduced damage)
    - No items lost
  Severity: MILD
  Engagement: Low (death doesn't matter much)
  Player retention: High (forgiving for new players)
  Balance: May need other sinks (death doesn't drain enough)
Design choice (for full-loot PvP):
  OK Item durability (full-loot is too harsh, durability provides stakes with recovery)
  OK Durability on death (creates consistent sink pressure)
  OK Durability on extended use (passive sink even for non-dying players)
  OK Repair costs scale with gear quality (rare items expensive to repair)
```
**Durability mechanics:**
```
Example durability system:
Item: Steel sword
  |- Max durability: 100
  |- Current durability: 85/100 (85%)
  |- Durability loss per death: 20 points (20% per death)
  |- Durability loss per 1 hour combat: 5 points (5% per hour)
  |- Repair cost: 10 gold per durability point -> 150 gold to full repair
  |- Effectiveness: Damage reduced by (100 - current)/100
     At 85 durability: 15% damage reduction (still usable)
     At 40 durability: 60% damage reduction (very weak)
Repair mechanics:
  - Can repair at NPC vendors (instant, costs gold)
  - Can craft repairs at crafting station (slower, costs materials)
  - Can enchant to reduce decay rate (cosmetic, luxury upgrade)
Design intent:
  - Active drain (combat usage = durability loss)
  - Death penalty (major durability hit)
  - Crafting sink (repairs require gold or materials)
  - Pressure to play (ignore repairs, effectiveness drops -> motivation to repair)
```
### Catch-up Mechanics
Design how new/returning players reach competitive parity:
**Catch-up by leveling speed:**
```
Example progression rates:
New player (no gear, no skill):
  |- Leveling rate: 1 level per 8 hours (base rate)
  |- Time to level 20: 160 hours (~5 weeks casual)
  |- Time to level 50: 400 hours (~12 weeks casual)
Returning player (has old gear, some skill):
  |- Leveling rate: 1 level per 6 hours (25% faster with gear)
  |- Time to level 20: 120 hours (~4 weeks)
  |- Time to level 50: 300 hours (~9 weeks)
Veteran player (optimized, max skill):
  |- Leveling rate: 1 level per 5 hours (37.5% faster with efficiency)
  |- Time to level 20: 100 hours (~3 weeks)
  |- Time to level 50: 250 hours (~7 weeks)
Design intent:
  - Catch-up exists (faster players reach cap faster)
  - But catch-up is not broken (new player still reaches cap in ~3 months)
  - Gap narrows over time (all players eventually reach cap)
  - New players don't feel left behind permanently
```
**Catch-up by gear quality:**
```
Example catch-up gear tier:
"Starter legendary" items:
  |- Obtainable by: Level 20+ players only
  |- Power: 120 stat points (90% of level 50 rare gear)
  |- Method: Quest reward (not crafted)
  |- Purpose: Jump new players to competitive gear level
  Design intent: New player reaches level 20 -> gets legendary starter gear -> competitive with level 25 vets in same tier
Scaling catch-up:
  Level 20 -> Legendary starter gear (90% power of level 50 rare)
  Level 30 -> Catch-up epic gear (90% power of level 50 legendary)
  Level 40 -> Catch-up mythic gear (90% power of level 50 mythic)
  Pattern: Always 1 tier behind, but always 90% power of best-in-slot
  Implication: Catch-up is good, but best gear still requires investment
```
**Seasonal reset/ladder:**
```
Example seasonal economy:
Seasonal ladder:
  |- Every 3 months: Economy resets
  |- All gear/gold: Wiped (players start fresh)
  |- Cosmetics/titles: Preserved (account progression shown)
  |- Goal: Eliminate permanent early-adopter advantage
Design intent:
  - Prevents wealth concentration (all players start equal)
  - Lets new players compete without 1-year disadvantage
  - Cosmetics show dedication (veteran status visible)
  - Gold/gear race makes each season fresh
Hardcore alternative (no reset):
  - Permanent economy
  - Advantage accumulates forever
  - New players accepted as second-class
  - Requires stronger catch-up mechanics instead
```
