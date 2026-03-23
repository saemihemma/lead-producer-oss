---
name: "Economy Team"
description: "Cross-functional economy analysis for game or platform economies. Use when you need flow design, monetary health, player-behavior prediction, exploit risk review, and product or analytics impact synthesized into one economy assessment."
---
# Economy Team
## Purpose
Economy Team evaluates whether an economy is structurally sound, behaviorally credible, strategically useful, and resilient to exploit pressure.

## Composition
- **role-economy-designer**: faucets, sinks, converters, and loop closure
- **role-economist**: inflation, liquidity, wealth distribution, and monetary stability
- **role-behavioral-economist**: real player behavior, bias, hoarding, and panic dynamics
- **role-security-engineer**: exploit pressure and obvious economic attack surfaces
- **role-product-manager**: player value, retention fit, and business alignment
- **role-analytics-engineer**: metrics, anomaly detection, experiments, and monitoring
- **lead-producer**: synthesis, conflict handling, and acceptance

## Use When
- designing or reviewing a currency, marketplace, reward, or crafting system
- tuning core economy parameters with player-impact risk
- investigating inflation, liquidity, wealth concentration, or exploit pressure
- evaluating an economy change against product goals and telemetry

## Do NOT Use When
- the question is only combat or progression balance with no economy-system component
- the task is a pure security exploit audit better owned by `team-red-team`
- the work is raw implementation rather than analysis or recommendation
- the ask is generic product prioritization with no economy question

## Workflow
1. Load truth sources: live metrics, design intent, current rules, and known player feedback.
2. Run specialist perspectives in parallel by default.
3. Reconcile theory with observed behavior; when data exists, do not let theory overrule it.
4. Separate structural flaws, monetary risks, behavioral risks, exploit risks, and product risks.
5. Hand the merged assessment to Lead Producer for synthesis, trade-offs, and escalation if needed.

## Default Output
```text
ECONOMY TEAM ASSESSMENT
=======================
System Design:
- faucet, sink, and converter findings
- loop-closure or balance risks

Monetary Health:
- inflation, liquidity, and distribution findings

Behavior:
- player incentives and likely irrational responses

Exploit Pressure:
- economic attack surfaces
- severity and urgency

Product and Analytics:
- player-value implications
- metrics to monitor or experiment on

Verdict:
- keep / tune / rework / escalate
- highest-priority interventions
```

## Success Criteria
- Structural, monetary, behavioral, security, and product perspectives are all represented.
- Conflicts between theory and observed behavior are explicit.
- Recommendations preserve player trust as well as economic stability.
- The output gives clear follow-up actions and monitoring hooks.
