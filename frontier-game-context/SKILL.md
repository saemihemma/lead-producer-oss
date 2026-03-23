---
name: Frontier Game Context
description: Game design landscape for EVE Frontier - core fantasy, game loops, smart assembly gameplay, player types, tribes, world structure, progression, and design tensions. Load alongside role skills to provide domain-specific game design knowledge.
---
# Frontier Game Context
This module provides structured reference information about the game design and player experience of EVE Frontier. Use alongside role skills (Game Designer, Community Manager, etc.) to ground analysis in concrete game systems and design intent.
## Core Fantasy & Design Intent
**Player-Built Civilization in a Harsh Frontier**
- Vision: Players collaborate to build a functioning society from raw materials
- Environment: Dangerous, resource-scarce, PvP-enabled space
- Emergent narrative: Player actions create stories (wars, trading empires, exploration)
- Agency: Players make meaningful choices about infrastructure, alliances, conflict
- Permanence: Structures built by players persist; destruction has real cost
- **Tone:** Emphasis on emergent gameplay and player agency. Permadeath and loss expected.
## Core Game Loops
**Mining -> Building -> Defending -> Expanding Cycle**
- **Mine**: Extract raw resources from asteroids, dangerous activity (exposed to PvP)
- **Build**: Refine materials, craft components, construct ships and smart assemblies
- **Defend**: Use ships and structures to protect tribe territory and resources
- **Expand**: Scout new regions, establish forward operating bases, grow territorial control
- **Loop repeats**: Success enables more ambitious builds; failure forces reassessment
**PvP-Enabled Gameplay & Loss Mechanics**
- Combat between players and tribes fundamental to design
- **PvP loss mechanics (specify concretely):** [On death: Lose ship / Lose cargo / Both / - VERIFY]
- Loss consequences: Risk creates meaningful decision-making
- Asymmetry: Different ship classes, smart assembly combinations create tactical depth
- Insurance possible: Player may recover % of lost value via insurance (see economy context)
**Territorial Control Through Smart Assemblies**
- Smart Assemblies are persistent world entities controlling space
- **Gates**: Control access to regions, charge tolls, filter traffic
- **Turrets**: Defend territory, shoot down intruders, require fuel to operate
  - **Deployment constraints:** [Turret spam prevention / - VERIFY] (How many turrets per system? Resource cost limit? AI target priority rules?)
