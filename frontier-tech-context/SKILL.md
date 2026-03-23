---
name: Frontier Tech Context
description: Technical landscape reference for EVE Frontier - core stack, architecture, infrastructure, smart assemblies, constraints, and known technical challenges. Load alongside role skills to provide domain-specific technical knowledge.
---
# Frontier Tech Context
This module provides structured reference information about the technical foundation of EVE Frontier. Use alongside role skills (Security Engineer, Performance Lead, etc.) to ground domain-specific analysis in concrete technical reality.
## Core Tech Stack
**Backend Services**
- Language: Rust (performance-critical simulation and network handling)
- Game Server: Real-time simulation engine for gameplay state
- Deployment: Railway.app for containerized services
- Databases: PostgreSQL for persistent state, Redis for caching and session data
- Networking: Real-time client-server architecture with state synchronization
**Smart Contracts & Smart Assemblies**
- Blockchain: Sui (Move-based smart contract platform)
- Language: Move (Sui's programming language for smart contracts)
- Execution Model: Smart Assemblies are on-chain programmable objects deployed as Move modules
- **Critical constraint:** Smart Assembly code is immutable once deployed. Updates require new deployment (gas cost). Test thoroughly before mainnet.
- Examples: Toll gates, defensive turrets, fuel stations, mining operations - all running on-chain
**Frontend**
- Language: TypeScript / React
- Client Architecture: Browser-based game client communicating with backend over WebSocket
- UI State: Separate from game state (client-side rendering, server-side game logic)
## Architecture Patterns
**MUD Framework Integration**
- **Status:** [Used or aspirational / - VERIFY with team]
- On-chain world state managed via MUD (Mud framework for decentralized games)
- Provides structured data layer for entities, components, and world state
- Enables deterministic simulation of on-chain elements
**On-Chain / Off-Chain Bridge**
- Game server maintains authoritative game state (off-chain)
- Smart Assemblies execute on Sui blockchain (on-chain)
- Bridge syncs critical state changes: smart assembly positions, operational status, resource consumption
- Latency: On-chain operations subject to Sui finality times (~1-2 seconds) and gas costs
- Off-chain operations near-instant (client-server latency ~100-500ms typical)
**Shared vs Owned Objects (Sui Model)**
- Shared objects: Slower but required for multi-writer access (e.g., global marketplace, consensus state)
  - Latency impact: ~1-2 second consensus delay. Approximate for operations: shared read 5-10ms, write 1-2s (consensus).
- Owned objects: Fast, single-owner mutation (e.g., player inventory, personal smart assemblies)
  - Latency impact: ~50-100ms finality.
- Smart Assemblies: Typically owned by tribe/corporation or shared if globally accessible
- Performance rule: Use owned objects when possible; reserve shared for truly global state (marketplace, scoreboard).
## Infrastructure & Deployment
**Development & CI/CD**
- Version Control: GitHub
- CI/CD Pipelines: Automated testing, staging environment deployments
- Staging Environment: Pre-production testing before mainnet release
- Local Development: Rust toolchain, Node.js for frontend, Sui devnet for contract testing
**Data Layer**
- PostgreSQL: Player accounts, game state persistence, transaction history
- Redis: Session caching, leaderboards, real-time state for high-frequency queries
- Backups: Standard database replication and point-in-time recovery
## Smart Assemblies: Technical Model
**Definition**
- Programmable on-chain objects authored in Move
- Persistent world entities with state and behavior
- Executed as Sui smart contracts
- Can own resources, perform transactions, modify world state
**Common Patterns**
- **Toll Gates**: Charge passage fee in resources, maintain list of authorized users/tribes
- **Defensive Turrets**: Target enemies based on configured rules, consume fuel per shot
- **Fuel Stations**: Accept fuel resources, provide refueling service, maintain inventory
- **Mining Operations**: On-chain resource generation and management
**Move Language Limitations**
- No floating-point arithmetic (use fixed-point or integer ratios)
- Limited standard library (no external dependencies; Move is designed for simplicity)
- Focus on formal verification (strict syntax, no undefined behavior)
- Each operation consumes gas (measured in SUI tokens)
**SUI Gas Cost Ranges (order-of-magnitude estimates):**
- Owned object read/write: 10-50 units gas (~$0.001-0.005 at typical rates)
- Shared object write: 100-500 units gas (consensus overhead)
- Cryptographic verification: 500+ units gas
- Storage: ~1 unit/byte stored on-chain (permanent cost)
- Example: Toll gate toll transaction (shared object update + storage) ~300 gas units (~$0.03)
## Key Technical Constraints
**State Synchronization**
- Game server and blockchain have different timing models
- Blockchain: Deterministic, final, slower (finality time ~1-2 seconds)
- Game server: Fast, soft-state, replayed on reconnection
- Conflict resolution: Game server authoritative for gameplay, blockchain authoritative for shared resources/PvP truth
**Latency & Responsiveness**
- Real-time gameplay: Client <-> Server (sub-second)
- On-chain operations: 1-2 second finality, subject to network congestion
- Player actions have different latencies: local gameplay instant, blockchain-backed actions delayed
- UX challenge: Communicating blockchain delays to players without breaking immersion
**Composability & Gas Costs**
- Smart Assemblies must be composed by tribe engineers (players) or CCP dev team
- Each interaction with on-chain object incurs gas cost (Sui tokens)
- High-frequency interactions problematic (e.g., small transactions per ore mined)
- Batch operations needed for efficiency
**Scalability of Shared Objects**
- Shared objects in Sui have contention limits
- Global marketplace, world consensus mechanisms require shared objects
- Scaling strategy: Shard by region, use move capabilities to delegate authority
## Development Workflow
**Iteration Cycle**
- Local development: Rust backend, Sui devnet for contracts
- Staging: Sui testnet deployment, full game client testing
- Production: Mainnet deployment with gas cost implications
- Rapid iteration: Balance between moving fast and on-chain permanence
**Testing Strategy**
- Unit tests: Rust game logic, Move smart assembly logic
- Integration tests: Client-server communication, on-chain/off-chain sync
- Load testing: Real-time client concurrency, shared object contention
- Community testing: Early access playtest environment
## Known Technical Challenges
1. **State Synchronization**: Keeping off-chain game state and on-chain smart assembly state consistent under network partitions and rapid gameplay changes
2. **Smart Assembly Composability**: Complex multi-object transactions difficult in Move; explosion of possible state combinations
3. **Shared Object Contention**: High-traffic shared objects (marketplace, world state) hit Sui throughput limits; need sharding strategy
4. **Gas Cost Predictability**: Players may encounter unexpected gas costs for actions; education and UI transparency needed
5. **Move Developer Experience**: Limited ecosystem, formal verification constraints, learning curve for game developers
6. **Client Desyncs**: Off-chain game server and client can diverge; need robust resync logic on reconnection
7. **PvP Exploit Surface**: On-chain treasury vulnerable to smart assembly bugs; need formal audits before high-stakes features
## Explicit Labels Used in This Context
- **Currently implemented:** Features live on Sui mainnet now.
- **In design:** Features under development, not yet deployed.
- **[DATA GAP]:** Information missing or unverified; needs confirmation.
- **[VERIFY]:** Assumption that needs team confirmation.
## What This Module Does NOT Do
This context module provides technical knowledge, **not** architectural authority:
- **Does NOT make technology choices.** CTO and Software Architect own platform decisions, stack selection, and infrastructure roadmap. This module informs their analysis.
- **Does NOT replace performance measurement.** Describes known constraints; real performance data from benchmarks and production telemetry is authoritative.
- **Does NOT dictate smart assembly design patterns.** Lists technical limitations; actual design patterns and best practices are owned by Move-Sui Developer and Principal Engineer.
- **Does NOT cover operational runbooks or incident response.** DevOps Engineer owns those. This module explains the technical foundations only.
- **Does NOT predict scalability at untested volumes.** Estimates and patterns provided; actual scaling requires load testing and capacity planning by DevOps/SRE.
## Not Covered in This Module
- Specific API endpoint documentation
- Detailed contract code
- Performance benchmarks
- Incident response procedures
- Smart Assembly example implementations
