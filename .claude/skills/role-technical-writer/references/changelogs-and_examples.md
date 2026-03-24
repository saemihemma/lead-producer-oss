# Changelogs and Examples Reference
Deep reference material for changelogs, walkthroughs, example documentation, and documentation system design.
### 7. Changelog Writing
Help users understand what changed and how to migrate.
**What to look for:**
- **Clarity:** What changed? (Not just "improved performance")
- **User impact:** Does this affect my code? (Breaking change vs backwards compatible)
- **Migration guide:** If breaking, how do I update my code?
- **Links:** Does it link to relevant docs/ADRs?
- **Grouping:** Are changes organized logically?
**Changelog template (semantic versioning):**
```
## [2.0.0] - 2026-03-19
### Breaking Changes
- Removed deprecated `users.legacy_api` endpoint
  - Migration: Use `GET /v2/users` instead
  - Docs: [Link to v2 API docs]
### Added
- New `batch` endpoint for bulk operations
  - Docs: [Link]
  - Example: `POST /v1/batch` with array of operations
### Changed
- Improved error messages (no code change needed)
  - Example: "Invalid email" is now "Invalid email: must contain @"
### Fixed
- Fixed bug where pagination returned duplicate items
  - Affected code: Anyone using `|offset=X&limit=Y`
  - Impact: Results may differ slightly (duplicates removed)
### Deprecated
- `auth.basic` authentication (use `auth.oauth` instead)
  - Will be removed in v3.0
  - Migration guide: [Link]
```
**Real example:**
```
## [1.5.0] - 2026-03-19
### Breaking Changes
- API now requires `Content-Type: application/json` header on all POST/PUT requests
  Before:
    curl -X POST https://api.example.com/users -d '{"email":"alice@example.com"}'
  After:
    curl -X POST https://api.example.com/users \
      -H "Content-Type: application/json" \
      -d '{"email":"alice@example.com"}'
### Added
- Webhook support for user creation events
  - Docs: [Webhooks guide]
  - Example: POST /v1/webhooks with URL + events
### Fixed
- Fixed timezone handling in timestamps (was using local time, now UTC)
  - Impact: Timestamps will shift if your server is not UTC
### Migration guide
1. Add `Content-Type: application/json` header to all API calls
2. If you parse timestamps, accounts for timezone shift (usually not user-visible)
3. If you use webhooks, set up webhook endpoints (optional, feature is backwards compatible)
```
**Red flags:**
- Changelog entries like "Various improvements" (unclear what changed)
- No migration guide for breaking changes (users don't know how to upgrade)
- Breaking changes buried in the middle (should be first)
- No indication of severity (is this just a bug fix or a breaking change?)
**Quantitative thresholds:**
- Breaking change? Must include migration guide with before/after examples
- If > 5 breaking changes, consider splitting into major versions
- Changelog updated when features are released (not retroactively)
---
## Output Format: Structured Findings
When analyzing documentation:
```
## Documentation Review
### Audience
- Primary audience(s): [Developer / User / Operator / Manager, explicitly identified|]
- Knowledge level assumed: [Beginner / Intermediate / Expert, appropriate|]
- Persona-specific content: [Tailored or one-size-fits-all|]
### Documentation Types (Diataxis)
- Tutorials: [Present| Y/N, quality for beginners|]
- How-to guides: [Present| Y/N, focused on specific tasks|]
- Reference docs: [Present| Y/N, complete and organized|]
- Explanations: [Present| Y/N, conceptual understanding included|]
### Information Architecture
- Navigation: [Clear hierarchy| Y/N, findable in 30 seconds|]
- Progressive disclosure: [Basic then advanced| Y/N]
- Section length: [Average minutes to read, target 5-15|]
- Table of contents: [Present and useful| Y/N]
### Clarity
- Sentence length: [Average words, target < 20|]
- Voice: [Active/Passive, percentage active|]
- Jargon: [Explained on first use| Y/N, density|]
- Examples: [Present| Y/N, realistic and working|]
### API Documentation
- All endpoints documented: [Y/N, complete|]
- Request/response examples: [Present| Y/N, realistic|]
- Error handling: [All error codes documented| Y/N]
- Authentication: [Clear| Y/N]
### Maintenance
- Last updated: [Date, current|]
- Owner: [Assigned| Y/N, accountable|]
- Version tracking: [Clear which version this docs covers|]
- Outdated content: [Any found| Extent|]
### Risk Summary
- Severity: [CRITICAL/HIGH/MEDIUM/LOW]
- Recommended priorities: [3-5 items in order]
```
---
## What Is NOT Your Concern
- **Code implementation:** You don't care how code is structured, only that it's documented.
- **Feature design:** You don't decide what features exist, only that they're documented.
- **Code quality or architecture decisions:** That's other roles. You document the decisions, not make them.
---
## Review Mode: Analyze Existing Documentation
When given documentation to evaluate:
1. **Ask diagnostic questions:**
   - Who is the primary audience?
   - When was this last updated?
   - Is there an owner/maintainer assigned?
   - What types of docs exist (tutorials? reference? ADRs?)?
   - Are there docs that users struggle to find?
2. **Run the analysis framework** in order: Audience -> Doc types -> Information hierarchy -> Clarity -> API patterns -> ADRs -> Changelog.
3. **Prioritize findings:**
   - CRITICAL: Outdated or incorrect documentation causing user confusion
   - HIGH: Missing documentation (feature exists, no docs), unclear instructions
   - MEDIUM: Information organization, clarity issues, missing examples
   - LOW: Style, minor clarity improvements
---
## Design Mode: Propose Solutions
When designing documentation systems:
1. **Define audience explicitly:**
   - Create 2-3 personas (name, background, goals, pain points)
   - Identify what each persona needs
2. **Design doc structure (Diataxis):**
   - Tutorials: Getting started (1 per main feature)
   - How-to guides: Common tasks (1 per task)
   - Reference: API, config, commands (comprehensive)
   - Explanations: Concepts, architecture, design decisions
3. **Plan information hierarchy:**
   - Start with basic concepts (5 min)
   - Add simple examples (runnable code)
   - Link to detailed how-tos
   - Collapsible "advanced" sections
4. **Define clarity standards:**
   - Sentence length < 20 words
   - Active voice (default)
   - Jargon explained on first use
   - Every concept needs an example
5. **Create doc templates:**
   - Tutorial template
   - How-to template
   - API endpoint template
   - ADR template
6. **Plan maintenance:**
   - Assign owner (who keeps docs updated?)
   - Set review cadence (quarterly)
   - Link docs to features (docs updated when feature changes)
7. **Implement discovery:**
   - Table of contents
   - Search functionality
   - Related links (this doc links to related docs)
   - Clear site structure
---
## Red Flags & Anti-Patterns
- **"We'll document it later":** Later never comes. Docs become outdated. Document as you build.
- **One massive doc:** 100+ page monolith. Split into smaller docs by Diataxis type.
- **No examples:** "You can configure X" without showing how. Every parameter needs an example.
- **Outdated docs:** Docs describe old API, users waste time. Set review cadence, assign owner.
- **Theory without practice:** Explanation without examples. Add runnable code to every concept.
- **Mixed audience:** Docs for beginners AND experts mixed together. Separate or use progressive disclosure.
- **No changelog:** Users don't know what changed. Maintain a changelog with migration guides.
- **Docs in Slack:** Knowledge exists only in chat. Docs disappear. All knowledge should be written docs.
- **No search:** Users can't find docs. Add search functionality.
- **Broken links:** Links to old docs or external sites that change. Verify links quarterly.
---
## Example: Complete Walkthrough
**Given:** Design documentation system for a new REST API (user management).
**Step 1: Identify Audience**
```
Persona 1: Junior Developer
- Background: 1-2 years experience, familiar with REST APIs, Python
- Goals: Get working code in 15 minutes, understand API basics
- Needs: Quick start, curl examples, explained error codes
Persona 2: Systems Architect
- Background: 10+ years, designing systems, familiar with OAuth, databases
- Goals: Understand API design philosophy, limitations, scaling
- Needs: Architecture explanation, performance specs, design decisions (ADRs)
Persona 3: DevOps Engineer
- Background: Infrastructure focused, deploying and operating systems
- Goals: Monitor API health, understand failure modes, operational concerns
- Needs: Deployment guide, monitoring setup, runbooks, config reference
```
**Step 2: Design Doc Structure**
```
Documentation tree:
  /docs
    /getting-started
      quick-start.md (Tutorial: 10 min, working code)
    /guides
      create-user.md (How-to: Create a user)
      authenticate.md (How-to: Set up auth)
      pagination.md (How-to: Paginate results)
      webhooks.md (How-to: Set up webhooks)
    /api-reference
      users.md (Reference: POST /users, GET /users, etc.)
      errors.md (Reference: All error codes)
      authentication.md (Reference: Auth methods)
      rate-limiting.md (Reference: Rate limits)
    /explanations
      why-oauth2.md (Explanation: Why we chose OAuth2)
      api-design-principles.md (Explanation: REST principles)
      data-model.md (Explanation: User model structure)
    /operations
      deployment.md (How-to: Deploy the API)
      monitoring.md (How-to: Set up monitoring)
      troubleshooting.md (How-to: Debug issues)
    /decisions
      adr-001-oauth2.md (Architecture Decision Record)
      adr-002-postgresql.md (Architecture Decision Record)
```
**Step 3: Write Tutorial (for junior dev)**
```
# Getting Started: Your First API Call (10 minutes)
## What you'll build
In this tutorial, you'll make your first API call and create a user account.
## Prerequisites
- Terminal or command line
- curl (pre-installed on most systems)
- A free account at example.com
## Step 1: Get your API key (2 minutes)
1. Go to https://example.com (account creation flow)
2. Once logged in, click "Settings" (top right)
3. Click "API Keys" (left sidebar)
4. Click "Generate New Key"
5. Copy the key (it looks like `sk_test_abc123...`)
## Step 2: Make your first API call (3 minutes)
1. Open terminal
2. Run this command (replace YOUR-KEY with your actual key):
   ```
   curl -X POST https://api.example.com/v1/users \
     -H "Authorization: Bearer YOUR-KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "email": "alice@example.com",
       "password": "SecurePass123",
       "name": "Alice"
     }'
   ```
3. You should see a response like:
   ```
   {
     "id": "user_abc123",
     "email": "alice@example.com",
     "name": "Alice",
     "created_at": "2026-03-19T10:30:00Z"
   }
   ```
## Step 3: Verify it worked (2 minutes)
1. Go to https://example.com/users/alice (in your browser)
2. You should see the user you just created
3. Success! You've made your first API call
## Next steps
- [Learn how to authenticate with OAuth](./authenticate.md)
- [Read the full user creation documentation](../api-reference/users.md#create-user)
- [Understand API error codes](../api-reference/errors.md)
## Common errors
**Error: 401 Unauthorized**
- Your API key is invalid or missing
- Fix: Double-check the key matches what you copied in Step 1
**Error: 400 Bad Request: Invalid email**
- Email format is wrong
- Fix: Ensure email contains @ symbol
**Error: 409 Conflict: Email taken**
- The email is already registered
- Fix: Use a different email address
```
**Step 4: Write How-to Guide (task-focused)**
```
# How to create a user account via API
## Prerequisites
- You have an API key (get one in [Getting Started](./getting-started.md))
- You're familiar with making API calls
## Steps
### 1. Prepare your request
You'll need:
- API key (from Settings -> API Keys)
- User email (must be unique)
- User password (minimum 8 characters, at least 1 uppercase)
- User name (optional)
### 2. Make the API call
```
curl -X POST https://api.example.com/v1/users \
  -H "Authorization: Bearer YOUR-KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "bob@example.com",
    "password": "MyPassword123",
    "name": "Bob"
  }'
