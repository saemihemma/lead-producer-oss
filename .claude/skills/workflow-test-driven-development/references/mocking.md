# Mocking
## Default stance
- Mock unstable or expensive boundaries, not every dependency by default.
- Prefer real collaborators when they are cheap, deterministic, and clarify behavior.

## Good candidates for mocks or fakes
- Third-party APIs
- Time, randomness, and external process calls
- Slow infrastructure such as queues, remote services, or cloud SDKs

## Avoid
- Mocking the code you are actually trying to learn about
- Asserting on long call sequences instead of the resulting behavior
- Making tests pass by freezing current implementation details in place

## Heuristics
- If a mock makes the test easier to understand without reducing confidence, it is probably helping.
- If a mock is the only reason the test passes, it is probably hiding the real seam.
- Prefer fakes or in-memory test doubles over brittle, expectation-heavy mocks when possible.
