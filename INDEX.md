# Agent Skills Index
Master registry for the local skill pack.

- Start with **Quick Routing**.
- Use **Disambiguation** when skills overlap.
- Load only the specific `SKILL.md` files you need.

**Inventory:** 47 local skills - 27 roles, 3 context modules, 13 teams, 4 workflows
**Hierarchy:** User -> Codex -> optional Lead Producer -> specialist roles
**System Model:** Lead Producer chooses who works. Superpowers overlays shape how coding work runs. External docs and design overlays stay optional helpers, not owners.
**Lean Rule:** Prefer new routes over new doctrine.
**Install Note:** For the merged Lead Producer + Superpowers experience, install Superpowers separately and make this repo discoverable as the local skill pack. See [`.codex/INSTALL.md`](.codex/INSTALL.md).

---
## Universal Operating Principles
These apply to all agents regardless of role. Lead Producer enforces them on every deliverable.

### Replace, Don't Accumulate
Agents default to additive behavior. Fight that tendency.
1. Read the full current state before changing it.
2. Remove the old before adding the new.
3. Verify uniqueness after editing.
4. Flag bloat instead of feeding it.

This applies beyond code: product cuts stale scope, docs retire stale docs, architecture flags decommission targets, and design removes duplicate UI paths.

**The test:** After the work, is the system simpler or the same complexity as before? If it is more complex, justify why.

### Start From the Problem, Not the Current State
When something is broken, anchor on intended behavior first. Patching patches creates scar tissue. If the current state is too tangled to patch cleanly, propose a rewrite of that component.

### One Job Per Artifact
Files, components, functions, and documents should each have one clear purpose. If an artifact is doing two jobs, split it. If it exceeds a reasonable size (500 lines for code, 400 lines for skills, 300 lines for docs), it is probably doing too much.

---
## External Process Overlays (Superpowers)
These overlays are supported in the merged system, but they are **not counted in the local inventory above**.

| External Skill | What It Does | Route When | Does NOT |
|----------------|--------------|------------|----------|
| `superpowers:systematic-debugging` | Root-cause-first debugging process for bugs, regressions, flaky behavior, and unexpected technical failures | The next step is investigation, reproduction, or narrowing the fault before proposing fixes | Replace domain ownership, architecture review, or local triage packaging |
| `superpowers:test-driven-development` | Strict test-first execution method for implementation, bugfixes, and risky refactors | Behavior-sensitive code changes need disciplined execution | Replace QA strategy, architecture design, or local routing |
| `superpowers:writing-plans` | High-rigor implementation planning before coding starts | The task is real multi-step technical work with meaningful sequencing risk | Replace product scoping, architecture judgment, or team composition |
| `superpowers:verification-before-completion` | Finish gate that requires fresh evidence before claiming technical success | Any technical task is about to be called done, fixed, or passing | Replace testing strategy, code review, or synthesis |
| `superpowers:dispatching-parallel-agents` | Parallel-agent execution overlay for truly independent technical workstreams | There are 2+ independent technical failures or slices with low shared-state risk | Replace Lead Producer synthesis or justify parallelism where one root cause may explain everything |

---
## External Docs & Design Overlays
These overlays stay external on purpose. Use them as helpers when they are installed and available, not as local owners. They are not part of the base merged install for this repo.

| External Overlay | What It Does | Route When | Does NOT |
|------------------|--------------|------------|----------|
| `context7` | Provides current library and framework docs | APIs, setup steps, or library behavior may have changed and the helper is available | Replace `role-context-manager`, local ownership, or product judgment |
| `brand-guidelines` | Provides upstream brand-system guidance patterns | A brand system or consistency question benefits from external brand heuristics and the helper is available | Replace `team-brand-team` ownership |
| `frontend-design` | Provides upstream frontend design exploration patterns | Visual direction or UI concepting needs fresh design-language guidance and the helper is available | Replace `team-frontend-team` implementation judgment or local brand ownership |

