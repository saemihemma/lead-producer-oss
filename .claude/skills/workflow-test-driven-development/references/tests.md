# Tests
## What to test first
- Start at the user-visible or caller-visible seam whenever possible.
- Capture the smallest behavior that proves forward progress.
- Prefer tests that would still be valid after an internal refactor.

## Good first-test candidates
- A returned value or state transition
- An emitted domain event
- A persisted change with observable effect
- An error case that currently leaks through or fails silently

## Slice sizing
- One test should usually prove one behavior change.
- If a failing test requires a large amount of setup, shrink the slice or improve the seam.
- If a test failure could be caused by five unrelated missing pieces, the slice is too large.

## Coverage guidance
- Critical behavior should get direct tests before nice-to-have branches.
- Integration tests are valuable when the risk is in component interaction.
- End-to-end tests should be reserved for a few essential user journeys.

## Acceptance criteria
- Translate vague requirements into observable outcomes.
- If you cannot state how a behavior will be verified, the slice is not ready for implementation.
