---
name: Frontier Economy Context
description: Economic landscape reference for EVE Frontier - resource systems, player-driven economy, smart assembly costs, economy DAG, and historical lessons from EVE Online. Load alongside role skills to provide domain-specific economic knowledge.
---
# Frontier Economy Context
This module provides structured reference information about the economic systems of EVE Frontier. Use alongside role skills (Economy Analyst, Product Manager, etc.) to ground economic analysis in concrete game systems and historical lessons.
## Resource System: Mining to Production
**Resource Pipeline**
- **Raw Materials**: Extracted from asteroids via mining (ore types include tritanium, pyerite, mexallon, isogen, nocxium, zydrine, megacyte, morphite)
- **Processed Materials**: Refined ore becomes base materials (minerals), combining specific ore types in defined ratios
- **Components**: Minerals combine into tech components (armor plates, electronics, power systems, etc.)
- **Final Products**: Components build into ships, structures, and smart assembly blueprints
- **Consumption**: Ships and smart assemblies consume fuel, propellant, and durability resources over time
**Economy DAG (Directed Acyclic Graph)**
- Game models resource dependencies as a directed acyclic graph
- Nodes: Materials, components, finished products
- Edges: Conversion recipes and production requirements
- Example path: Tritanium ore -> refine -> tritanium mineral -> build armor plate -> build hull module -> build frigate
- Queries: "What depends on this resource?" and "What's required to produce this?" map to graph traversal
**Bottleneck Dynamics**
- Scarce early-stage materials gate downstream production
- Strategic resources (high-demand minerals) create competition
- Refining facilities required (infrastructure investment)
- Processing time and material loss in conversion
## Token Economics & Marketplace
**No NPC Vendors**
- Players set all prices (no artificial price floor/ceiling)
- Supply and demand entirely player-driven
- Market volatility higher than NPC-based economies
- Opportunity for player manipulation
**Marketplace Structure & Fees**
- **Currently implemented:** [Order book / Auction / - VERIFY with team]
- **Order book style (if used):** Players post buy/sell orders; fills when price matches. Seller pays 1-5% fee. Escrow handles atomicity.
- **Auction style (if used):** Players bid on items; highest wins. Seller keeps % of winning bid.
- Gas costs per transaction (Sui-based). High-frequency trading may be cost-prohibitive.
- Market data transparency: [All orders visible / - VERIFY]
**Player-Set Prices**
- New players entering market at disadvantage (pay premium prices or farm inefficiently)
- Established players with capital can influence prices
- Coordination opportunities: alliances fixing prices, market manipulation
- Price discovery driven by supply shocks (major mining operations) and demand shifts
**On-Chain Tokens (If Applicable)**
- Frontier may use on-chain token for player rewards, marketplace fees, or governance
- Token economics: Emission rate, burn mechanisms, staking/governance model
- Value derived from: In-game utility (marketplace fees, smart assembly costs), scarcity (capped supply), governance rights
## Smart Assembly Economics
**Operating Costs**
- Fuel consumption: Turrets, gates, fuel stations consume fuel to operate
- Gas costs: Every on-chain transaction costs Sui (cryptocurrency)
- Maintenance: Possible durability degradation requiring repair
- Staffing: May require player labor/management
**Revenue Models**
- **Toll Gates**: Charge passage fee in resources (fuel, minerals, components)
- **Turrets**: Protect territory for tribe members in exchange for access fees or tribute
- **Fuel Stations**: Provide refueling service for 10-20% markup
- **Mining Operations**: Generate ore directly, consume fuel and labor
- **Research Stations**: Provide technical services, charge fees
**Capital Requirements**
- Building smart assemblies requires initial resource investment
- Blueprint acquisition or research
- Smart assembly construction time and resource cost
- Gas costs for deployment to Sui blockchain
- Barrier to entry: New tribes need capital to compete
## Known Economy Elements
**Fuel as Consumable Resource**
- Primary operational resource for ships and smart assemblies
- Generated through specialized mining/refining
- Scarcity creates trade opportunity
- Supply-demand tension: enough for active players but not infinite abundance
**Wealth Distribution Countermeasures**
- **Currently implemented:** [Market taxes / Resource sinks / - VERIFY]
- Possible mechanisms: Marketplace transaction taxes, NPC buy-back at fixed rate (sink), depreciation on stored resources.
- **Goal:** Prevent runaway wealth concentration. Gini coefficient should remain <0.7 (moderate inequality).
**Inflation & Faucet/Sink Mechanics**
- **Faucet (resource generation):** Mining creates new resources. Rate = ores extracted per minute x server count.
- **Sink (resource destruction):** Combat losses, operational consumption, storage decay.
- **Balance:** Monitor faucet vs sink monthly. If faucet > sink for 3 months, inflation risk. Adjust mining yields or add sinks.
- **Risk:** Too much generation -> inflation erodes player savings
**Insurance Mechanics**
- Possible insurance market for destroyed ships (standard EVE mechanic)
- Insurance can be: NPC-backed (fixed rate) or player-backed (risky but profitable)
- Economics: High-risk ships drive insurance demand; creates new economic role
**New Player Onboarding**
- New players need starting resources (ships, materials) to engage
- Conflict: Hand-outs reduce wealth inequality but enable RMT market
- Economy implications: New player resource grants affect inflation
- Retention: Fair progression path essential
## Historical EVE Lessons
**ISK Faucets & Sinks (EVE Online)**
- ISK generated through: Ratting (NPC combat), mining, missions, industry
- ISK destroyed through: Player market taxes, NPC station fees, insurance payouts, combat losses
- Lesson learned: Balance required or hyperinflation; CCP adjusted faucets multiple times
- Frontier application: Monitor resource generation and destruction carefully
**PLEX & RMT Dynamics (EVE Online)**
- PLEX: Player-tradable item that grants game time or in-game currency
- Risk: Creates real-money-trading (RMT) pressure and wealth gap
- Lesson: Even cosmetic/convenience spending drives power inequality
- Frontier choice: May include cosmetics-only monetization to avoid pay-to-win problems
**Market Manipulation Patterns**
- Hoarding: Players buy supply to restrict market, raise prices
- Pump & dump: Coordinate price increases, sell high, crash market
- Cartel formation: Large groups coordinate prices, block competition
- Lesson: Harder to prevent than to manage after-the-fact; transparency helps
**Territory Conflicts & Economic Warfare**
- EVE: Wars fought over resource moons, space ownership
- Economic casualties: Supply routes cut, market disruption
- Lesson: Economy deeply tied to political power; dominance players leverage economic control
- Frontier: Smart assemblies control resources; wars will follow
**Scarcity & Wealth Concentration**
- EVE: Richest players accumulate through compound advantages
- Wealth inequality grows naturally (successful players snowball)
- Lesson: Gini coefficient of player wealth increases over time unless actively countered
- Frontier question: How much inequality is acceptable for emergent gameplay?
## Economy DAG Cross-Reference
When analyzing resource flows or bottlenecks, reference specific DAG nodes:
- **Example:** "Tritanium mineral is a bottleneck for armor plate production" -> Check DAG node `tritanium_mineral` for upstream dependencies (ore sources).
- **Query tool:** Use economy DAG search to find "what feeds X?" and "what does X feed?"
- See separate Economy DAG context module for detailed node interactions.
## Key Economic Tensions
1. **Resource Scarcity vs Accessibility**: Too scarce alienates new players; too abundant removes stakes
2. **New Player Onboarding vs Established Player Wealth**: Hand-outs help retention but undermine veteran achievements
3. **Inflation Control vs Economic Growth**: Steady resource generation needed for growth, but risks devaluation
4. **Player Agency vs Economy Stability**: Free markets enable player creativity but allow manipulation
5. **Solo Play vs Group Advantage**: Groups have economics of scale; solos disadvantaged
6. **Risk vs Reward**: PvP losses necessary for scarcity but punishing to casual players
## Monitoring & Analysis
**Economy Health Indicators**
- Resource generation vs destruction ratio (inflation indicator)
- Price stability across resource types (market efficiency)
- Wealth concentration metrics (Gini coefficient)
- Market liquidity and trade volume
- New player farm rate vs retention rate
- Smart assembly uptime and resource consumption
**Early Warning Signs**
- Rapid price inflation across multiple resource types
- Marketplace liquidity drying up (fewer trades)
- Wealth concentration accelerating (rich getting richer)
- New player churn spiking
- Smart assembly operating costs becoming prohibitive
- Hoarding behavior and cartel coordination reports
## Speculative vs Implemented Features
Throughout this context, speculative features (under design, not yet live) are marked:
- **In design:** Feature proposed; under development.
- **[DATA GAP]:** Information missing; verify with economy team.
- **[VERIFY]:** Assumption needing confirmation.
## What This Module Does NOT Do
This context module provides economic knowledge, **not** design authority:
- **Does NOT prescribe balance decisions.** Economy Designer or Game Designer owns resource ratios, drop rates, and tax structures. This module informs their work.
- **Does NOT forecast market behavior.** Provides patterns and historical lessons, not price predictions. Real-time market analysis is Analytics Engineer's domain.
- **Does NOT recommend specific feature implementations.** Explains economy systems; does not decide which systems to build first or how to implement them.
- **Does NOT cover player psychology or behavioral incentives.** That's Game Designer's responsibility. This module focuses on flows, not motivation.
- **Does NOT replace playtesting data.** Theory without player data is untested. Always validate assumptions with economy telemetry and community feedback.
## Not Covered in This Module
- Specific resource balancing numbers
- Price history and market data
- Individual ship/smart assembly cost breakdowns
- Tax and fee structures
- Long-term economic forecast models