---
## Roles (27)
### Engineering
| Skill | What It Does | Route When | Does NOT |
|-------|-------------|------------|----------|
| `role-principal-software-engineer` | Code quality, maintainability, tech debt ROI, reliability-first ordering | Code review, refactoring decisions, "is this code good?" | Product direction, UI, economy |
| `role-code-reduction-engineer` | Removes dead, duplicate, or unnecessarily complex code while preserving architecture truth and behavior | Cleanup, simplification, dead-code removal, collapsing accidental complexity | Architecture pivots, protocol shifts, product behavior changes |
| `role-backend-engineer` | APIs, DB optimization, caching, N+1 detection, transaction isolation | API design review, "why is this query slow?", service integration | Frontend, product strategy |
| `role-frontend-engineer` | Components, state management, accessibility, performance budgets, rendering behavior | Frontend feature review, "is this accessible?", rendering perf | Backend, databases, infra |
| `role-move-sui-developer` | Sui object model, ownership invariants, gas optimization, PTB composition, capability patterns | Smart contract audit, Move code review, on-chain feature design | Off-chain integration, economy design |
| `role-devops-engineer` | CI/CD pipelines, monitoring, incident response, IaC, deployment strategies | "How do we deploy this?", post-incident review, monitoring gaps | Features, business logic, balance |
| `role-railway-deployment` | Railway config, scaling policies, Docker optimization, env var placement | Railway-specific deployment, cost optimization, scaling config | Application logic, architecture decisions |
| `role-data-engineer` | Pipelines, schema design, data quality SLAs, CDC patterns | "Is this pipeline reliable?", data freshness issues, schema migration | Metric meaning, API design, business logic |

### Architecture & Security
| Skill | What It Does | Route When | Does NOT |
|-------|-------------|------------|----------|
| `role-software-architect` | C4 modeling, ADRs, system decomposition, failure mode analysis, API versioning | New system design, major refactor, "how should we structure this?" | Code quality details, testing strategy |
| `role-security-engineer` | STRIDE threat modeling, exploit analysis, auth/authz audit, supply-chain review | Security audit, "is this safe?", pre-launch security review | Performance tuning, UX, provisioning |
| `role-scalability-engineer` | Bottleneck identification, load profiling, capacity planning, RED metrics, cost-scaling analysis | "Will this scale to 10x?", load test design, performance investigation | Feature design, business logic, balance |
| `role-qa-engineer` | Test strategy, risk-based coverage, flaky test diagnosis, quality gates | "What should we test?", test gap analysis, verification design | Writing features, architecture decisions |

### Product & Design
| Skill | What It Does | Route When | Does NOT |
|-------|-------------|------------|----------|
| `role-cto` | Strategic tech decisions, TCO analysis, vendor evaluation, org-level trade-offs | "Should we adopt X?", build-vs-buy, architecture approval | Day-to-day engineering, code review |
| `role-product-manager` | RICE scoring, MVP definition, post-launch iteration, scope control | Feature proposals, "should we build this?", roadmap prioritization | Technical architecture, testing, implementation |
| `role-technical-product-manager` | Feasibility gating, dependency scoring, pre-mortems, migration risk | "Can we actually build this?", timeline estimation, hidden complexity discovery | Business strategy, code quality, architecture |
| `role-game-designer` | Core loops, MDA framework, difficulty curves, meaningful choice, emergent gameplay | "Is this fun?", player motivation analysis, onboarding flow | Economy balancing, implementation details, stat budgets |
| `role-ui-ux-designer` | User flows, cognitive load, visual hierarchy, affordances, error recovery, accessibility | "Can users accomplish their goal?", accessibility audit, UX friction analysis | Backend logic, build tooling, data modeling |
| `role-brand-strategist` | Brand voice, positioning, visual rules, and cross-surface consistency | Brand system definition, tone/voice decisions, identity application guidance | Raw frontend implementation, product prioritization, generic UX QA |