- **Fuel Stations**: Enable logistics for deep space operations, create supply line bottlenecks
- Player-built governance: Tribes decide which smart assemblies to deploy, where, and how to configure them
## Smart Assembly Gameplay
**Player-Authored World State**
- Tribemembers with engineering skills author smart assembly code (Move smart contracts)
- Deployment: Publish assembly to blockchain, pay gas fees for on-chain presence
- Behavior: Assemblies execute configured logic (gate toll logic, turret targeting rules, fuel pricing)
- Persistence: Once deployed, assemblies persist across play sessions; cannot be easily deleted
**Smart Assembly Types & Use Cases**
- **Toll Gates**: Revenue generation, access control, diplomacy (alliances granted free passage)
- **Defensive Turrets**: Territory defense, requires operator or automation rules
- **Fuel Stations**: Logistics hub, enables deep space operations, creates economic opportunity
- **Mining Rigs**: Resource generation on-chain, reduces individual farming burden
- **Trading Posts**: Marketplace nodes, improves local liquidity, generates NPC-like commerce
**Technical Constraints Affecting Gameplay**
- Gas costs limit frequency of state updates (expensive to update turret targeting rules every second)
- Finality delays (1-2 seconds) create planning constraints; real-time gameplay requires off-chain prediction
- Once deployed, code cannot be updated (requires new deployment with new gas costs)
- Bug in deployed smart assembly requires governance process to revoke and redeploy
**Composition & Emergence**
- Tribes combine multiple smart assemblies to create complex behaviors
- Example: Gate -> Fuel Station -> Mining Rig -> Turret chain enables self-sufficient remote base
- Emergent gameplay: Players discover novel combinations and exploit system boundaries
- Design space: Balance novelty/emergence against unintended consequences
## Player Types & Social Roles
**Builder**
- Primary motivation: Creating infrastructure and optimizing production
- Activities: Designing smart assemblies, establishing supply chains, improving efficiency
- Value to tribe: Creates economic foundation, enables warfare through resource supply
- Progression: Unlocks more complex smart assembly capabilities
**Fighter/PvPer**
- Primary motivation: Combat, territorial control, proving skill
- Activities: Defending tribe assets, raiding enemies, exploring dangerous space
- Value to tribe: Military defense, resource acquisition through violence, deterrence
- Progression: Better ships, more advanced combat tactics, leadership of military ops
**Trader/Economist**
- Primary motivation: Profit, market manipulation, resource arbitrage
- Activities: Buying/selling on marketplace, identifying supply gaps, price optimization
- Value to tribe: Economic efficiency, external liquidity, funding military/infrastructure
- Progression: Larger capital reserves, understanding of economy DAG, market influence
**Explorer/Scout**
- Primary motivation: Discovery, adventure, mapping the unknown
- Activities: Scouting new regions, documenting resources, finding safe routes
- Value to tribe: Strategic intel, resource discovery, expansion opportunity identification
- Progression: Faster scouts, extended range, knowledge of null-sec dangers
**Governor/Strategist**
- Primary motivation: Leadership, planning, organizational design
- Activities: Setting tribe direction, managing resources, diplomatic negotiations
- Value to tribe: Strategic vision, conflict prevention, organizational coherence
- Progression: Larger tribe size, more complex logistics, political power
## Tribes: Social Structure
**Tribe Definition**
- Persistent player organization with shared leadership and resources
- Members pool resources, coordinate activities, defend shared territory
- Leadership decides infrastructure placement, diplomatic relations, conflict strategy
**Tribe Mechanics**
- Shared wallet for collective resources (likely guild bank)
- Roles and permissions: Different members with different authority levels
- Territory: Tribe claims space, deploys smart assemblies as defensive perimeter
- Diplomacy: Formal allies/enemies, non-aggression pacts, vassalage arrangements
**Tribe Size Data**
- **Small tribe (5-10 players):** Tight coordination, vulnerable to organized enemies
- **Medium tribe (20-100 players):** Specialist roles, organized warfare capability
- **Large tribe (100+ players):** Political entity, controls regions, international diplomacy
- **Megatribe risk:** Very large tribes can dominate, reducing competitive tension [Data on current largest tribes / - VERIFY]
- **Tribe size cap (if any):** [Is there a max / - VERIFY]
## World Structure & Starter Resources
**Spatial Organization**
- **Regions**: Largest geographic divisions (10-20 regions in initial map)
- **Solar Systems**: Subdivisions within regions (10-20 systems per region)
- **Asteroid Fields**: Resource spawning zones within systems
- **Safe Zones**: Around starter regions, PvP disabled or restricted
- **Null-Sec**: Deep frontier, full PvP, highest resource density
**Safety Gradient**
- Starter regions: No PvP, safe for new players to learn
- Low-sec: Limited PvP, some smart assemblies maintain order
- Null-sec: Full PvP, lawless frontier, highest risk/reward
- Consequence: Better resources in riskier space
**Starter Resources & New Player Economics**
- **Currently implemented:** [Starting ship(s) / Starting resources / - VERIFY]
- **Starter package includes:** [E.g., Corvette + 100 units fuel + basic ores / - VERIFY]
- **Design rationale:** Afford new players enough to meaningfully play without breaking veteran economy
- **Consequence:** If starter grants too generous, inflation risk; if too stingy, retention suffers
**Strategic Geography**
- Gate positions control trade routes and region access
- Fuel stations create supply line choke points
- Asteroid fields drive territorial conflict (limited resource density)
- Distance creates logistics challenges; deep space operations require planning
## Character & Account Progression
**Progression Metric (Define Explicitly)**
- **Currently implemented:** [Ships owned / Resources accumulated / Territory controlled / - VERIFY]
- Not traditional level-based progression (no XP bars or level caps)
- Progression measures: Better ships, more resources, strategic positioning, territory control
- Skill-based: Player decision-making and execution skill matter more than time invested
**Ship Progression**
- Starter ships: Corvettes, minimal cost, lose-without-pain
- Frigate tier: Scout/light combat, affordable recurring cost
- Destroyer/Cruiser: Medium warfare, significant investment, PvP-viable
- Battlecruiser/Battleship: Expensive, powerful, high insurance risk
- Specialized roles: Mining barges, industrial haulers, logistics support
**Vertical Progression Limits**
- No "max level" that gates endgame content
- Progression: Access to advanced ships, smart assemblies, territories
- Soft cap: Ships above certain tier require significant resource commitment, creating natural tier boundaries
**Horizontal Progression**
- Skill diversity: Different roles (mining, trading, combat) have separate skill trees
- Specialization: Players can optimize for specific playstyle
- Respeccing possible but costly, encouraging character diversity across accounts
## Design Tensions & Balancing Challenges
1. **Accessibility vs Depth**
   - New players need gentle onboarding, experienced players want strategic depth
   - Tension: Simple systems easy to learn but boring for experts
   - Solution: Layered complexity; basic loops approachable, optimization deep
