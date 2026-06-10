# Feedback Loops

A bug with a fast, deterministic, agent-runnable feedback loop is most of the way to fixed. Before hypothesizing, spend effort building the cheapest loop that reliably reproduces the failure and tells you pass/fail in seconds. Then every hypothesis becomes a quick experiment instead of a guess.

## What makes a good loop
- **Fast**: seconds, not minutes. You will run it many times.
- **Deterministic**: same input, same result. Flaky loops teach nothing.
- **Agent-runnable**: a command you can run unattended, with a clear pass/fail signal.
- **Narrow**: exercises the failing behavior and little else.

## The ladder — pick the lowest rung that works
1. **Failing test** — a unit/integration test that reproduces the bug. Best case; becomes the regression test.
2. **Curl / HTTP script** — for API or service bugs, a scripted request asserting the bad response.
3. **CLI invocation with snapshot diff** — run the command, diff output against expected.
4. **Headless browser script** — for UI/interaction bugs, a scripted Playwright-style run.
5. **Replay a captured trace** — feed a recorded request/event sequence back in.
6. **Throwaway harness** — a small script that sets up state and calls the suspect code directly.
7. **Property / fuzz loop** — when the trigger input is unknown, search for it.
8. **Bisection harness** — when "it worked before," script `git bisect` against the loop.
9. **Differential loop** — run old vs new (or two implementations) on the same input, diff results.
10. **Human-in-the-loop bash script** — last resort: a script that pauses for a manual step. Use only when no automated loop is reachable.

## Using the loop
- Build the loop first; confirm it shows the failure reliably before forming hypotheses.
- Each hypothesis: change one thing, run the loop, read the signal. Discard fast.
- When fixed, the loop (or rung 1 derived from it) becomes the regression test the workflow asks for.
- If you cannot build any loop, say so explicitly and focus on evidence-gathering — that itself is a finding.
