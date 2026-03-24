# Deep Modules
## Goal
Favor a small, clear surface area hiding meaningful internal capability over a shallow API that leaks every implementation choice.

## What to optimize for
- A caller can do useful work with a compact set of concepts.
- Implementation complexity stays behind the boundary.
- New behavior can be added internally without expanding the public surface every time.

## Warning signs
- Public APIs mirror database tables or internal pipeline steps one-to-one.
- Callers must coordinate multiple low-level operations in the right order.
- Each new feature adds another specialized method instead of deepening an existing abstraction.
