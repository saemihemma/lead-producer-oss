# Performance, Accessibility, and Network Reference
Deep reference material for rendering performance, resilience, accessibility, responsive behavior, and testing strategy.
### Phase 3: Performance Audit
**The UI should remain interactive. Measure with concrete tools and thresholds.**
1. **Rendering Performance:**
   - Core Web Vitals: LCP (Largest Contentful Paint) <2500ms, FID <100ms, CLS <0.1
   - Tools: Lighthouse for audits, DevTools Performance tab for runtime, RUM for production
   - Bottleneck diagnosis: JavaScript execution? CSS layout? Network blocking?
2. **Component Render Frequency:**
   - Does the component re-render too often? Use React DevTools Profiler to measure.
   - Memoization threshold: If component re-renders >5x per user action, apply React.memo or useMemo.
   - Baseline: Most components need no memoization; add only when profiler confirms waste.
3. **Bundle Size:**
   - Target: <300KB for entire app (gzipped). If >500KB, over-bundled.
   - Measurement: Build tools (webpack-bundle-analyzer, source-map-explorer) for breakdown.
   - Action: Identify largest dependencies; tree-shake or code-split.
4. **Network Waterfall:**
   - Serial vs parallel: If requests are sequential A->B->C, switch to parallel unless B/C depend on A's result.
   - Critical path: Render blocked on data fetch? Use skeleton screens or defer non-critical data.
   - Baseline: <3 blocking requests on page load.
5. **Runtime Performance & State Race Conditions:**
   - Frame rate target: 60 FPS during user interactions. Measure with Chrome DevTools Performance tab.
   - State race condition detector: State updated in multiple async callbacks without batching -> timing bugs. Audit: Do async handlers batch state updates via setState() or useReducer()?
   - Long tasks: Main thread blocked >50ms causes jank. Use Long Tasks API.
**Measurement strategy:**
1. Lighthouse for static audits (daily in CI)
2. DevTools Profiler for rendering bottlenecks
3. RUM (Real User Monitoring) for production performance
4. Never rely on dev machine performance; test on real devices
**Red flags:**
- "It runs at 30 FPS on a phone, but works fine on my laptop."
- "The page takes 10 seconds to become interactive."
- "We ship 5MB of JavaScript for a note-taking app."
- "We measure performance in dev, not in production."
### Phase 4: Network Resilience & Error Handling
**Assume the network is slow, unreliable, and sometimes gone.**
1. **Request Lifecycle:**
   - Pending: Show a spinner or skeleton. (Is the wait clear?)
   - Success: Render data. (Is the update visible?)
   - Error: Show a recoverable message. (Can the user retry?)
   - Timeout: How long do you wait? (3s? 10s? 30s?)
2. **Offline Support:**
   - Can the user see previously loaded content?
   - Can the user submit forms offline and sync later?
   - Or does the app become completely unusable?
3. **Request Deduplication:**
   - If two components request the same data, do you make two requests?
   - Or do you dedupe and share the response?
4. **Caching Strategy:**
   - Do you cache API responses? How long?
   - Do you cache derived/computed data?
   - When does cache invalidate?
5. **Retry Logic:**
   - If a request fails, do you retry automatically?
   - How many retries? Exponential backoff?
   - Or does the user have to click "retry" manually?
**Error state examples:**
Good:
```
Loading... (spinner, 2s)
-> Data loaded (renders)
-> API error: "Couldn't load data. Retry? (button)"
-> User clicks retry
-> Data loaded (renders)
```
Bad:
```
Loading... (spinner)
-> API error (silent; user stares at spinner)
-> Nothing happens (user closes tab)
```
**Red flags:**
- "If the API times out, we show a spinner forever."
- "We retry requests forever with no backoff."
- "Error messages are vague. Users don't know what went wrong."
- "The app works fine on 5G but breaks on 3G."
### Phase 5: Accessibility Audit
**Accessibility is not a feature; it's a requirement.** WCAG 2.1 AA is the standard.
1. **Keyboard Navigation:**
   - Can you tab through the page? Is tab order logical?
   - Can you interact with all controls via keyboard?
   - Is focus visible? (Does a focused button have a clear outline?)
2. **Screen Reader Support:**
   - Do buttons have accessible labels? (Not just an icon)
   - Are images described? (alt text?)
   - Is heading hierarchy logical? (H1, H2, H3, not H1, H3, H1?)
   - Can screen readers discover interactive elements?
3. **Color & Contrast:**
   - Is text readable? (WCAG AA: 4.5:1 for body text, 3:1 for large text)
   - Is meaning conveyed without color alone? (Not "click the red button")
   - Is there sufficient whitespace? (Not wall-of-text dense)
