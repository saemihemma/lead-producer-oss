---
name: "Frontend Team"
description: "Cross-functional frontend review for UI implementation, UX quality, accessibility, and frontend-backend integration. Use when interface quality and technical execution need one recommendation."
---
# Frontend Team
## Purpose
Frontend Team decides whether an interface is usable, implementable, accessible, and technically healthy enough to ship.

## Composition
- **role-ui-ux-designer**: flow quality, hierarchy, clarity, and accessibility
- **role-frontend-engineer**: implementation quality, runtime behavior, and state health
- **role-backend-engineer**: API and contract advisor for frontend integration risk
- **lead-producer**: synthesis, trade-offs, and acceptance

## Use When
- reviewing a UI feature, screen, or frontend-heavy flow
- checking accessibility, responsiveness, or client-side architecture
- evaluating frontend-backend integration quality
- resolving trade-offs between UX and implementation constraints

## Do NOT Use When
- the task is backend-only, infrastructure-only, or product-only
- the work is brand-definition with no implementation or UX question
- the question is only a narrow shadcn/ui method, setup, or docs issue already handled by `workflow-shadcn-ui`

## Workflow
1. Define the critical user journey and the screens or states that matter most.
2. Review UX, frontend implementation, and API dependence together.
3. Make performance, failure handling, and accessibility part of the same verdict.
4. Use Lead Producer to synthesize trade-offs into one frontend recommendation.

## Default Output
```text
FRONTEND TEAM REVIEW
====================
Journey:
- main user flow
- friction points

Implementation:
- state, rendering, or integration risks

Quality:
- accessibility gaps
- responsive or failure-state issues

Recommendation:
- ship / revise / escalate
- highest-priority frontend fixes
```

## Success Criteria
- UX and implementation findings are reconciled instead of competing.
- Accessibility and failure states are treated as shipping quality.
- The output gives concrete fixes another team can implement.
