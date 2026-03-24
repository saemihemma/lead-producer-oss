# Experiments and Dashboards Reference
Deep reference material for A/B tests, dashboards, anomaly detection, funnels, and reporting examples.
### 3. A/B Test Design: Statistical Rigor
Design tests that conclusively prove causation, not correlation.
**What to look for:**
- **Sample size:** Have you calculated the minimum sample needed to detect your effect size? (Rule: larger effect = smaller sample)
- **Duration:** Is the test running long enough to account for weekly/daily patterns? (Minimum: 1 full week, preferably 2)
- **Guardrails:** Are you monitoring for negative effects on unmeasured outcomes? (e.g., you optimize for clicks but destroy engagement)
- **Confounders:** What variables could explain the result besides your change? (Day of week? Season? Competing tests?)
- **Segment analysis:** Does the effect hold across all user segments, or only some? (Heterogeneous treatment effects matter)
**Sample size calculation (simplified):**
```
Formula: n = (2 * (z_alpha + z_beta)^2 * sigma^2) / (delta^2)
Where:
- z_alpha = 1.96 (95% confidence, two-tailed)
- z_beta = 0.84 (80% power to detect effect)
- sigma^2 = variance of metric (from baseline data)
- delta = effect size you want to detect (e.g., 5% improvement)
Example: Baseline conversion = 10%, want to detect 20% relative improvement (to 12%)
- Variance from baseline data = 0.09 (rough estimate)
- n ~= (2 * (1.96 + 0.84)^2 * 0.09) / (0.02^2) = 6,568 users per variant
- Total: 13,136 users, ~2-3 days at 5k DAU, but run for 7 days to capture weekly variation
```
**Checklist before launching:**
- [ ] Sample size calculated and verified (n per variant >= estimated?)
- [ ] Duration set to minimum 7 days (unless n is reached faster)
- [ ] Primary metric defined and guardrails identified (what else matters?)
- [ ] Randomization unit defined (per user, per session? Consistent across repeat sessions?)
- [ ] Excluded users: test users, internal staff, browser bots?
- [ ] Significance level: alpha = 0.05 (95% confidence standard)
- [ ] Power: beta = 0.2 (80% power to detect effect)
- [ ] Concurrent tests checked (can't run overlapping tests on same users)
**Red flags:**
- Test stopped early because you "saw the winner" (introduces selection bias, inflates effect size)
- No minimum sample size calculated
- Weekly tests where metric varies by day of week (confounded by seasonality)
- Guardrails not specified (if you optimize for CTR, engagement might plummet)
- Rollout immediately after test ends (need post-test stabilization period)
**Example anti-pattern:**
```
BAD:
- "Let's run the test for 3 days, should be enough"
- Monitor every 6 hours and stop when p < 0.05
- No guardrail on engagement (only testing clicks)
- Rollout immediately
GOOD:
- Calculate sample size: 5,000 per variant needed
- Set duration: 7 days (capture weekly patterns)
- Set guardrails: alert if engagement drops > 5% OR retention drops
- Wait 2 days after end of test to account for selection bias
- Segment analysis: does effect hold for mobile users| New users|
```
### 4. Dashboard Hierarchy & Design
Structure dashboards to reveal problems, not hide them.
**What to look for:**
- **Three-tier hierarchy:** KPI dashboard (what?) -> Diagnostic dashboard (why?) -> Exploratory dashboard (what if?)
- **Aggregation level:** Are you showing raw counts or rates? (Raw counts hide problems; rates surface them)
- **Drill-down:** Can someone click a KPI and investigate? Or are they stuck?
- **Staleness:** How old is the data? If > 24h, decisions will lag
- **Alert triggers:** Are there actionable alerts, or just pretty charts?
**Tier 1: KPI Dashboard (Executive View)**
```
Daily Active Users (trend, target comparison)
Revenue (trend, target comparison)
Retention Day 7 (cohort, trend)
Customer Acquisition Cost (trend, target)
Why this format:
- One chart per metric
- Show vs target
- Show trend (last 90 days)
- No drill-down needed (that's for diagnostics)
```
**Tier 2: Diagnostic Dashboard (Team View)**
```
Funnel: Signup -> Purchase -> Repeat
  - Breakdown by device, geography, cohort
  - Identify drop-off points
Cohort retention: DAU by signup cohort
  - Can you see which cohorts are retaining poorly|
Event volume: Event counts by type
  - Instrumentation completeness check
```
**Tier 3: Exploratory Dashboard (Analyst View)**
```
Raw data query interface
Custom cohort builder
Segmentation on any dimension
Ad-hoc questions answered by analysts
```
**Red flags:**
- All metrics on one dashboard (overwhelming, no hierarchy)
- Charts with no clear action (just monitoring, not driving decisions)
- Outdated data (updated weekly instead of daily)
- Aggregated to the point of meaninglessness (e.g., global average hides segment-level problems)
- No drill-down capability (dead-end dashboards)
**Quantitative thresholds:**
- If dashboard has > 12 charts, split into tiers
- If a KPI hasn't changed in > 30 days, question if you're tracking the right thing
### 5. Anomaly Detection & Monitoring
Catch problems before they become crises.
**What to look for:**
- **Threshold-based alerts:** Is there a clear alert when DAU drops > 10% or conversion drops > 20%?
- **Statistical anomaly detection:** Does the system detect unexpected patterns (not just absolute thresholds)?
- **Sensitivity:** Can you tune alerts to avoid false positives (crying wolf) without missing real issues?
- **Context:** When an alert fires, do you know why? (e.g., "DAU dropped due to planned maintenance" vs "unknown cause")
**Approach:**
```
Rule-based: DAU < (7-day average * 0.9) -> alert
Statistical: If today's value > (mean + 2*sigma) -> investigate
Contextual: If DAU drop on Tuesday after Monday deploy -> blame deploy; if Tuesday every week -> it's seasonality
Best practice: Rule + statistical + context
```
**Red flags:**
- Alerts that fire > 20% of the time (tuning is wrong)
- Alerts with no owner or runbook
- Metrics monitored without clear recovery action
### 6. Cohort & Funnel Analysis
Understand patterns in user behavior.
**What to look for:**
- **Cohort drift:** Does each cohort behave the same way, or do recent cohorts retain worse? (Signals product decline)
- **Funnel leakage:** Where do users drop off? By how much? (5% drop = acceptable; 30% = major problem)
- **Segment variation:** Do premium users have different funnels than free users? (Different problem, different fix)
**Example: Retention cohort table**
```
Signup Cohort | Day 1 | Day 7 | Day 30 | Day 90
Jan 2026      | 100%  | 45%   | 18%    | 8%
Feb 2026      | 100%  | 42%   | 15%    | 6%
Mar 2026      | 100%  | 38%   | 12%    | |
Insight: Retention is declining for recent cohorts (Feb < Jan < Mar planned)
Action: Investigate what changed in onboarding or product
```
**Red flags:**
- Cohorts that don't align (can't compare like-to-like)
- Funnel steps that are too granular (> 10 steps = hard to read)
- No segment analysis (assuming homogeneous behavior)
---
## Output Format: Structured Findings
When analyzing metrics or designing experiments:
```
## Analytics Review
### Metrics
- North Star: [Metric name, definition]
- Leading indicators: [List with 1-2 sentence reason for each]
- Lagging indicators: [List with 1-2 sentence reason for each]
- Vanity metrics: [Any found, with explanation of why they're vanity]
### Instrumentation
- Event schema: [Valid/Needs work, specifics]
- Coverage: [% of user journey instrumented]
- Latency: [How old is data| Real-time/hourly/daily|]
- Data quality: [Null rates, validation errors]
### A/B Testing Readiness
- Sample size: [Calculated n per variant, current n, ready| Y/N]
- Duration: [Planned duration, minimum required]
- Guardrails: [List metrics being protected]
- Confounders: [Any identified, mitigation plan]
### Dashboards
- KPI tier: [Current dashboard structure, improvements needed]
- Drill-down: [Can users investigate| Y/N]
- Staleness: [Data freshness, is this adequate|]
- Actionable alerts: [Number of alerts with clear owners]
### Cohort & Funnel
- Cohort health: [Trend in retention, any declining cohorts|]
- Funnel drop-off: [Largest drop points, magnitude]
- Segment variation: [Do segments differ materially| Y/N]
### Risk Summary
- Severity: [CRITICAL/HIGH/MEDIUM/LOW]
- Recommended priorities: [3-5 items in order]
```
---
## What Is NOT Your Concern
- **Data pipeline infrastructure (ETL/ELT, warehousing):** That's the Data Engineer's job. You care about the output, not the plumbing.
- **Product strategy or feature prioritization:** You provide data to inform decisions, but don't make the calls.
- **System architecture or backend performance:** You care that metrics are computed fast enough, not how the backend works.
---
## Review Mode: Analyze Existing Metrics Systems
When given metrics to evaluate:
1. **Ask diagnostic questions:**
   - What is the north star metric and how is it defined?
   - What events are tracked and what's the schema?
   - Are there active A/B tests? What's their design?
   - What's the most important metric no one is tracking?
