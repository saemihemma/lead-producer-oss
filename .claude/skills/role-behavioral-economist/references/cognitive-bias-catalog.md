# Cognitive Bias Catalog
Deep reference material for the major cognitive biases that shape player behavior in virtual economies.
## Your Purview: Why Players Aren't Rational
### 1. Loss Aversion
**The Psychology:** Players feel losses approximately **2x more acutely** than equivalent gains. Losing 100 gold stings twice as much as gaining 100 gold feels good.
**Critical for full-loot PvP:**
```
Rational analysis:
  Expected value of PvP fight: +50 gold (win) or -50 gold (loss)
  Expected value: 50% x (+50) + 50% x (-50) = 0
  -> Rational actor is indifferent
Real player analysis (loss-averse):
  Gaining +50 gold: feels +50 units of happiness
  Losing -50 gold: feels -100 units of pain (2x aversion)
  -> Net emotional calculation: -50 (feel like they're losing overall)
  Result: Player avoids PvP even when EV = 0
Implication: In full-loot games, players need a **significantly higher upside** to risk their assets. Reward structure must compensate for loss aversion (e.g., +100 gold expected win vs. -50 loss).
```
**Design implications:**
```
Framing effects matter:
  Losing 20% of your sword's durability feels like: "My sword is ruined!"
  Reframing: "Your sword is 80% intact" -> feels like: "My sword is fine!"
  Same mechanic, different psychological impact. Nudge through framing.
Sunk cost sensitivity:
  Players who invested 10 hours in a gear piece feel loss more acutely
  -> Reluctant to replace gear even when upgrade is clearly better
  Mitigation: Allow "heirloom" systems where old gear can be recycled into new gear without loss
  (Lets player feel like they're preserving value, not losing investment)
```
### 2. Anchoring
**The Psychology:** The first price players see becomes a mental reference point. All future prices are judged relative to that anchor.
**Marketplace effect:**
```
Anchor scenario:
  Day 1: New player sees swords selling for 500g (anchor set)
  Day 5: Market crashes, swords now 300g (realistic supply spike)
  Player reaction: "Swords are 40% cheaper-good deal!"
  But if Day 1 price was 200g (anchor):
  Day 5: Same 300g price
  Player reaction: "Swords are 50% MORE expensive-rip-off!"
  Same price, opposite perception. The anchor dominates.
Implication: Launch prices matter enormously. Set them right the first time, because changing them later triggers anchoring bias.
```
**Design implications:**
```
Price anchoring strategies:
  1. Suggested retail price: NPC vendors set price at ~600g
  2. Players see 600g and anchor to it
  3. Player marketplace trading happens at 500-700g (around anchor)
  4. Without anchor, price would drift unpredictably
Exploit anchoring consciously:
  - If you want sword prices at 500g, display NPCs selling at ~500g
  - If you want ore cheap, establish ore vendors at low price first
  - Don't "adjust prices down"-establish new anchors
  New item launch:
  - First price sets the anchor for the entire season
  - If you launch at 1000g and later realize it should be 600g:
    Player perception: "The devs nerfed our items" (feels bad)
  - If you plan ahead and launch at 600g:
    Player perception: "Steady market" (feels neutral)
```
### 3. Endowment Effect
**The Psychology:** Players overvalue what they own relative to what they don't own. Ownership creates irrational attachment.
**Marketplace consequence:**
```
Sword scenario:
  Player A (doesn't own): "That sword is worth 500g, I'll buy at 450g if offered"
  Player B (owns the sword): "That sword is worth 600g, I won't sell for less than 550g"
  Gap: 100g between valuations of the same asset
  -> Marketplace trades FEWER swords (lower liquidity)
  -> Prices stuck between bid 450g and ask 550g (wide spread)
Impact on economy:
  - Endowment effect reduces marketplace volume (traders unwilling to part with assets)
  - This reduces velocity (gold circulates slower)
  - Can create liquidity crises even in healthy economies
```
**Design implications:**
```
Reduce endowment effect through framing:
  1. Cosmetics over stats: "This sword is functional gear, not your prized possession"
     - If sword is generic, endowment effect weaker
     - If sword is unique/personal, endowment effect stronger
  2. Decay/expiration: "This sword degrades, you'll need a new one soon"
     - Ownership feels temporary -> less endowment effect
     - Players more willing to trade/upgrade
  3. Trading incentives: "Sell your old sword, get 80% of value back in credit"
     - Softens the "loss" of parting with item
     - Encourages turnover
  4. Upgrade systems: "Dismantle old sword to craft new sword (no gold cost)"
     - Preserves psychological feeling of "value transfer"
     - Not trading away (abandoning); recycling (preserving)
Example (EVE Frontier context):
  Full-loot mechanics trigger INTENSE endowment effect
  -> Players avoid trading altogether
  -> Hoard ships/gear (refuse to sell, won't enter markets)
  Mitigation: Create "heirloom" systems where destroyed ships can be recycled into new ships
  (Lets player feel ownership continuity, not asset loss)
```
### 4. Sunk Cost Fallacy
**The Psychology:** Players continue investing in a losing strategy because of prior investment ("I've already spent 100 hours on this build, I can't abandon it!").
**Progression trap:**
```
Scenario:
  Player invested 50 hours into "dagger build" (currently weak)
  New balance patch makes daggers bad; spears are now optimal
  Rational analysis:
    "Daggers are worse. I should respec to spears."
  Sunk cost fallacy:
    "But I invested 50 hours into daggers! If I switch, all that time is wasted."
    Result: Player continues with weak dagger build (sunk cost drives behavior)
Implication: Game balance changes alienate invested players because sunk cost fallacy makes them feel wronged.
```
**Design implications:**
```
Minimize sunk cost fallacy's negative effects:
  1. Cheap respec: Allow free or cheap skill resets
     -> Players feel less trapped by prior investments
     -> More willing to adapt to balance changes
  2. Cross-build transferability: "Skills apply to any weapon"
     -> 50 hours spent = valuable for any build, not locked into daggers
     -> Sunk cost feels preserved across specs
  3. Legacy rewards: "Your dagger build hero gains prestige title"
     -> Honor the investment (sunk cost feels meaningful)
     -> Make switching feel like progression, not regression
  4. Gradual nerfs: Don't destroy daggers overnight
     -> Give players time to emotionally accept change
     -> Reduce "I wasted my time" feeling
  5. Buff alternatives: When nerfing old build, ensure new builds are accessible
     -> Old investment unlocks new progression (not reset)
     -> Sunk cost serves new goals
Example:
  Instead of: "Daggers nerfed 50%. Respec or suffer."
  Do: "Daggers rebalanced. Dagger mastery now unlocks dual-wield bonus. Spears introduced as alternative path from dagger mastery."
  -> Existing dagger players feel their investment helps, not hurts
```
### 5. Hyperbolic Discounting
**The Psychology:** Players prefer small reward **now** over large reward **later**. Time preference is non-linear (heavily favors present).
**Progression impact:**
```
Game design choice:
  Option A: 1000 XP now
  Option B: 2000 XP after 1 week
  Rational analysis: Option B is better (100% more XP)
  Player behavior: 80-90% choose Option A (immediate gratification wins)
Long-term consequence:
  - If all rewards favor immediate gratification, players skip long-term activities
  - Dungeons/raids with 1-week time lock have low participation
  - Players farm short-cycle activities instead (daily quests, trivial tasks)
```
**Design implications:**
```
Work WITH hyperbolic discounting:
  1. Milestone rewards: Break long goals into short-term milestones
     Instead of: "Grind for 100 hours to get legendary sword"
     Do: "Complete 10-hour chapter -> Get chapter reward (progression feeling every 10 hours)"
     -> Reward now (chapter completion) while working toward long-term goal
  2. Time-gating with immediate progress:
     "This quest unlocks in 1 week. While waiting, earn daily progress points."
     -> Immediate reward (progress points today)
     -> Long-term reward (quest available in 1 week)
  3. Reverse hyperbolic discounting: Make early participation visibly valuable
     "Participate in raid this week -> Earn rare cosmetic this week"
     vs.
     "Earn gear for future use (abstract future value)"
     -> Attach visible, immediate rewards to long-term activities
  4. Season structure: Force reset cycles
     "Your progress resets next month. Spend rewards before reset."
     -> Creates artificial urgency (not "later", but "in 30 days")
     -> Accelerates spending, reduces hoarding
Example:
  Farming leather for armor:
    Without milestones: "Grind 1000 leather. Armor available when done." (boring, long-term)
    With milestones: "Every 100 leather earned -> earn cosmetic badge. Full set unlocks armor." (engaging, immediate rewards)
```
### 6. Social Proof & Herd Behavior
**The Psychology:** Players assume if many others are doing something, it must be correct/valuable. Herd behavior drives bubbles and fashion cycles.
**Marketplace bubble:**
```
Bubble formation:
  Week 1: Rare ore prices rising (supply scarce)
  Week 2: A few players notice and buy more (price continues rising)
  Week 3: "Everyone" is buying ore; FOMO kicks in
  Week 4: Ore prices peak at 10x normal value (bubble)
  Week 5: One major seller exits; panic selling
  Week 6: Ore crashes to 2x normal value
Social proof mechanism:
  "Everyone is buying ore" -> Implies "ore must be valuable"
  -> More players buy (herd behavior)
  -> Prices accelerate (positive feedback loop)
  -> Bubble pops (negative feedback loop)
Player psychology:
  Early buyers: "I'm smart, I saw the trend first"
  Late buyers (caught in FOMO): "I'm dumb, I bought at peak"
```
**Design implications:**
```
Manage herd behavior:
  1. Price visibility constraints: Don't show real-time price history
     -> Without trend visibility, players can't see "everyone is buying" signal
     -> Reduces herd behavior, stabilizes prices
  2. Price anchors (central bank role): Set vendor prices to discourage extremes
     "Ore at vendor: 10g. Marketplace varies 8-12g."
     -> Players understand the "real" price range
     -> Less likely to chase bubble prices
  3. Information delay: Show prices with 1-hour lag
     -> Herd behavior requires real-time signal awareness
     -> Lag slows feedback, dampens bubble amplitude
  4. Community sentiment analysis: Detect bubble language in chat
     "Everyone is talking about ore boom" -> Deploy stabilization sinks or faucet adjustments
  5. Contrarian nudge: Publicly announce unpopular items
     "Ore is overvalued based on fundamentals. Consider alternatives."
     -> Some players will contrarian-trade (reduce herd pressure)
     -> Helps pop bubbles before they overshoot
Example:
  Without price visibility: Ore price rises 50%, stabilizes (herd dampened)
  With real-time price history visible: Ore price rises 500%, crashes 90% (bubble worse)
```
### 7. FOMO (Fear of Missing Out)
**The Psychology:** Scarcity and time limits create anxiety. Players make impulsive decisions to avoid missing limited-time opportunities.
**Exploit mechanically:**
```
Limited-time cosmetic:
  "This cosmetic only available for 1 week!"
  Rational analysis:
    "I can get it later, or skip it, no harm done"
  FOMO-driven behavior:
    "But if I don't get it NOW, it's GONE FOREVER"
    -> Triggers anxiety
    -> Player impulse-buys (even if not interested)
Usage in economy:
  "Limited-time trading window: Buy/sell in next 12 hours"
  -> Forces immediate decision-making
  -> Reduces deliberation (leads to worse decisions)
  -> Creates artificial urgency
```
**Design implications:**
```
Use FOMO consciously, ethically:
  GOOD FOMO (creates engagement):
    - Battle pass seasons: "Season ends in 2 weeks, complete tasks"
    - Seasonal events: "Winter celebration ends on date X"
    -> Creates time structure, encourages participation without being manipulative
  BAD FOMO (exploitative):
    - "Buy this cosmetic right now or it's gone forever and you'll regret it"
    - Randomized loot boxes: "Limited-time box has 0.1% chance of X"
    -> Designed to prey on anxiety, triggers compulsive spending
  NEUTRAL (both exist):
    - Limited events: "This dungeon available Tuesdays 8-10pm"
    -> Creates natural scarcity from schedule, not artificial desperation
  Behavioral guidelines:
    OK Use FOMO to structure content (seasons, events)
    NO Don't use FOMO to exploit anxiety (false scarcity)
    OK Make limited-time offers clear and transparent
    NO Don't hide end-dates or create unclear countdowns
    OK Allow graceful handling of FOMO-induced regret (can trade/resell limited items)
    NO Don't lock items permanently if player "misses" deadline
Example:
  Good: "Seasonal armor available for 3 months, then vaults until next season. Plan ahead."
  Bad: "This armor disappears forever in 24 hours. Buy now!"
  (Same mechanical scarcity, vastly different psychological manipulation)
```
### 8. Prospect Theory
**The Psychology:** Players make different decisions under risk than under certainty. They overweight small probabilities and underweight large ones.
**Gambling mechanics:**
```
Rational analysis:
  Loot box: 90% common (10g), 9% uncommon (100g), 1% rare (1000g)
  Expected value: 0.90x10 + 0.09x100 + 0.01x1000 = 19g
  Cost: 20g
  -> Rational actor: Don't buy (negative EV)
Player behavior (prospect theory):
  "But there's a 1% chance of the rare item!"
  -> Overweights small probability (overweights 1% chance)
  -> Underweights the 90% common outcome
  -> Makes purchase despite negative EV (chasing the "dream")
Implication: Players will gamble even on bad bets if rare rewards are present.
```
**Design implications:**
```
Manage gambling impulses:
  Good: "Crafting has 80% success rate. Failed crafts return 50% materials."
    -> Uncertainty exists, but mitigated by partial recovery
    -> Discourages pure gambling (you get something)
  Bad: "Loot box has 0.1% chance of legendary. Cost is high."
    -> Pure gambling, purely exploitative
    -> Players chase dream, waste gold on negative-EV boxes
  Better framing: "Crafting success depends on skill. Higher skill = higher success rate."
    -> Uncertainty is skill-dependent, not random
    -> Players feel in control (not gambling)
    -> Reduces gambling pathology
  Avoid:
    NO Loot boxes with negative EV (designed to exploit)
    NO Hidden odds (players can't assess risk)
    NO Time-limited loot boxes (combines FOMO + gambling)
  Allow:
    OK Transparent odds (players make informed decisions)
    OK Skill-based uncertainty (feel in control)
    OK Fallback rewards (bad outcomes still useful)
Example:
  Bad: Mystery box, 0.5% legendary, cost 100g, hidden odds
  Good: Crafting recipes with visible success rates, cost 100g materials, fallback rewards
```
### 9. Status Quo Bias
**The Psychology:** Players resist change even when change is beneficial. Defaults are sticky.
**Balance patch resistance:**
```
Patch: "We're nerfing swords (overpowered) and buffing maces (underpowered)"
Rational analysis: "This is good, maces should be viable"
Player behavior: Resistance
  "Why are you ruining swords?"
  "Maces aren't worth the change"
  "I don't want to relearn combat"
Reality: Status quo (swords) felt comfortable. Change (maces rising) feels disruptive, even if objectively better.
Impact: Players will stick with weak swords rather than adapt to strong maces.
```
**Design implications:**
```
Minimize status quo bias:
  1. Smooth transitions: Gradual changes rather than hard nerfs
     Instead of: "Sword damage: 100 -> 50" (feels terrible)
     Do: "Sword damage: 100 -> 90 (week 1) -> 80 (week 2) -> 70 (week 3)"
     -> Allows players to adjust mentally, try alternatives
  2. Highlight benefits: "Maces now do X, which pairs with new playstyle"
     -> Frame change as positive addition, not subtraction
     -> "Maces are now viable" > "Swords are now worse"
  3. Preset alternatives: When changing defaults, offer good alternatives
     "If you liked swords, try maces (similar playstyle)"
     -> Reduces friction of changing defaults
  4. Reversibility: "We're trying this change. Revert if community dislikes it."
     -> Feels less permanent, eases resistance
  5. Opt-in changes: "New playstyle available, opt in to use it"
     -> Status quo remains available
     -> Players explore new options at own pace
     -> Reduces resentment
Example:
  Bad: "Spears nerfed 30%. Adapt or lose."
  Good: "Spears adjusted to reduce versatility spam. New tactical role: crowd control specialist. Try the new spear guide."
  (Same nerf, vastly different reception)
```
### 10. Framing Effects
**The Psychology:** Same choice presented differently triggers different decisions.
**Marketplace framing:**
```
Option A: "Sell your sword for 500g" -> Feels like a gain (receiving gold)
Option B: "Keep your sword, pay 500g tax to hold it" -> Feels like a loss (losing gold)
Same economic effect, opposite psychology. Option A encourages selling (gain frame). Option B discourages holding (loss frame).
Design choice:
  If you want items to flow (sell, trade), frame as gains
  If you want items kept (hoarding discouraged), frame as losses
```
**Design implications:**
```
Framing for economic goals:
  Goal: Encourage marketplace trading
  Frame: "Sell items -> earn gold quickly"
  Avoid frame: "Keep items -> lose potential profit"
  Goal: Discourage hoarding
  Frame: "Accumulated gold -> pay 1% wealth tax"
  Alternative frame: "Spend gold -> keep 100% of value"
  (First feels like loss, second feels like gain-use first to discourage hoarding)
  Goal: Encourage cosmetic purchases
  Frame: "Cosmetics: Show your style to other players"
  Avoid frame: "Cosmetics: Waste gold on vanity"
  Goal: Make repairs feel acceptable
  Frame: "Repair = restore your gear to full strength"
  Avoid frame: "Repair = pay for breaking your gear"
  (Both describe same mechanic, first feels positive, second negative)
  Goal: Encourage participation in losing proposition
  Frame: "This activity gives 500g (focus on reward)"
  Don't frame: "This activity costs 100g (focus on cost)"
  (Both true, but different emotional impact)
```
### 11. Mental Accounting
**The Psychology:** Players treat different currencies/resources as separate "accounts" even when fungible.
**Multi-currency effect:**
```
Game has 2 currencies:
  Gold: earned from farming, spent on items
  Gems: earned from events, spent on cosmetics
Even though 1 Gold = 0.1 Gems in exchange rate, players treat them separately.
Player psychology:
  "I have 50 Gems saved for cosmetics. I won't spend on items."
  (Mental account: "This gold is for cosmetics, not items")
  Reality: Gems and Gold are fungible, so arbitrary distinction
  Player behavior: Treats accounts separately anyway
Economic consequence:
  Players spend less total currency because of mental compartmentalization
  -> Less liquidity in some markets
  -> Reduced overall velocity
```
**Design implications:**
```
Use mental accounting strategically:
  To encourage spending (increase velocity):
    OK Single currency (no mental accounts)
    OK Show total wallet balance prominently
    OK Frame all spending as "using currency"
  To discourage spending (reduce inflation):
    OK Multiple currencies (separate mental accounts)
    OK Earmark currencies ("cosmetics only", "crafting only")
    OK Show separate balances
  To encourage saving:
    OK Separate saving account (high-interest vault)
    OK "Gold in vault" mentally distinct from "gold in wallet"
    OK Psychological feeling: "I'm being responsible"
  To encourage smart spending:
    OK Trading currencies between accounts has friction
    OK "Convert wallet gold -> vault gold" costs 1% fee
    OK Discourages careless hoarding, encourages thoughtful allocation
Example (EVE Frontier):
  If goal is to prevent hoarding:
    Create separate accounts: "personal gold" vs. "corp treasury"
    -> Players mentally separate them
    -> Less incentive to hoard personal wealth
    -> More likely to invest in corp (social tie)
```
### 12. Nudge Design (Choice Architecture)
**The Psychology:** How you present choices shapes decisions without restricting options.
**Marketplace nudge:**
```
Nudge 1 (default order): Show items sorted by "best value" (volume x price)
  -> Players naturally explore high-volume items
  -> Increases network effects (everyone buying same items)
  -> Can create bubbles
Nudge 2 (default order): Show items sorted by "newest listings"
  -> Players discover diverse items
  -> Reduces herd behavior
  -> More distributed trading
Same marketplace, different default. Nudge changes behavior without restricting choice.
```
**Design implications:**
```
Choice architecture for economic goals:
  Nudge: Default to "experienced player" trading interface
  Effect: Reduces accidental trading mistakes
  Implication: More careful, deliberate trades
  Nudge: Show "fair price range" on listings
  Effect: Anchors expectations, reduces extreme pricing
  Implication: More stabilized market prices
  Nudge: Highlight "items with high demand" in marketplace
  Effect: Channels trading toward liquid assets
  Implication: Reduces dead-stock items, improves velocity
  Nudge: Require 5-second confirmation before selling below market average
  Effect: Prevents panic-selling when nervous
  Implication: Reduces price volatility
  Nudge: Suggest "save 5% by buying bulk" for crafting materials
  Effect: Encourages larger purchases
  Implication: Reduces transaction friction, increases crafting engagement
  Nudge: Sort rewards by "most useful for your build"
  Effect: Players take recommendations
  Implication: Reduces variance in gear choices, accelerates progression
All nudges preserve player choice but guide toward better decisions (or toward design goals).
```
