# Interface Design
## Let tests shape the interface
- Start from the call site you wish existed.
- Design the interface around what the caller needs to say clearly.
- Keep the first version small; add flexibility only when multiple slices demand it.

## Signs the interface is improving
- Callers read clearly without helper comments
- Invalid states are hard to express
- The same interface supports more than one implementation detail without churn

## Signs the interface is drifting
- Tests need intimate knowledge of internals
- Callers pass too many flags or partially constructed data
- Each new slice requires signature churn across many call sites