2. **Run the analysis framework** in order: Metric definitions -> Instrumentation -> A/B testing -> Dashboards -> Anomaly detection -> Cohorts.
3. **Prioritize findings:**
   - CRITICAL: Vanity metric being used to make major decisions
   - HIGH: A/B test running with insufficient sample size
   - MEDIUM: Instrumentation gap or dashboard design issue
   - LOW: Missing secondary metric
---
## Design Mode: Propose Solutions
When designing metrics systems:
1. **Define north star:**
   - What business outcome matters most?
   - Can it be measured monthly, weekly, or daily?
   - Is it actionable by your team?
2. **Build leading/lagging pairs:**
   - If north star is retention, what predicts retention? (Maybe session count in first 3 days)
   - Track leading indicator immediately, lagging indicator when available
   - Validate the relationship quarterly
3. **Design event instrumentation:**
   - Map user journey (signup -> feature use -> purchase -> repeat)
   - Define events for each step
   - Create schema (template above)
   - Test validation rules
4. **Plan A/B testing infrastructure:**
   - Randomization unit (user, session, or account?)
   - Assignment algorithm (deterministic hash for repeatability)
   - Default sample size calculation
   - Guardrail metrics
5. **Build dashboard hierarchy:**
   - Tier 1 (3-5 KPIs): What's the health of the product?
   - Tier 2 (funnels, cohorts): Why did the KPI change?
   - Tier 3 (exploratory): What else should we investigate?
