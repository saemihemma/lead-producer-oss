# Component Architecture and State Reference
Deep reference material for component decomposition, props contracts, coupling, and state-management audits.
### Phase 1: Audit Component Architecture
**Components should be composable, testable, and easy to understand.**
For each component, ask:
1. **Single Responsibility:** Does this component do one thing?
   - Yes -> Good. Can be tested in isolation.
   - No -> It's doing too much. Split it.
2. **Props Contract:** Can a developer use this component without reading the internals?
   - Props are clear? Types are defined? Defaults are sensible?
   - Or is the interface a mystery?
3. **Coupling:** Count external dependencies. If >3, over-coupled. Audit: What does each dependency do? Can any be eliminated?
   - High coupling (>3 deps) -> Breaking one breaks many. Hard to reuse.
   - Low coupling (<=3 deps) -> Can be moved, reused, tested anywhere.
4. **Testability:** Can you test this component without mocking half the app?
   - If not, design is likely coupled. Refactor.
5. **Reusability:** Is this component generic enough to be used in multiple contexts?
   - Or is it so specific to one screen that it's really just inlined logic?
**Red flags:**
- "This component is 2000 lines and imports 30 other components."
- "The props are `children`, `context`, `store`, and `callback`. What does it do?"
- "To test this, I need to mock the entire app."
### Phase 2: Analyze State Management
**Truth should have a single source. State mutations should be predictable.**
1. **Source of Truth Location:**
   - Server state (fetched data): Lives on the backend. UI is a view.
   - UI state (UI opened?): Lives in component or local store.
   - Derived state (computed values): Never stored; always computed from source.
   - Cached state (API result): Lives in cache; invalidated when source changes.
   **Key rule:** Never duplicate truth. If data lives in two places, they will diverge.
2. **State Mutation Pattern:**
   - Immutable updates (create new object, don't mutate)?
   - Or do you mutate in-place?
   - Immutable -> predictable, debuggable, easier time-travel.
   - Mutable -> subtle bugs when objects are shared.
3. **Async State Management:**
   - How do you handle pending requests?
   - How do you handle failed requests?
   - How do you invalidate cached data when it changes on the server?
   - If you don't have clear answers, state is likely fragile.
4. **State Scope:**
   - Global store (Redux, Zustand): Everything visible everywhere. Easy to access, hard to reason about.
   - Local state (useState): Isolated per component. Harder to share, easier to understand.
   - Are you using the right scope? (Global for things that are globally relevant. Local for things that are local.)
**Design test:** "If I refactor component A to component B, does state still work?"
- If not, state is tightly coupled to component structure. Likely to break.
**Red flag:**
- "We sync data with a debounce because updates are too frequent."
- "This component reaches into the store directly instead of using props."
- "State updates are batched in useEffect because of race conditions."