```
### 3. Parse the response
The response will contain:
- `id`: User ID (use this to update/delete user)
- `email`: Email you provided
- `name`: Name you provided
- `created_at`: When the user was created
Example response:
```json
{
  "id": "user_xyz789",
  "email": "bob@example.com",
  "name": "Bob",
  "created_at": "2026-03-19T10:30:00Z"
}
```
### 4. Verify success
Check the user was created:
```
curl -H "Authorization: Bearer YOUR-KEY" \
  https://api.example.com/v1/users/user_xyz789
```
## Error handling
| Error | Cause | Solution |
|-------|-------|----------|
| 400 Bad Request | Email invalid or password weak | Ensure email has @, password has 8+ chars + uppercase |
| 409 Conflict | Email already exists | Use a different email |
| 401 Unauthorized | Invalid API key | Check Settings -> API Keys |
| 429 Too Many Requests | Rate limited | Wait 1 minute, then retry |
## Next: Set up authentication
Once users are created, learn how to [authenticate as those users](./authenticate.md).
```
**Step 5: Write API Reference**
```
# User Endpoints
## Create user
POST /v1/users
Creates a new user account.
### Authentication
None (public endpoint, but recommended: use API key)
### Request body
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | Yes | User email. Must be unique. |
| password | string | Yes | Password. Min 8 chars, 1 uppercase. |
| name | string | No | User display name. |
### Response (201 Created)
| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique user ID |
| email | string | User email |
| name | string | User display name |
| created_at | ISO 8601 | Account creation time |
### Error responses
| Code | Error | Description |
|------|-------|-------------|
| 400 | bad_request | Email invalid or password too weak |
| 409 | email_taken | Email already exists |
### Example
Request:
```
curl -X POST https://api.example.com/v1/users \
  -H "Content-Type: application/json" \
  -d '{
    "email": "alice@example.com",
    "password": "SecurePass123",
    "name": "Alice"
  }'
