# Progression and Stat Budgets Reference
Deep reference material for progression systems, power curves, and stat-budget design.
## Your Purview: The Numbers
### Progression Systems
Design how players grow stronger over time:
**Level progression:**
```
Example curve (1-50 levels):
Level  XP_Required  Total_XP  Hours_to_Level  Total_Hours
1      1000         1000      2                2
10     5000         45000     2.5              25
20     15000        150000    3                75
30     30000        450000    4                150
40     50000        1000000   5                250
50     80000        1800000   6                400
Analysis:
  - Early levels fast (2 hours): Early feedback, encourages play
  - Mid levels steady (3-4 hours): Core grind, pacing
  - Late levels slow (5-6 hours): Prestige, time-gates progression
Design intent:
  New player reaches level 20 in ~75 hours (accessible)
  Veteran reaches level 50 in ~400 hours (dedicated players)
  Gap: 325 hours (new player can catch up in 2-3 months of casual play)
```
**Skill point allocation:**
```
Example system:
At level up: Gain 1 skill point
Total points at level 50: 50 skill points
Skill tree example:
  |- Weapons (30 points max): Damage, attack speed, crit
  |- Defense (20 points max): Armor, HP, dodge
  |- Utility (20 points max): Speed, vision, utility abilities
  |- Total cap: 70 points (20 points to allocate freely between trees)
Design intent:
  - Specialization possible (30 in weapons = offensive build)
  - Hybrid builds possible (15 weapons + 15 defense)
  - No perfect build (70 points < 70 total max)
  - Respec allowed (cheap) to encourage experimentation
Cost of respec:
  Free once per week
  100g to respec outside weekly allowance
  Design: Encourages commitment without locking players forever
```
**Prestige/reset systems:**
```
Example progression reset:
At level cap (50), players can prestige:
  - Reset to level 1
  - Gain +5% XP boost
  - Unlock cosmetic "Prestige 1" badge
  - All prestige available (no cap)
Incentive structure:
  First prestige: +5% XP (reaches level 50 in 380 hours instead of 400)
  Fifth prestige: +25% XP (reaches level 50 in 320 hours)
  Tenth prestige: +50% XP (reaches level 50 in 267 hours)
Design intent:
  - Dedicated players feel progression acceleration
  - New catch-up is possible (faster leveling available)
  - Cosmetic reward (badge) shows dedication
  - No gear advantage (only cosmetics)
  - Encourages re-engagement (prestige resets are event-based)
```
### Power Curves
Design how player power increases over progression:
**Power growth by level:**
```
Example weapon damage by level:
Level  Weapon_Damage  Armor  Damage_Reduction
1      10            5      33%
10     20            15     43%
20     40            30     50%
30     70            50     56%
40     120           75     61%
50     200           100    67%
Damage after armor reduction:
Level 1: 10 x (1 - 0.33) = 6.7 DPS
Level 10: 20 x (1 - 0.43) = 11.4 DPS
Level 20: 40 x (1 - 0.50) = 20 DPS
Level 30: 70 x (1 - 0.56) = 30.8 DPS
Level 40: 120 x (1 - 0.61) = 47 DPS
Level 50: 200 x (1 - 0.67) = 66 DPS
Growth analysis:
  1->10: 70% power growth (early acceleration)
  10->20: 75% power growth (steady)
  20->30: 54% power growth (slowing)
  30->40: 53% power growth (slowing)
  40->50: 40% power growth (slow, respects level cap)
Design intent:
  - Early game: Fast progression (feels rewarding quickly)
  - Mid game: Steady (predictable)
  - Late game: Slowing (level 50 isn't 10x level 40, respects balance)
Implications:
  - Level 10 player vs. Level 50: ~6x DPS difference (gap exists)
  - But gap is not insurmountable with skill
  - Veteran can't 1-shot new players (balance remains)
```
**Stat curve types:**
```
LINEAR: Power increases proportionally with level
  Level 10: 100 power
  Level 20: 200 power
  Level 30: 300 power
  Effect: Consistent growth, predictable
EXPONENTIAL: Power increases faster at higher levels
  Level 10: 100 power
  Level 20: 400 power
  Level 30: 900 power
  Effect: Late-game feels powerful, mid-game weak (can create catch-up problems)
LOGARITHMIC: Power increases fast early, slows late
  Level 10: 100 power
  Level 20: 140 power
  Level 30: 160 power
  Effect: New players catch up fast, vets progress slowly (accessible)
SIGMOID: Slow start, fast middle, slow end (S-curve)
  Level 10: 50 power
  Level 20: 150 power
  Level 30: 280 power
  Level 40: 360 power
  Level 50: 380 power
  Effect: Balanced (engaging throughout, cap respects balance)
Choice depends on game intent:
  OK Linear: Consistent, predictable
  OK Exponential: Rewarding late-game, but creates catch-up problems
  OK Logarithmic: Accessible, but vets feel slow
  OK Sigmoid: Balanced across whole game
```
### Stat Budgets
Design total stats available at each tier:
**Example stat budget:**
```
Level 1 character (total stat budget: 100 points):
  |- Strength: 30 (damage output)
  |- Vitality: 30 (HP pool)
  |- Dexterity: 20 (attack speed, dodge)
  |- Intelligence: 10 (utility, magic)
  |- Wisdom: 10 (healing, protection)
Level 50 character (total stat budget: 500 points):
  |- Strength: 150 (damage output)
  |- Vitality: 150 (HP pool)
  |- Dexterity: 100 (attack speed, dodge)
  |- Intelligence: 50 (utility, magic)
  |- Wisdom: 50 (healing, protection)
Design rules:
  1. Budget grows by level (more points available at higher levels)
  2. No stat can exceed 50% of budget (prevents one-stat dominance)
  3. Minimum 1 point per stat (prevents dump-stat optimization)
Implication: A specialized "strength build" gets more damage but less flexibility
```
**Gear stat allocation:**
```
Example: Sword at level 20
Item level: 20 (gear power scales with level)
Stat budget for level 20 gear: 100 points
Item rarity: Uncommon (uses 80% of budget = 80 points)
Stat allocation:
  |- Strength: +40 (main stat, 50% of item budget)
  |- Dexterity: +30 (secondary, 37.5%)
  |- Intelligence: +10 (utility, 12.5%)
  Total: 80 points (leaves 20 unused for rarity flexibility)
Rarity scaling:
  Common (60% of budget): 60 points -> weaker gear
  Uncommon (80% of budget): 80 points -> standard gear
  Rare (100% of budget): 100 points -> powerful gear
  Legendary (120% of budget): 120 points -> very powerful
Design intent:
  - Rare gear is notably better (20% stat advantage)
  - Legendary feels powerful (20% better than rare)
  - But not game-breaking (not 10x better)
  - Encourages seeking upgrades without mandatory grinding
```
