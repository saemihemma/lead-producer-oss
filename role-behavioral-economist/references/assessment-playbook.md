# Behavioral Assessment Playbook
Deep reference material for running a behavioral-economics assessment and packaging the output.
## Framework: Behavioral Economist's Assessment
When analyzing player decisions, use this checklist:
```
BEHAVIORAL ANALYSIS CHECKLIST
==============================
1. LOSS AVERSION:
  [ ] Are players avoiding activities due to loss fear|
  [ ] Would reframing as "gain" help engagement|
  [ ] Is expected value positive but emotional payoff negative|
  Recommendation: [Adjust framing / Add confidence rewards / Reduce loss magnitude]
2. ANCHORING:
  [ ] What's the initial price players anchored to|
  [ ] Has that anchor drifted from intended price|
  [ ] Would new anchor strategy help re-align expectations|
  Recommendation: [Establish new vendor prices / Create new anchors / Price transparency]
3. ENDOWMENT EFFECT:
  [ ] Are players hoarding items (high attachment)|
  [ ] Is marketplace volume lower than expected due to unwillingness to sell|
  [ ] Would decay/expiration reduce attachment|
  Recommendation: [Add decay mechanics / Upgrade incentives / Trading bonuses]
4. SUNK COST:
  [ ] Are players trapped in old builds despite balance changes|
  [ ] Do balance patches trigger resentment (loss of investment)|
  [ ] Can sunk costs transfer to new paths|
  Recommendation: [Cheaper respecs / Cross-build bonuses / Legacy rewards]
5. HYPERBOLIC DISCOUNTING:
  [ ] Are long-term activities abandoned for short-term farming|
  [ ] Do milestone rewards help engagement with long-term goals|
  [ ] Is immediate gratification too easy|
  Recommendation: [Add milestone rewards / Increase participation rewards / Accelerate feedback]
6. HERD BEHAVIOR:
  [ ] Are price bubbles forming (everyone buying same asset)|
  [ ] Do players follow trends without understanding why|
  [ ] Would visibility constraints help stability|
  Recommendation: [Reduce price history visibility / Deploy contrarian nudges / Add price anchors]
7. FOMO:
  [ ] Are players making impulsive decisions due to scarcity signals|
  [ ] Is FOMO used ethically (structure) or exploitatively (manipulation)|
  [ ] Do players regret FOMO-driven purchases|
  Recommendation: [Clarify deadlines / Avoid hidden scarcity / Allow resale of limited items]
8. PROSPECT THEORY:
  [ ] Are players gambling on negative-EV loot boxes|
  [ ] Can uncertainty be reframed as skill (not random)|
  [ ] Are odds transparent|
  Recommendation: [Avoid predatory gambling / Increase skill-based outcomes / Transparency]
9. STATUS QUO BIAS:
  [ ] Are players resisting beneficial changes|
  [ ] Are defaults sticky (hard to move away from)|
  [ ] Would gradual transitions help|
  Recommendation: [Smooth transitions / Highlight benefits / Offer presets / Allow reversibility]
10. FRAMING EFFECTS:
  [ ] How is the decision presented to players|
  [ ] Would alternative framing change behavior|
  [ ] Are loss frames vs. gain frames aligned with goals|
  Recommendation: [Reframe as gains / Adjust language / Change presentation]
11. MENTAL ACCOUNTING:
  [ ] Do players separate currency accounts mentally|
  [ ] Does compartmentalization reduce spending/engagement|
  [ ] Would unified or separated accounts serve goals better|
  Recommendation: [Single vs. multiple currencies / Create mental accounts / Adjust friction]
12. NUDGES:
  [ ] What's the current default presentation|
  [ ] Does default guide toward good or bad decisions|
  [ ] Would choice architecture nudge toward desired behavior|
  Recommendation: [Change defaults / Add information nudges / Adjust friction / Reorder options]
```
## Concrete Output Format
When presenting behavioral analysis:
```
BEHAVIORAL ASSESSMENT
=====================
PREDICTION vs. REALITY:
  Economist's model predicts: Players farm ore until supply = demand, prices stabilize
  Actual player behavior: Herd behavior formed, players panic-bought ore (bubble)
  Root cause: Social proof + FOMO triggered irrational behavior
  Gap: Theory assumed rationality; reality has cognitive biases
IDENTIFIED BIASES:
  NO Anchoring: First ore price (100g) set expectation; current 500g feels like bargain
  NO Social proof: "Everyone is buying ore" -> FOMO -> more buying (feedback loop)
  NO Prospect theory: Small chance of rare ore drops overweighted
  NO Herd behavior: Cascade of purchases, not individual calculation
BEHAVIORAL DIVERGENCE:
  Rational: Buy ore at fair value, hold until need
  Real: Buy ore because others are, fear of missing boom, panic before crash
RECOMMENDATIONS:
  Immediate:
    - Reduce price history visibility (dampen herd signal)
    - Announce ore fundamentals (devalue speculative premium)
    - Deploy market stabilizer (NPC contrarian offers)
  Short-term:
    - Create alternative investment opportunities (reduce ore focus)
    - Add marketplace friction for rapid speculation (slow trading)
  Long-term:
    - Design against speculation (use decay, consumption, sinks)
    - Support informed trading (show fundamentals, not trends)
MONITORING:
  Watch: Ore price volatility (should decline after stabilizers deployed)
  Alert: If herd re-forms around new asset (early signal of next bubble)
```
## What This Role Does NOT Do
- **Does NOT design systems.** That's the Economy Designer.
- **Does NOT regulate policy.** That's the Economist.
- **Does NOT predict what rational actors optimize for.** That's the Economist's baseline model. This role predicts where real players DEVIATE from that model.
- **Does NOT design economic pipes, sinks, or marketplace mechanics.** That's Economy Designer.
- **Does NOT balance combat or progression.** That's the Game Balance Designer.
- **Does NOT implement changes.** Engineers and designers execute recommendations.
- **Does NOT excuse bad design with "that's just human nature."** Instead, work with psychology to improve design.
---
## Reference: Cognitive Biases at a Glance
| Bias | Player Effect | Economic Impact | Mitigation |
|------|--------------|-----------------|-----------|
| Loss aversion | Avoids risk (PvP) | Reduces activity, lower risk rewards needed | Reframe as gains, add confidence rewards |
| Anchoring | First price sets expectations | Price stickiness, hard to adjust | Establish correct anchor early, new anchors later |
| Endowment | Won't sell items owned | Low marketplace volume, low velocity | Add decay, upgrade incentives, forced turnover |
| Sunk cost | Sticks with weak builds | Resists balance changes, resentment | Cheap respec, cross-build bonuses |
| Hyperbolic discounting | Prefers short-term gain | Ignores long-term activities | Milestone rewards, immediate feedback |
| Herd behavior | Follows trends blindly | Bubbles, crashes, herd stampedes | Reduce visibility, destabilize consensus |
| FOMO | Impulsive purchases | Regret, burnout, over-engagement | Clear deadlines, avoid false scarcity |
| Prospect theory | Gambles on rare rewards | Chases negative-EV loot boxes | Avoid predatory gambling, increase skill |
| Status quo bias | Resists change | Rejects balance patches, holds weak builds | Gradual transitions, highlight benefits |
| Framing | Behaves differently on same choice | Influenced by language, presentation | Frame losses as gains where helpful |
| Mental accounting | Separates fungible currencies | Reduced spending, inefficient allocation | Unified currency or strategic separation |
| Nudges | Follows defaults | Guided by choice architecture | Design nudges toward good decisions |
---
## Monitoring Checklist
When assessing player behavior divergence:
- [ ] Are players acting rationally according to economic model?
- [ ] Where do they deviate? (Identify specific biases)
- [ ] Is deviation predictable based on psychology?
- [ ] Can we nudge behavior back toward intent?
- [ ] Are unintended behaviors acceptable (leave as is)?
- [ ] Are unintended behaviors harmful (intervene)?
- [ ] Do changes feel manipulative or fair?
- [ ] Are nudges transparent to players?
- [ ] Do players feel in control of decisions?
