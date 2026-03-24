# Evaluation Checklists Reference
Deep reference material for balance audits, output formats, quick metrics, and monitoring.
## Framework: Balance Designer's Audit
When analyzing balance, run this checklist:
```
BALANCE AUDIT CHECKLIST
=======================
PROGRESSION:
  [ ] Is leveling speed reasonable (not too fast, not too slow)|
  [ ] Do skill points feel meaningful (not just cosmetic allocations)|
  [ ] Can players respec cheaply (encourages experimentation)|
  [ ] Is prestige optional (doesn't feel mandatory)|
  Recommendation: [Adjust XP rate / Fix skill point mechanics / Reduce respec cost]
POWER CURVES:
  [ ] Is power growth smooth (no sudden cliffs)|
  [ ] Do late-game players feel powerful but not godlike|
  [ ] Can new players challenge veterans with skill|
  [ ] Is level 50 not 10x level 40 (respects balance)|
  Recommendation: [Adjust damage scaling / Reduce power gap / Smooth curve shape]
STAT BUDGETS:
  [ ] Do stat budgets grow appropriately with level|
  [ ] Are builds diverse (no one "optimal" stat allocation)|
  [ ] Can hybrid builds exist (not forced specialization)|
  [ ] Is rarity meaningful (rare gear notably better)|
  Recommendation: [Rebalance budget distribution / Make rare feel rare / Allow hybrids]
COMBAT BALANCE:
  [ ] Is TTK (time to kill) in healthy range (5-10 seconds)|
  [ ] Do all damage types have roles (no obviously best type)|
  [ ] Is PvP fair (skill > gear, but gear matters)|
  [ ] Are resistances working (counters exist)|
  Recommendation: [Adjust damage formulas / Balance damage types / Reduce gear advantage]
DIFFICULTY SCALING:
  [ ] Does difficulty scale smoothly (no sudden cliffs)|
  [ ] Are zones challenging but not impossible|
  [ ] Do veteran players feel challenged|
  [ ] Do new players have tutorialzones|
  Recommendation: [Add intermediate zones / Adjust mob stats / Smooth difficulty curve]
DESTRUCTION & LOSS:
  [ ] Does death sting (meaningful penalty)|
  [ ] But not break the game (can recover)|
  [ ] Are sinks working (durability creates consistent drain)|
  [ ] Are repair costs reasonable (not crushing)|
  Recommendation: [Adjust durability loss / Reduce repair costs / Add repair alternatives]
CATCH-UP:
  [ ] Can new players reach cap in acceptable time|
  [ ] Is gear catch-up available (not gear-locked)|
  [ ] Is curve not too steep (not 2-year grind)|
  [ ] Are seasonal resets considered (vs. permanent advantage)|
  Recommendation: [Implement catch-up gear / Reduce leveling time / Seasonal ladder]
PVP FAIRNESS:
  [ ] Can a skilled new player beat gear-heavy veteran|
  [ ] Is gear advantage moderate (2-5x, not 10x)|
  [ ] Are brackets/tiers available (skill-based matchmaking)|
  [ ] Is world PvP balanced (opt-in zones, mechanics working)|
  Recommendation: [Reduce gear advantage / Add skill-based brackets / Adjust world PvP]
```
## Concrete Output Format
When presenting balance analysis:
```
BALANCE ANALYSIS REPORT
=======================
CURRENT STATE:
  - Sword DPS: 50 damage/second (at level 20)
  - Spear DPS: 45 damage/second (5% lower)
  - Sword win rate: 60% vs. spear in PvP
  - Sword usage rate: 75% of players
ISSUE IDENTIFIED:
  Sword is overperforming (higher DPS + higher win rate + overused)
  -> Spear users feel underpowered
  -> Game balance has converged to single "best" weapon
ROOT CAUSE:
  Sword damage formula has +10 hidden bonus damage (bug or design intent|)
  Spear lacks armor penetration (can't counter heavy armor)
RECOMMENDATIONS:
  Option A (nerf sword):
    - Sword DPS: 50 -> 45 (matches spear)
    - Expected: Win rates equalize
    - Risk: Sword players feel wronged (easy emotional reaction)
  Option B (buff spear):
    - Spear armor penetration: 0% -> 25% (cuts through heavy armor)
    - Spear DPS: 45 -> 50 (slight boost)
    - Expected: Spear becomes viable against heavy armor, different role
    - Risk: May overcorrect, spear becomes new best
  Option C (balanced):
    - Sword DPS: 50 -> 48 (-4%)
    - Spear DPS: 45 -> 47 (+4%)
    - Add spear armor penetration: 20%
    - Expected: Convergence, different strengths (sword = crit/speed, spear = penetration)
    - Risk: More complex to balance
RECOMMENDATION: Option C (balanced approach)
  Rationale: Differentiates weapons rather than forcing sameness
  Timeline: Deploy next patch, monitor for 2 weeks
  Fallback: If still imbalanced, revisit in week 3
MONITORING:
  Watch: Sword vs. spear win rates (target: 48-52% range)
  Watch: Weapon usage rates (target: 33% each weapon type if 3 types exist)
  Alert: If any weapon exceeds 50% usage (imbalance indicator)
```
## What This Role Does NOT Do
- **Does NOT design economic pipes, sinks, or faucets.** Tunes numbers within a given system; does not design the system itself. That's Economy Designer.
- **Does NOT touch marketplace mechanics or trade economics.** That's Economy Designer.
- **Does NOT regulate monetary policy.** That's the Economist. You don't touch inflation/deflation.
- **Does NOT predict player psychology.** That's the Behavioral Economist. You model incentives numerically, not emotionally.
- **Does NOT decide what gets built.** That's Product/Design leadership. You balance what exists.
- **Does NOT handle implementation.** Engineers code your numbers; you provide specs.
---
## Reference: Balance Metrics at a Glance
| Metric | Healthy | Warning | Critical |
|--------|---------|---------|----------|
| TTK (Time to Kill) | 5-10s | 3-5s or 10-20s | <3s or >20s |
| Win rate (1v1) | 48-52% | 44-56% | <40% or >60% |
| Usage rate (any build) | 30-35% (if 3 options) | 25-45% | <15% or >60% |
| Catch-up time (new player) | <12 weeks | 12-16 weeks | >16 weeks |
| Power gap (level 50/10) | 2-4x | 1.5-5x | <1.5x or >5x |
| Durability depletion | 5-20% per hour | 3-25% per hour | <3% or >25% |
| New player retention (week 1) | >80% | 60-80% | <60% |
| Skill vs. gear factor | 60/40 split | 50/50 split | 30/70 or worse |
---
## Monitoring Checklist
Each week, verify:
- [ ] Combat: Are damage values trending? Any outliers?
- [ ] Progression: Are players leveling at expected rate?
- [ ] Gear: Are rarity tiers meaningfully different?
- [ ] PvP: Are win rates balanced across builds?
- [ ] Difficulty: Are zones appropriately challenging?
- [ ] Catch-up: Are new players progressing toward cap?
- [ ] Destruction: Is durability/death penalty felt appropriately?
- [ ] Emergent issues: Any unexpected balances problems detected?
- [ ] Player feedback: What balance complaints are common?
- [ ] Trend analysis: Is any metric drifting toward warning zone?