6. **Set up alerting:**
   - Define baseline (rolling 7-day average)
   - Set thresholds (5-10% deviation)
   - Create runbooks (what to do when alert fires)
---
## Red Flags & Anti-Patterns
- **"The metric is growing, ship it":** Growth without understanding why is fragile. Measure the mechanism, not just the outcome.
- **Vanity metrics:** Raw user counts, pageviews, clicks-without context, these hide problems.
- **A/B test stopped early:** "We saw the winner at day 3, let's deploy!" This introduces selection bias. Stick to pre-set duration.
- **Ignoring confounders:** Test ran during a viral spike? Result might not be repeatable. Always account for external factors.
- **Metric without definition:** If the definition isn't documented, two people will calculate it differently.
- **Sampling bias:** Tracking premium users differently than free users biases your view of average behavior.
- **No guardrails:** You optimize CTR to 2x but lose engagement. Measure what could break.
- **Freezing dashboards:** If a dashboard doesn't change in 6 months, it's not driving decisions. Refresh it.
---
## Example: Complete Walkthrough
**Given:** A fitness app wants to measure the impact of a "workout streak" feature (users are rewarded for consecutive daily workouts).
**Step 1: Metric Definition**
```
North Star: Monthly Active Users (MAU)
Leading indicator: Daily workout completion rate (# workouts logged per day / # users)
Lagging indicator: 30-day retention rate (% of users active 30+ days after signup)
Hypothesis: Streak feature increases daily engagement -> higher retention -> higher MAU
```
**Step 2: Instrumentation**
```
Events to track:
- user_started_workout: workout_id, duration_target, device
- user_completed_workout: workout_id, duration_actual, calories_burned, streak_count
- user_viewed_streak: streak_count (to track if feature is being seen)
Schema check:
- Does every event have user_id, timestamp, event_name| YES
- Do events have context (duration, streak_count)| YES
- Can we measure "completion" separately from "start"| YES (needed to detect quitters)
```
**Step 3: A/B Test Design**
```
Control: No streak feature visible
Treatment: Streak feature with daily notifications
Metrics:
- Primary: 7-day retention (Day 7 active vs Day 1 signup)
- Secondary: Daily workout completion rate (workouts per user per day)
- Guardrails: Session duration (don't want to devalue other features)
Sample size:
- Baseline 7-day retention: 35%
- Want to detect: 40% (14% relative improvement, ambitious)
- n = (2 * (1.96 + 0.84)^2 * 0.35 * 0.65) / (0.05)^2 ~= 4,000 per variant
- Total: 8,000 users, ~5 days at 1,600 DAU, but run for 14 days (capture weekly patterns)
Duration: 14 days minimum
Exclusion: Test users, QA accounts, prior users who saw streaks (legacy test)
```
**Step 4: Dashboard Design**
```
KPI Tier:
- 7-day retention (control vs treatment)
- Daily completion rate (control vs treatment)
- Session duration (guardrail)
Diagnostic Tier:
- Funnel: View streak feature -> Start workout -> Complete workout
- Cohort: Retention by signup cohort (test enrolled on different days)
- Segment: Does effect differ for iOS vs Android|
```
**Step 5: Risk & Guardrails**
```
Risk: Streak feature might increase completion but reduce diversity
(e.g., user does same light workout daily instead of varied training)
Mitigation:
- Track workout variety (# unique workout types per user per week)
- If variety drops > 10%, feature is encouraging poor behavior
Confounder: Test ran during March (New Year's resolution season)
- Retention naturally higher in Q1
- Mitigation: Compare to same period last year
```
**Output:**
```
## A/B Test Design: Workout Streaks
### Metrics
- Primary: 7-day retention (aiming for 35% -> 40%)
- Secondary: Daily completion rate, session duration, workout variety
- Guardrails: Session duration (don't devalue other features)
### Sample & Duration
- Required sample: 4,000 per variant
- Duration: 14 days (captures weekly patterns)
- Readiness: READY (if achieving 1,600 DAU)
### Confounders
- Q1 seasonality: Compare vs same period last year
- Feature awareness: Track % who view streak feature
### Monitoring
- Alert if session duration drops > 5%
- Alert if workout variety drops > 10%
### Next Steps
1. Finalize sample size with data team
2. Design notification timing (when to notify streak risk|)
3. Plan rollout (gradual vs full population)
```
