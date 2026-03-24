---
name: team-move-team
description: "Move/Sui team: smart contract correctness, off-chain integration, security, and economy soundness reviewed together. Use for contract changes affecting integration or economic flows."
context: fork
effort: high
---
# Move Team

## Purpose
Review whether a Move/Sui feature is correct on-chain, safe to integrate off-chain, and coherent with the economy it affects.

## Composition
- **role-move-sui-developer**: contract correctness, invariants, transaction shape
- **role-backend-engineer**: off-chain integration, service boundaries, data flow
- **role-security-engineer**: exploitability, access control, attack surface
- **role-economy-designer**: economic incentives, flow implications
- Synthesis: trade-offs, acceptance

## Use When
- Reviewing Move package, contract integration, token-system change
- Checking smart-contract changes affecting off-chain flows
- Evaluating Sui security and economic implications together
- Validating on-chain/off-chain responsibility boundaries

## Do NOT Use When
- Generic backend with no on-chain component
- Pure economy analysis with no contract logic
- Frontend or deployment review

## Workflow
1. Identify core invariants, integration points, value-moving transactions.
2. Review on-chain correctness, off-chain handling, security, incentive shape together.
3. Surface conflicts when safety, feasibility, economic goals disagree.
4. Synthesize one contract-plus-integration verdict.

## Default Output
```text
MOVE TEAM REVIEW
================
On-Chain: invariant/contract findings
Integration: off-chain boundary risks, data-flow concerns
Security/Economy: exploit/access-control risks, incentive/flow risks
Recommendation: ship / revise / escalate, highest-priority fixes
```

## Conflict Resolution
- Move/Sui Developer owns on-chain correctness. Security Engineer can block on exploitability.
- Economy Designer flags incentive risks but does not override contract safety.

## Anti-Drift Rules
- Invariants are non-negotiable. Do not weaken invariant protection for convenience.
- Do not expand into off-chain architecture unless the contract boundary depends on it.
