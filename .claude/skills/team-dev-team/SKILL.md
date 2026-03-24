---
name: team-dev-team
description: "Technical review team: architecture, code quality, and test coverage in one unified assessment. Use for code review, design review, or implementation validation."
context: fork
---
# Dev Team

## Purpose
Single technical verdict on whether implementation is structurally sound, maintainable, and sufficiently verified.

## Composition
- **role-software-architect**: structure, boundaries, design fit
- **role-principal-software-engineer**: code quality, maintainability, tech debt
- **role-qa-engineer**: test coverage, regression risk, verification gaps
- Synthesis: conflict handling, acceptance

## Use When
- Reviewing a pull request, module, or implementation slice
- Validating a refactor or design before merge
- Checking code quality and verification match intended architecture

## Do NOT Use When
- Adversarial security review (use `team-red-team`)
- Product, UX, or economy analysis
- Reduction verification (use `team-blue-team`)

## Workflow
1. Review structure, code quality, test posture together.
2. Run specialist passes in parallel.
3. Merge findings: test gaps map to risky code, risky code maps to architecture.
4. Resolve conflicts, produce one technical verdict.

## Default Output
```text
DEV TEAM REVIEW
===============
Architecture: boundary/design concerns
Code Quality: maintainability findings, debt/complexity risks
Verification: test gaps, regression risks
Recommendation: merge / rework / escalate, highest-priority fixes
```

## Success Criteria
- Architecture, code quality, and verification connected rather than siloed.
- Output states what blocks acceptance vs what is advisory.

## Conflict Resolution
- Architect owns structural decisions. Principal Engineer owns code-quality assessment. QA owns verification gaps.
- When architecture and code-quality findings conflict, resolve by asking: "What serves the next engineer better?"

## Anti-Drift Rules
- Stay constructive, not adversarial (that's Red Team's job).
- Output must state what blocks acceptance vs what is advisory.
- Do not expand into product or economy analysis under technical review label.