### Economy & Balance
| Skill | What It Does | Route When | Does NOT |
|-------|-------------|------------|----------|
| `role-economy-designer` | Faucets, sinks, converters, marketplace mechanics, crafting ratios, currency design | Resource pipelines, marketplace architecture, crafting systems | Monetary policy (`role-economist`), player psychology (`role-behavioral-economist`) |
| `role-economist` | Money supply, inflation/deflation, wealth concentration, fiscal levers, RMT analysis | Inflation checks, wealth distribution, tax or sink policy | System design, player psychology, combat balance |
| `role-behavioral-economist` | Loss aversion, anchoring, prospect theory, FOMO, sunk cost, framing effects | "Why are players hoarding?", panic selling, real-behavior prediction | System design, monetary policy |
| `role-game-balance-designer` | Progression curves, stat budgets, TTK/DPS, death penalties, PvP fairness | "Is this weapon overpowered?", progression pacing, destruction tuning | Economic flows, marketplace mechanics |

### Analytics & Data
| Skill | What It Does | Route When | Does NOT |
|-------|-------------|------------|----------|
| `role-analytics-engineer` | Metrics definition, telemetry instrumentation, dashboard hierarchy, anomaly detection | "How do we measure success?", A/B test setup, dashboard design | Data pipelines, product strategy, system architecture |

### Documentation & Community
| Skill | What It Does | Route When | Does NOT |
|-------|-------------|------------|----------|
| `role-technical-writer` | Diataxis, audience analysis, progressive disclosure, API docs, ADR writing, changelogs | System docs, API reference, onboarding guide, ADRs | Code architecture, system design, product strategy |
| `role-open-source-engineer` | License compliance, dependency CVE audit, SBOM, release management, code hygiene | "Can we open source this?", dependency risk assessment, contribution workflow design | Feature development, community engagement strategy |
| `role-community-developer` | Contributor onboarding, governance models, community health metrics, extensibility, RFC processes | "How do we attract contributors?", community health audit, governance design | Code quality, license compliance, marketing |

### Meta
| Skill | What It Does | Route When | Does NOT |
|-------|-------------|------------|----------|
| `role-context-manager` | Persists critical state to `_context/`, triages keep/persist/drop, and checkpoints before context degrades | Context usage >60%, before large tasks, multi-agent handoffs, or context-heavy sessions | Replace documentation, manage user files, or substitute for current library docs |

---
## Workflows (4)
Use local workflows when the question is about repo-specific execution packaging, interface comparison, or library-specific routing rather than domain ownership alone.

| Skill | What It Does | Route When | Does NOT |
|-------|-------------|------------|----------|
| `workflow-test-driven-development` | Local adapter that routes the right owners into `superpowers:test-driven-development` while preserving local context | A team or role should implement under strict TDD without losing domain ownership | Replace `superpowers:test-driven-development`, QA strategy, or architecture review |
| `workflow-design-interface-options` | Produces 3+ interface or API options, compares them, and recommends one | Module/API/interface-shape decisions with multiple plausible designs | Replace full-system architecture review, implementation review, or bug investigation |
| `workflow-issue-triage` | Packages a debug investigation into a local markdown artifact and handoff plan | A bug investigation needs a durable local artifact, next-step slices, or a clean handoff | Replace `superpowers:systematic-debugging`, implementation, or final technical review |
| `workflow-shadcn-ui` | Routes shadcn/ui component work through current docs, component selection, theming, and accessibility checks | React/Tailwind/shadcn/ui page or component work needs a tight library-specific method | Replace `role-frontend-engineer`, brand ownership, or generic frontend design |

---
## Context Modules (3)
Load alongside any team when the task involves EVE Frontier. Skip them for generic software work.

