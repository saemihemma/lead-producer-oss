---
name: workflow-requirements-grill
description: "Socratic requirements interview: grill the user about a fuzzy plan or request, force definitions, and walk the open decisions one at a time until the work is specified well enough to route. Use when a request is underspecified and starting work now would guess at intent."
---
# Requirements Grill Workflow

## Purpose
Sharpen a vague request into a specified one before specialists touch it. This is collaborative elicitation, not critique: the goal is to surface the decisions the user has not made yet and get them made, so downstream work is not built on guesses.

## Use When
- A request is fuzzy, broad, or has unstated assumptions
- Multiple readings of the ask would lead to different work
- Key terms are undefined or used loosely
- The user asks to "grill me," "interview me," or "help me think this through" before building

## Do NOT Use When
- The request is already specified and the next step is execution or review
- The work is a critique of an existing recommendation (use the Devil's Advocate pass)
- The decision is hard-to-reverse and the need is failure foresight (use `workflow-premortem`)
- The unknown is about an inherited codebase, not the user's intent (use `workflow-project-discovery`)

## Working Method
1. **Restate the request** in one sentence and name what is ambiguous in it.
2. **Map the open decisions** as a short decision tree: the choices that, once made, would let work proceed without guessing.
3. **Grill one decision at a time.** Ask a sharp question, force a definition where a term is loose, and surface the trade-off. Do not dump every question at once.
4. **Recommend an answer for each** open decision with brief rationale, so the user can accept rather than start from blank.
5. **Capture the sharpened spec**: the decisions made, definitions fixed, and explicit out-of-scope items.
6. **Hand back to Lead Producer** with the spec so LP can route, and flag any decision the user deferred as an open question.

## Default Output
```text
REQUIREMENTS GRILL
==================
Request (restated): one sentence
Ambiguities: what was unclear
Decisions (resolved): each open question, the answer chosen, why
Definitions fixed: loose terms now pinned down
Out of Scope: what this explicitly is not
Still Open: decisions the user deferred (flagged for LP)
Sharpened Spec: the now-routable statement of work
```

## Anti-Drift Rules
- This is elicitation, not adversarial critique. Help the user decide; do not attack a position they have not taken.
- One decision at a time. A wall of questions is not grilling.
- Always recommend an answer — do not leave the user with bare questions.
- Stop when the request is specified well enough to route. Do not manufacture decisions that do not change the work.
- Pairs with `workflow-premortem`: grill sharpens the plan, pre-mortem stress-tests it. Do not collapse the two.
