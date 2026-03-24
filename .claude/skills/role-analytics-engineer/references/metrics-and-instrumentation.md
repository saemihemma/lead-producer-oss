# Metrics and Instrumentation Reference
Deep reference material for metric definition, telemetry design, and instrumentation quality.
### 1. Metric Definition & Validation (Foundation)
Every metric must answer: "What is this measuring, and why should we care?"
**What to look for:**
- **North Star clarity:** Is there one clear north star metric for the team/product? (e.g., DAU, revenue, engagement) If there are > 3, the strategy is unclear.
- **Leading vs lagging:** Leading indicators predict future outcomes (e.g., feature adoption -> retention). Lagging indicators confirm outcomes (e.g., churn). Do you have both?
- **Vanity test:** Does the metric go up even when the business doesn't improve? Red flag: raw user count in a declining product.
- **Actionability:** Can a team move this metric with a single decision? If not, it's too aggregated.
- **Composition:** Is this metric a blend of things with opposite implications? (e.g., average session length increases if power users engage more OR casual users stay confused longer-unclear direction)
**Definition template (every metric needs this):**
```
Name: Daily Active Users (DAU)
Definition: Count of unique user_ids who initiated >= 1 billable action on a given day
Measurement: SUM(DISTINCT user_id) WHERE event_date = | AND billable = true
Includes: Web, iOS, Android, all event types
Excludes: Test users, internal QA accounts, bots (identified by bot flag = true)
Latency: 24h (measured next day)
Owners: Growth team
Why we track: Leading indicator of product health and market fit
```
**Red flags:**
- "Active user" without defining what "active" means (login? feature use? purchase?)
- Metric defined by engineering without PM input
- Metrics that require manual calculation or special queries (not automated)
- Metric definitions that change mid-quarter
- No exclusion rules (test data pollutes production metrics)
**Quantitative thresholds:**
- If > 3 weeks pass before a metric is formalized, it's being used blind
- If a metric can't be computed in < 5 seconds, alerting on it is unreliable
### 2. Telemetry Instrumentation Design
What events get tracked, what data is captured, and how is it stored?
**What to look for:**
- **Event schema consistency:** Do all events have user_id, timestamp, event_name, properties? Is this validated?
- **Sampling:** Is event volume manageable? Sampling 1% of low-priority events is fine; sampling critical events introduces bias.
- **Identifiers:** How is a user tracked across devices/sessions? If not properly unified, you double-count.
- **Latency:** When does an event land in the data warehouse? If > 1 day, you can't alert.
- **Completeness:** Which events are tracked? Are gaps created by selective instrumentation? (e.g., tracking success but not failure)
**Design checklist:**
```
Event: user_viewed_product
{
  "user_id": "uuid",           // Unique, consistent across devices
  "event_id": "uuid",          // For deduplication
  "timestamp": "2026-03-19T10:30:00Z",  // UTC, precise to millisecond
  "event_name": "user_viewed_product",  // Exact value, case-sensitive
  "product_id": "sku_123",     // Foreign key, linked to products table
  "product_category": "shoes", // Denormalized for ease of filtering
  "search_query": "blue shoes",// NULL if not from search, prevents ambiguity
  "device": "ios",             // enum: web, ios, android
  "session_id": "sess_123",    // For session analysis
}
```
**Red flags:**
- Optional fields with inconsistent meaning (NULL sometimes means "unknown", sometimes means "not applicable")
- Event properties that are free-form text (impossible to aggregate)
- No event validation at source (garbage in, garbage out)
- Events that track PII (user_email in event properties = compliance risk)
- Timestamps in local time instead of UTC
**Quantitative thresholds:**
- If event schema has > 50% NULL rate on a field, it shouldn't exist
- If > 10% of events fail validation, stop the pipeline and fix instrumentation