2. **Solo Play vs Group Advantage**
   - Solo players: More agency, no dependency, weaker militarily
   - Groups: Coordination benefits, shared risk, concentrated power
   - Balance: Solo viability at smaller scales; groups dominate big wars
3. **Safety vs Risk**
   - New players: Need protection to learn without punishing loss
   - Veterans: Want high-stakes PvP and resource competition
   - Solution: Safety gradient by region; starter zones low-risk, null-sec dangerous
4. **Player Agency vs Designer Intent**
   - Freedom: Let players do anything they want (emergent gameplay)
   - Control: Prevent exploits, maintain balance, guide narrative
   - Challenge: Identify which player creativity is exploit vs legitimate strategy
5. **Economic Competition vs Cooperation**
   - Pure PvP: All players compete, winner-take-all
   - Pure cooperation: Players cooperate toward shared goals, less competitive
   - Frontier design: Competition within tribes, cooperation between members, inter-tribe warfare
6. **Permanence vs Alt-Friendliness**
   - Permanent consequences: Loss matters, decisions matter, memorable
   - Multiple characters: Players test playstyles without ruining main, alts as support
   - Challenge: Alts can be exploited for resource transfers (RMT risk)
7. **Rapid Iteration vs Blockchain Immutability**
   - Game design feedback loop: Fast iteration based on player feedback
   - Smart assemblies: Once deployed, cannot be changed without redeployment (gas costs)
   - Tension: Bug in deployed smart assembly costly to fix; need testing before mainnet
## Current State: Early Access / Playtest Phase
**Implementation Status Distinctions**
- **Currently implemented:** Live on Frontier servers now. Players can interact with these systems.
- **In design:** Under development. Not yet playable. Timelines unknown.
- **Aspirational:** Discussed but not committed to development roadmap.
**Implications for Design**
- Rapid iteration: Game systems change frequently based on community feedback
- Wipes possible: Economy/characters might reset for testing
- Feature incomplete: Some systems intentionally scoped for later phases
- Community feedback loop: Players actively shape design through testing
**Expected Community Feedback Areas**
- Balance: Ship costs, smart assembly gas costs, resource availability
- Progression: Does advancement feel rewarding? Too slow/fast?
- Fun factor: Are core loops engaging? Do player stories emerge?
- Fairness: Does the economy punish newcomers unfairly?
- Technical: Bugs, performance issues, UX pain points
## Data Gaps & Verification Needed
Throughout this context, gaps are marked:
- **[DATA GAP]:** Information missing; needs team confirmation (e.g., "Starter resources not documented").
- **[VERIFY]:** Assumption made; confirm with design team (e.g., "Turret spam prevention assumed").
Key questions to resolve:
1. What are starter resources? How much? What prevents inflation?
2. PvP loss mechanics: Lose ship? Cargo? Both? Insurance terms?
3. Smart assembly deployment constraints: Can players spam turrets?
4. Tribe size cap: Megatribe prevention strategy?
5. Progression metric: Ships? Resources? Territory? Mix?
## What This Module Does NOT Do
This context module provides game design knowledge, **not** design authority:
- **Does NOT make design decisions.** Game Designer owns core loop balance, progression pacing, and feature prioritization. This module is reference material.
- **Does NOT define or enforce game balance.** Describes current systems; does not decide if PvP loss mechanics are fair or if progression is too fast.
- **Does NOT predict player behavior.** Provides design intent; actual player behavior comes from playtesting and telemetry. Design theory != player reality.
- **Does NOT replace community feedback.** Theory is one input. Player voices and behavioral data are equally important.
- **Does NOT cover technical implementation details.** How to build smart assemblies is Tech Context's domain; this covers gameplay implications only.
## Not Covered in This Module
- Specific quest/mission system
- Detailed ship stats and builds
- Smart assembly code examples
- Complete skill tree and progression tables
- Detailed world lore and faction narratives
- Detailed combat mechanics and balance
