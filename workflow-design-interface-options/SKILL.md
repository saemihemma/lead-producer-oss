---
name: workflow-design-interface-options
description: Use when a module, API, or interface has multiple plausible designs and you want 3 or more competing options, a comparison, and a clear recommendation before implementation.
---
# Design Interface Options Workflow
## Purpose
Use this workflow when the hard part is deciding how an interface should feel to its callers. It is for module seams, API shapes, and local design choices, not whole-system architecture review.

## Use When
- There are multiple reasonable API or module shapes
- The team is uncertain which interface will age best
- You want to compare simplicity, flexibility, and implementation cost before coding
- Architecture is mostly settled, but one boundary or contract still needs deliberate design

## Do NOT Use When
- The task is broad system decomposition or platform strategy
- The interface is already obvious and the main risk is implementation quality
- The immediate problem is reproducing and understanding a bug

## Default Output
Produce:
1. A short problem statement and constraints
2. At least 3 materially different interface options
3. A prose comparison across:
   - simplicity
   - generality
   - implementation efficiency
   - module depth
4. One recommended direction with rationale

Persist to `_artifacts/interface-options-<slug>.md` only when the user asks for a saved artifact.

## Workflow
1. Restate the job the interface must do, including the highest-cost mistakes.
2. Identify the primary callers, inputs, outputs, and failure modes.
3. Draft at least 3 genuinely different options. Do not create 3 cosmetic variants of the same idea.
4. Compare the options in prose, using the evaluation axes above.
5. Recommend one option and explain why the trade-offs are worth it.
6. If parallel drafting is available, you may sketch options independently first, but the final comparison must be synthesized in one place.

## Option Design Rules
- Optimize for clear call sites, not just elegant internals.
- Make invalid states difficult to express.
- Prefer deep modules with small surfaces over wide interfaces that leak implementation details.
- Keep the comparison concrete enough that implementation can start from it immediately.

## Anti-Patterns
- One favored option plus two token alternatives
- Comparing implementation details without discussing caller experience
- Turning a local interface exercise into a full architecture rewrite
- Recommending the most flexible option by default when the simpler option is enough

## Pairing Guidance
- Pair with `role-software-architect` when interface choices may harden into lasting boundaries.
- Pair with `role-principal-software-engineer` when module depth, maintainability, and future refactoring cost matter.
- Pair with `team-architecture-review` only when the interface question changes system-level decomposition.