| Module | Loads When | Skip When | Key Content |
|--------|-----------|-----------|-------------|
| `frontier-tech-context` | The task involves Frontier tech stack details such as Rust, Move, Sui, MUD, or smart assemblies | Pure backend/frontend work with no Frontier-specific tech; generic architecture review; non-Frontier infra | Rust backend, Move/Sui smart contracts, MUD, on-chain/off-chain bridge, smart assemblies |
| `frontier-economy-context` | The task involves Frontier economy, marketplace, resource, or token questions | Generic software economy patterns; non-Frontier game economy; pure monetary theory | Resource pipeline DAG, marketplace structure, token flows, wealth distribution, Frontier-specific lessons |
| `frontier-game-context` | The task involves Frontier loops, progression, PvP, tribes, or loss mechanics | Generic game design; non-Frontier analysis; pure balance work that does not need Frontier specifics | Core loops, tribes, smart assembly gameplay, progression, PvP/loss mechanics |

---
## Teams (13)
All teams include Lead Producer as coordinator. All report: LP -> Codex -> user.

| Team | Members | Deploy When | Do NOT Deploy When | Key Artifact |
|------|---------|------------|-------------------|-------------|
| `lead-producer` | Lead Producer + Devil's Advocate | Every task that needs autonomous routing, synthesis, or stress-testing | Never skip when orchestration itself is the ask | Synthesis report with confidence + stress-test summary |
| `team-red-team` | Security + Scalability + Economy Designer + Behavioral Economist | Pre-launch, exploit hunting, adversarial review, high-stakes failure analysis | Constructive code review, routine feature work, documentation | Severity-ranked vulnerability report, Go/No-Go |
| `team-blue-team` | QA + Architect + Principal Eng + Lead Producer + optional domain specialist | Simplification, reduction, or cleanup work must be verified against behavior and architecture truth | Raw implementation, product prioritization, adversarial exploit hunting | Regression and architecture-preservation verdict |
| `team-dev-team` | Architect + Principal Eng + QA | Code review, design review, implementation validation | Security audits, UI/UX work, economy changes | Unified technical assessment with quality score |
| `team-frontend-team` | UI/UX + Frontend + Backend (advisor) | UI features, accessibility audits, frontend + API integration, shadcn/ui work | Pure backend work, infra, economy design | UX-technical conflict analysis with resolutions |
| `team-brand-team` | Brand Strategist + UI/UX + Technical Writer + Community Dev + Lead Producer + optional Frontend Eng | Brand system definition, tone/voice alignment, cross-surface identity, brand application guidance | Raw frontend implementation, generic product prioritization, docs production with no brand question | Canonical brand system + implementation handoff |
| `team-architecture-review` | Architect + CTO + Scalability + Security + TPM | System design, migrations, major refactors, tech choices | Small code changes, UI tweaks, economy-only changes, routine deploys | Verified architecture diagram (Mermaid) + reversibility-ranked findings |
| `team-product-team` | PM + TPM + Game Designer + Analytics | Feature proposals, go/no-go, roadmap, scope negotiation | Pure technical review with no product question, infra ops, code review | Feasibility-value matrix + Go/No-Go + measurement plan |
| `team-economy-team` | Economy Designer + Economist + Behavioral Economist + Security (risk only) + PM + Analytics | Economy design, reward systems, marketplace, monetary policy | Pure combat balance, frontend work, infra | Economy health assessment: systems + monetary + behavioral |
| `team-move-team` | Move Dev + Backend + Security + Economy Designer | Smart contracts, token systems, off-chain integration | Pure off-chain backend, pure economy modeling, frontend | On-chain/off-chain integration report with security sign-off |
| `team-infrastructure` | DevOps + Railway + Scalability + Security + Data Eng | Deployment, ops, scaling, cost optimization, post-incident review | Application code review, feature design, economy changes | Infrastructure audit with deployment checklist |
| `team-documentation` | Technical Writer + TPM | API docs, guides, ADRs, knowledge bases, onboarding | Code comments, marketing copy, UI microcopy | Structured documentation per Diataxis |
| `team-open-source` | Open Source Eng + Community Dev + Security + TPM | Open sourcing, dependency evaluation, community health | Internal code review, feature development, marketing campaigns | Open source readiness report with compliance sign-off |

