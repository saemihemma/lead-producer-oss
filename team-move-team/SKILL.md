---
name: "Move Team"
description: "Cross-functional Move and Sui team for smart contracts, off-chain integration, security, and economy soundness. Use when on-chain correctness needs to be reviewed together with integration and economic implications."
---
# Move Team
## Purpose
Move Team reviews whether a Move or Sui feature is correct on-chain, safe to integrate off-chain, and coherent with the economy it affects.

## Composition
- **role-move-sui-developer**: contract correctness, invariants, and transaction shape
- **role-backend-engineer**: off-chain integration, service boundaries, and data flow
- **role-security-engineer**: exploitability, access control, and attack surface
- **role-economy-designer**: economic incentives and flow implications
- **lead-producer**: synthesis, trade-offs, and acceptance

## Use When
- reviewing a Move package, contract integration, or token-system change
- checking smart-contract changes that affect off-chain flows
- evaluating Sui security and economic implications together
- validating on-chain and off-chain responsibility boundaries

## Do NOT Use When
- the task is generic backend work with no on-chain component
- the question is pure economy analysis with no contract logic
- the work is frontend or deployment review

## Workflow
1. Identify the core invariants, integration points, and value-moving transactions.
2. Review on-chain correctness, off-chain handling, security, and incentive shape together.
3. Surface conflicts explicitly when safety, feasibility, and economic goals disagree.
4. Use Lead Producer to synthesize one contract-plus-integration verdict.

## Default Output
```text
MOVE TEAM REVIEW
================
On-Chain:
- invariant and contract findings

Integration:
- off-chain boundary risks
- data-flow concerns

Security and Economy:
- exploit or access-control risks
- incentive or flow risks

Recommendation:
- ship / revise / escalate
- highest-priority fixes
```

## Success Criteria
- On-chain, off-chain, security, and economic perspectives all appear in the result.
- Invariants stay explicit.
- The output can guide a safe integration decision.
