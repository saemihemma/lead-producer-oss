# Refactoring
## Refactor only after GREEN
- Use the passing suite as the safety net for structural improvement.
- Refactor for naming, duplication, clearer seams, and simpler control flow.
- Stop refactoring when the code becomes easier to change, not when it becomes abstract for its own sake.

## Safe refactoring targets
- Long functions with mixed responsibilities
- Repeated conditionals or setup
- Misleading names that hide intent
- Incidental complexity added during the GREEN step

## Guardrails
- Keep tests passing after every small refactor step.
- Remove old code paths once the new structure is proven.
- If refactoring grows into redesign, pause and re-scope the next slice.