---
## Quick Routing
| "I need..." | Deploy |
|-------------|--------|
| Security or exploit review | `team-red-team` |
| Code review | `team-dev-team` |
| Remove dead code safely | `lead-producer` + `role-code-reduction-engineer` + `team-blue-team` |
| Simplify without changing architecture | `lead-producer` + `role-code-reduction-engineer` + `team-blue-team` |
| Architecture decision | `team-architecture-review` |
| UI or UX work | `team-frontend-team` |
| Define a brand system | `lead-producer` + `team-brand-team` |
| Apply brand to a UI | `lead-producer` + `team-brand-team` + `team-frontend-team` |
| shadcn/ui method, setup, or docs question | `lead-producer` + `workflow-shadcn-ui` + optional `context7` |
| Build or review a shadcn/ui screen/component | `lead-producer` + `workflow-shadcn-ui` + `team-frontend-team` + optional `team-brand-team` |
| Feature evaluation | `team-product-team` |
| Economy design or analysis | `team-economy-team` |
| Smart-contract work | `team-move-team` |
| Deployment or infrastructure | `team-infrastructure` |
| Documentation | `team-documentation` |
| Open source readiness | `team-open-source` |
| "Just handle it" | `lead-producer` |
| Fix a Sui bug safely | `lead-producer` + `superpowers:systematic-debugging` + `team-move-team` |
| Implement a feature carefully | `lead-producer` + `superpowers:test-driven-development` + `team-dev-team` |
| Design an API before coding | `lead-producer` + `workflow-design-interface-options` + `role-software-architect` / `role-principal-software-engineer` |
| Write a real implementation plan | `lead-producer` + `superpowers:writing-plans` |
| Verify before calling it done | `superpowers:verification-before-completion` |
| Investigate a bug and produce a fix plan | `workflow-issue-triage` |
| Monetary policy only | `role-economist` |
| Player behavior prediction | `role-behavioral-economist` |
| Combat or progression numbers | `role-game-balance-designer` |
| Context window running low | `role-context-manager` |

---
## Disambiguation: Common Confusions
| If you're unsure between... | Choose |
|----------------------------|--------|
| Economy Designer vs Economist | Economy Designer for system pipes and sinks; Economist for monetary health and policy |
| Economist vs Behavioral Economist | Economist for rational-market analysis; Behavioral Economist for real player behavior |
| Game Designer vs Game Balance Designer | Game Designer for experience and loops; Balance Designer for numbers and fairness |
| Principal Eng vs Backend Eng | Principal for cross-cutting code quality; Backend for server-side data and API depth |
| Principal Eng vs Code Reduction Engineer | Principal for overall code quality; Code Reduction for targeted deletion and simplification |
| Security Engineer vs QA Engineer | Security for attacks and abuse; QA for correctness and regression |
| Blue Team vs Dev Team | Blue Team for cleanup verification; Dev Team for broader technical review |
| Lead Producer vs Superpowers overlays | Lead Producer chooses owners; Superpowers overlays tighten coding execution |
| QA Engineer vs `workflow-test-driven-development` | QA for coverage strategy; TDD workflow for test-first execution |
| `workflow-test-driven-development` vs `superpowers:test-driven-development` | Local workflow for routing; Superpowers for strict TDD doctrine |
| DevOps vs Railway Deployment | DevOps for general operations; Railway for platform-specific deployment |
| Product Manager vs Technical PM | PM for value and prioritization; TPM for feasibility and rollout risk |
| Software Architect vs `workflow-design-interface-options` | Architect for system shape; workflow for local interface comparison |
| Brand Team vs Frontend Team | Brand Team for identity standards; Frontend Team for implementation quality |
| `workflow-shadcn-ui` vs `role-frontend-engineer` | Workflow for shadcn/ui method; Frontend Engineer for broader frontend quality |
| Dev Team vs `workflow-issue-triage` | Dev Team for technical assessment; issue triage for packaging an investigation |
| `workflow-issue-triage` vs `superpowers:systematic-debugging` | Issue triage for handoff artifacts; Superpowers for root-cause debugging |
| `context7` vs `role-context-manager` | `context7` for current external docs; Context Manager for working-memory hygiene |
