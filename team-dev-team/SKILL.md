---
name: "Dev Team"
description: "Cross-functional technical review for implementation quality. Use when code, design, and testing need one unified assessment across architecture, maintainability, and verification risk."
---
# Dev Team
## Purpose
Dev Team gives a single technical verdict on whether an implementation is structurally sound, maintainable, and sufficiently verified.

## Composition
- **role-software-architect**: structure, boundaries, and design fit
- **role-principal-software-engineer**: code quality, maintainability, and technical debt
- **role-qa-engineer**: test coverage, regression risk, and verification gaps
- **lead-producer**: synthesis, conflict handling, and acceptance

## Use When
- reviewing a pull request, module, or implementation slice
- validating a refactor or design before merge
- checking whether code quality and verification match the intended architecture
- producing a unified technical assessment instead of separate specialist notes

## Do NOT Use When
- the main question is adversarial security review
- the task is primarily product, UX, or economy analysis
- the work is reduction verification better owned by `team-blue-team`

## Workflow
1. Review structure, code quality, and test posture together.
2. Run specialist passes in parallel by default.
3. Merge findings so test gaps map to risky code and risky code maps to architecture.
4. Use Lead Producer to resolve conflicts and produce one technical verdict.

## Default Output
```text
DEV TEAM REVIEW
===============
Architecture:
- boundary or design concerns

Code Quality:
- maintainability findings
- debt or complexity risks

Verification:
- test gaps
- regression risks

Recommendation:
- merge / rework / escalate
- highest-priority fixes
```

## Success Criteria
- Architecture, code quality, and verification findings are connected rather than siloed.
- The output states what is blocking acceptance and what is advisory.
- The team stays constructive rather than adversarial.
