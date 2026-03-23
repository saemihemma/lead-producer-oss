---
name: "Brand Team"
description: "Cross-functional team for brand system work. Defines tone, positioning, visual rules, and cross-surface consistency, then hands those standards to Frontend, Documentation, or Community implementation owners."
---
# Brand Team
## Purpose
Brand Team owns identity standards, not raw implementation. It turns vague taste questions into a usable system that other teams can apply consistently.

## Team Composition
- **role-brand-strategist**: Owns brand voice, positioning, and visual rules
- **role-ui-ux-designer**: Ensures the brand works in real interfaces, not just in moodboards
- **role-technical-writer**: Ensures verbal guidance is specific and portable into docs and product copy
- **role-community-developer**: Ensures the brand survives community-facing surfaces and contributor touchpoints
- **lead-producer**: Synthesizes trade-offs and keeps the team lean
- **role-frontend-engineer** (optional): Added when implementation realism or design-system feasibility matters

## Use When
- Defining a brand system
- Aligning voice and visual identity across product, docs, and community surfaces
- Applying or tightening brand standards for a launch, redesign, or new surface
- Resolving inconsistency between UI, docs, and messaging

## Do NOT Use When
- The task is raw frontend implementation; use `team-frontend-team`
- The task is generic feature prioritization; use `team-product-team`
- The task is pure docs production with no brand-system question; use `team-documentation`
- The task is generic UX review with no brand angle

## Helpful External Overlays
Use these only as helpers:
- `brand-guidelines`
- `frontend-design`

## Workflow
1. Define or load the brand truth from one canonical file.
2. Align voice, visuals, and cross-surface rules.
3. Stress-test those rules against actual UI, docs, and community usage.
4. Write or update the canonical brand artifact, default `brand/BRAND_SYSTEM.md`, unless the workspace already has a clear canonical brand file.
5. Produce a small handoff that implementation teams can actually use without creating a second source of truth.

## Output Format
```
BRAND TEAM BRIEF
================
CANONICAL FILE
- `brand/BRAND_SYSTEM.md` or existing canonical brand file

BRAND TRUTH
- Positioning
- Voice
- Visual principles

CONSISTENCY RISKS
- Current mismatches
- Surfaces most likely to drift

APPLICATION RULES
- Product UI
- Docs
- Community / ecosystem

HANDOFF
- Frontend actions
- Documentation actions
- Open constraints
```

## Success Criteria
- There is one durable brand source of truth in the workspace.
- The brand can be applied by another team without guessing.
- Voice and visual guidance do not contradict each other.
- The output is shorter than a design manifesto and more useful than a moodboard.