4. **Motion & Animation:**
   - Do animations respect `prefers-reduced-motion`?
   - Or do autoplaying videos cause disorientation?
   - Can users disable animations?
5. **Forms & Labels:**
   - Do form fields have associated labels?
   - Are error messages linked to the field they describe?
   - Is focus moved to the error after submission?
**Accessibility testing:**
- Keyboard-only navigation: Can you use the entire app without a mouse?
- Screen reader (NVDA, JAWS, VoiceOver): Can a blind user understand the content?
- Contrast checker: Are text and backgrounds readable?
**Red flags:**
- "Accessibility is too expensive. We'll do it later."
- "Only 1% of users use screen readers, so it's not a priority."
- "Our design uses white text on light gray. It looks clean."
- "The close button is an 8x8 pixel X. Users can figure it out."
### Phase 6: Data-Fetching Library Patterns
**Use modern data-fetching libraries to avoid common pitfalls.**
**Pattern: SWR, React Query, Apollo Client**
- SWR (Stale-While-Revalidate): Simple, auto-revalidation on focus, caching out-of-box
- React Query: Rich cache invalidation, dev tools, handles stale data gracefully
- Apollo Client: GraphQL-native, normalized cache, subscription support
- Red flag: Manual fetch() in useEffect without memoization -> duplicate requests, race conditions
**Client-side security concerns:**
- XSS via unsanitized props: Never pass raw HTML from API; sanitize with DOMPurify or libraries
- CSRF: Use SameSite cookies; state-changing requests should use POST with CSRF tokens
- API credential exposure: Never store tokens in localStorage; use httpOnly cookies
- Rate limiting on client: Debounce requests to prevent DoS of your own backend
**Request batching vs. waterfall:**
- Parallel if independent: fetch([userAPI, settingsAPI, notificationsAPI]) in Promise.all()
- Waterfall only if B depends on A result
- Threshold: >3 sequential requests suggests design issue
**Pagination & Infinite Scroll:**
- Pagination: Clear, testable, accessible (keyboard navigable)
- Infinite scroll: Smooth UX, trap accessibility, can over-fetch
- Choose based on user research; don't optimize for scroll distance
**Red flags:**
- "Every page load makes 50 requests sequentially."
- "We fetch the entire dataset on page load, then filter in the browser."
- "Real-time updates are polled every 100ms; we DoS ourselves."
- "If the API fails, we don't show what we have cached."
### Phase 7: Responsive Design (Compressed)
**The UI must work across devices and browsers.**
Ask 3 questions:
1. **Breakpoints explicit?** Define mobile (<480px), tablet (480-1024px), desktop (>1024px). Measure real device usage data.
2. **Touch-friendly?** Buttons >=48x48px. No hover-only interactions on mobile (use focus states). Test on actual devices.
3. **Browser coverage?** Define minimum version (last 2 versions? IE 11?). Use automated testing (BrowserStack); don't assume compatibility.
**Red flags:**
- "Tested only on my laptop."
- "Buttons <40px; users can figure it out."
- "We use unsupported APIs in production."
### Phase 8: Testing & Debugging Strategy
**Code should be testable. Problems should be reproducible.**
1. **Unit Tests:**
   - Do components have unit tests?
   - Do utilities have tests?
   - What's the coverage? (Aim for >70% for critical paths, not 100% for boilerplate.)
2. **Integration Tests:**
   - Do you test API integration? (Mocked API, real requests?)
   - Do you test user flows? (Form submission, navigation, data load?)
3. **E2E Tests:**
   - Do critical paths have end-to-end tests?
   - Are they run on real browsers? (Selenium, Cypress, Playwright?)
4. **Debugging Tools:**
   - Can developers see component state? (DevTools?)
   - Can you replay network requests? (DevTools Network tab?)
   - Can you measure performance easily? (Lighthouse? Profiler?)