```
Response (201):
```json
{
  "id": "user_abc123",
  "email": "alice@example.com",
  "name": "Alice",
  "created_at": "2026-03-19T10:30:00Z"
}
```
### Rate limits
- 100 requests per minute per IP
- Headers: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`
## Get user
GET /v1/users/:user_id
Retrieves a user by ID.
[... (similar structure for other endpoints)
```
**Step 6: ADR (Architecture Decision)**
```
# ADR 001: Public API for user creation
## Status
Accepted (2026-03-19)
## Context
Users should be able to create accounts without pre-existing authentication.
## Decision
POST /users endpoint is public (no API key required).
## Trade-offs
Public:
  Pros: Easy onboarding, anyone can try API
  Cons: Abuse risk (bot signups), spam accounts
Authenticated:
  Pros: Prevent abuse
  Cons: Harder for new users to try, adds friction
## Consequences
- Add CAPTCHA to prevent bot abuse
- Monitor for spam accounts, implement per-IP rate limits
- Can always make auth required later (breaking change)
## Next steps
- Implement CAPTCHA integration
- Set rate limits on signup endpoint
```
**Step 7: Setup (Documentation ownership)**
```
Documentation owner: David Chen (backend-team-lead@example.com)
Review cadence: Quarterly (before each release)
Maintenance: Updated when features change (same sprint as feature implementation)
Docs are stored in: /repo/docs
Built with: MkDocs
Published to: docs.example.com
Checklist before release:
[ ] Tutorial works (ran through it myself)
[ ] API reference matches actual API
[ ] Error codes documented and tested
[ ] Examples are copy-paste ready
[ ] Changelog updated
```
**Output:**
```
## Documentation System Design
### Audience
- Junior developer (quick start)
- Systems architect (design decisions)
- DevOps engineer (operations)
### Documentation Structure (Diataxis)
- Tutorials: Getting started (10 min, working code)
- How-to guides: 5 common tasks
- Reference: All API endpoints, errors, auth
- Explanations: Design decisions (ADRs)
### Key Features
- Progressive disclosure (basic -> advanced)
- Real, working examples (copy-paste ready)
- Error handling documented
- Changelog updated each release
- Single owner (accountable for maintenance)
### Maintenance Plan
- Reviewed quarterly
- Updated when features change
- Link docs to feature implementation
- Old docs archived, not deleted
```
