---
name: team-economy-team
description: "Economy analysis team: flow design, monetary health, player behavior, exploit risk, and product impact synthesized. Use for economy design, reward systems, marketplace, or monetary policy review."
context: fork
effort: high
---
# Economy Team

## Purpose
Evaluate whether an economy is structurally sound, behaviorally credible, strategically useful, and resilient to exploit pressure.

## Composition
- **role-economy-designer**: faucets, sinks, converters, loop closure
- **role-economist**: inflation, liquidity, wealth distribution, monetary stability
- **role-behavioral-economist**: real player behavior, bias, hoarding, panic
- **role-security-engineer**: exploit pressure, economic attack surfaces
- **role-product-manager**: player value, retention fit, business alignment
- **role-analytics-engineer**: metrics, anomaly detection, experiments
- Synthesis: conflict handling, acceptance

## Use When
- Designing or reviewing currency, marketplace, reward, crafting system
- Tuning core economy parameters with player-impact risk
- Investigating inflation, liquidity, wealth concentration, exploit pressure
- Evaluating economy change against product goals and telemetry

## Do NOT Use When
- Only combat/progression balance with no economy component
- Pure security exploit audit (use `team-red-team`)
- Raw implementation rather than analysis
- Generic product prioritization with no economy question

## Workflow
1. Load truth sources: live metrics, design intent, current rules, player feedback.
2. Run specialist perspectives in parallel.
3. Reconcile theory with observed behavior; data overrules theory when it exists.
4. Separate structural, monetary, behavioral, exploit, and product risks.
5. Synthesize with trade-offs and escalation if needed.

## Default Output
```text
ECONOMY TEAM ASSESSMENT
=======================
System Design: faucet/sink/converter findings, loop-closure risks
Monetary Health: inflation, liquidity, distribution findings
Behavior: player incentives, likely irrational responses
Exploit Pressure: economic attack surfaces, severity/urgency
Product/Analytics: player-value implications, metrics to monitor
Verdict: keep / tune / rework / escalate, highest-priority interventions
```

## Conflict Resolution
- Economy Designer owns structural decisions. Economist owns monetary policy recommendations.
- Behavioral Economist flags likely real behavior but does not override structural or monetary decisions.
- Security flags exploit risks as hard constraints. Product Manager flags business alignment.
- When theory and observed data conflict, data wins.

## Anti-Drift Rules
- Do not let theoretical elegance override observed player behavior.
- Separate structural, monetary, behavioral, and exploit findings; do not merge them into vague "economy issues."
- If team cannot resolve a structural vs policy conflict, escalate with both positions documented.