**Red flags:**
- "We have no tests. We test manually before each release."
- "Tests exist but they're brittle. We skip them before deployment."
- "We don't have a way to reproduce bugs. Users just report them."
## Concrete Output Format
When analyzing a frontend system, produce this structured report:
```
FRONTEND AUDIT REPORT
=====================
1. COMPONENT ARCHITECTURE
   |- Coupling Assessment: [High / Medium / Low]
   |- Reusability: [Good / Partial / Poor]
   |- Testability: [Easy / Moderate / Hard]
   |- Issues Found:
      |- Issue 1: [Description + refactoring suggestion]
      |- Issue N: ...
2. STATE MANAGEMENT
   |- Truth Sources: [Identified] Conflicts: [None / Some / Many]
   |- Mutation Pattern: [Immutable / Mutable] Risk: [Low / Medium / High]
   |- Async Handling: [Comprehensive / Partial / Missing]
   |- Fragility Score: [1-5 (low to high risk)]
3. PERFORMANCE ANALYSIS
   |- Bundle Size: [Value MB] Target: [Recommend: <300KB]
   |- LCP (Largest Contentful Paint): [Value ms] Target: [<2500ms]
   |- FID (First Input Delay): [Value ms] Target: [<100ms]
   |- CLS (Cumulative Layout Shift): [Value] Target: [<0.1]
   |- Rendering Bottleneck: [Description]
   |- Optimization Priority:
      |- High: [e.g., "Code split vendor bundle"]
      |- Medium: [e.g., "Memoize expensive list component"]
4. NETWORK RESILIENCE
   |- Error Handling: [Comprehensive / Partial / Poor]
   |- Offline Support: [Yes / Partial / No]
   |- Retry Logic: [Smart / Basic / None]
   |- Cache Strategy: [Defined / Ad-hoc / Missing]
   |- Issues:
      |- Issue 1: [e.g., "Timeouts show spinner forever"]
      |- Issue N: ...
5. ACCESSIBILITY AUDIT (WCAG 2.1 AA)
   |- Keyboard Navigation: [Full / Partial / Broken]
   |- Screen Reader Support: [Good / Partial / Poor]
   |- Color Contrast: [Compliant / Some issues / Non-compliant]
   |- Motion Respect (prefers-reduced-motion): [Yes / No / Partial]
   |- Critical Gaps:
      |- Gap 1: [e.g., "Form labels missing"]
      |- Gap N: ...
6. API INTEGRATION
   |- Request Strategy: [Optimized / Acceptable / Inefficient]
   |- Batching: [Yes / Partial / No]
   |- Caching: [Smart / Basic / Missing]
   |- Real-time Sync: [None / Polling / WebSocket]
   |- Issues:
      |- Issue 1: [e.g., "Waterfall requests block render"]
      |- Issue N: ...
7. RESPONSIVE & COMPATIBILITY
   |- Mobile-First: [Yes / Partial / No]
   |- Touch-Friendly: [Yes / Partial / No]
   |- Browser Target: [Defined] Coverage: [Modern / Wide range]
   |- Issues:
      |- Issue 1: [e.g., "36px buttons; can't tap on mobile"]
      |- Issue N: ...
8. TESTING & DEBUGGING
   |- Unit Test Coverage: [>70% / 40-70% / <40%]
   |- Integration Tests: [Comprehensive / Partial / Missing]
   |- E2E Tests: [Comprehensive / Partial / Missing]
   |- Debugging Tools: [Good / Adequate / Poor]
   |- Recommendations:
      |- Priority 1: [Add E2E tests for critical flows]
      |- Priority N: ...
9. CRITICAL ISSUES (MUST FIX)
   |- Issue 1: [Description + severity + fix]
   |- Issue N: ...
10. NICE-TO-HAVES (POLISH)
    |- Item 1: [Description]
    |- Item N: ...
```
## Anti-Patterns & Red Flags (Key Ones)
**1. "We'll optimize performance when it becomes a problem."** By then, it's structural. Measure early.
**2. "Error handling: We retry until it works."** Without backoff/max retries, DoS risk or infinite waits.
**3. "State in multiple async callbacks without batching."** Causes race condition timing bugs.
**4. "Accessibility is hard and expensive."** Some is free (semantic HTML, labels). Benefit-to-cost is extremely high.
## Review Mode: Rapid Questions
1. Coupling? (>3 external deps = over-coupled)
2. State mutation atomic across async callbacks?
3. Bundle <300KB? Lighthouse score >=80?
4. Error handling: timeouts, retry backoff, user feedback?
5. Accessibility: keyboard nav, contrast >=4.5:1, labels visible?
## Design Mode: Start With
1. Component decomposition (atomic units)
2. State scope (global vs local)
3. API integration plan
4. Performance budget (bundle, LCP, FID targets)
5. Error handling design
6. Accessibility from the start
## Scope: What Is NOT Your Concern
- **Server architecture:** Backend implementation, database design.
- **Design aesthetics:** Colors, typography, spacing. (That's UI/UX Designer.)
---
**Remember:** Frontend is not "making it pretty." Frontend is: receiving data from uncertain networks, transforming it into understandable, accessible, fast, interactive experiences on diverse devices. Build to last, test deeply, and assume everything will go wrong.
