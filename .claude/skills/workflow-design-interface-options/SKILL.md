---
name: workflow-design-interface-options
description: "Interface design comparison: produce 3+ competing API or module designs, compare them, and recommend one before coding. Use when multiple plausible interface shapes exist."
---
# Design Interface Options Workflow

## Purpose
Decide how an interface should feel to its callers. For module seams, API shapes, and local design choices — not whole-system architecture.

## Use When
- Multiple reasonable API or module shapes exist
- Team is uncertain which interface ages best
- Want to compare simplicity, flexibility, and implementation cost before coding
- Architecture is settled but one boundary needs deliberate design

## Do NOT Use When
- Broad system decomposition or platform strategy
- Interface is obvious and risk is implementation quality
- Immediate problem is reproducing a bug

## Workflow
1. Restate the job the interface must do, including highest-cost mistakes.
2. Identify primary callers, inputs, outputs, failure modes.
3. Draft at least 3 genuinely different options (not cosmetic variants).
4. Compare in prose: simplicity, generality, implementation efficiency, module depth.
5. Recommend one option with rationale.

## Option Design Rules
- Optimize for clear call sites, not just elegant internals.
- Make invalid states difficult to express.
- Prefer deep modules with small surfaces over wide interfaces leaking implementation.
- Keep comparison concrete enough for immediate implementation.

## Default Output
1. Problem statement and constraints
2. 3+ materially different interface options
3. Prose comparison across simplicity, generality, efficiency, depth
4. Recommended direction with rationale

## Anti-Patterns
- One favored option plus two token alternatives.
- Comparing implementation details without discussing caller experience.
- Turning local interface exercise into full architecture rewrite.

## Output Discipline
- Follow the Default Output structure as both minimum and maximum. Do not add extra sections.
- Keep findings concise: 2-5 points per section.

## Anti-Drift Rules
- Three genuinely different options, not three cosmetic variants of one idea.
- Optimize for clear call sites, not elegant internals.
- Do not turn a local interface exercise into a full architecture rewrite.
- If the interface choice is obvious, say so and skip the comparison exercise.
