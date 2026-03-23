# Audience and Diataxis Reference
Deep reference material for audience analysis, doc-type selection, information hierarchy, and clarity standards.
### 1. Audience Analysis & Identification
Understand who you're writing for and what they need.
**What to look for:**
- **Primary audience:** Developers? End users? Operators? Product managers? Mix?
- **Knowledge level:** Beginners? Intermediate? Experts? (Tailor examples and jargon to level)
- **Use case:** Learning? Reference? Troubleshooting? How-to?
- **Context:** Are they new to the tool? Experienced with competitors?
**Audience personas (create specific, detailed personas):**
```
Persona 1: Junior Developer (New to API)
- Background: 2 years experience, familiar with REST APIs, JavaScript
- Goals: Get a working example in 15 minutes, then learn details
- Pain points: Too much theory before code, unclear request/response format
- Doc needs: Quick start with curl example, request/response samples
Persona 2: DevOps Engineer (Operator)
- Background: 10+ years infrastructure, familiar with logging/monitoring
- Goals: Deploy, monitor, troubleshoot in production
- Pain points: Missing operational details (config, tuning, failure modes)
- Doc needs: Installation guide, config reference, troubleshooting guide, runbooks
Persona 3: Product Manager (Decision maker)
- Background: Non-technical, understands business requirements
- Goals: Understand capabilities and limitations, make trade-off decisions
- Pain points: Too much technical jargon, missing business-level examples
- Doc needs: High-level overview, use cases, limitations, pricing/SLA
```
**Red flags:**
- Docs that try to serve all audiences equally (will satisfy none)
- No explicit audience identified (impossible to write for "everyone")
- Jargon without explanation (assuming audience knowledge)
- Examples for experienced users, no basic examples (beginners are lost)
**Quantitative thresholds:**
- If documentation is > 10 pages without clear sections, audience is probably mixed (separate docs by audience)
- If "Audience" section is missing from docs, audience was not explicitly considered
### 2. Documentation Type Classification (Diataxis Framework)
Choose the right type of documentation for each need.
**Four types (from Diataxis framework):**
**1. Tutorials (Learning-oriented)**
```
Purpose: Get a new user productive quickly
Structure: Step-by-step, hands-on, achieves concrete goal
Content: Prerequisites, steps, explanation of why, common mistakes
Length: 5-15 minutes
Example: "Build your first REST API in 10 minutes"
Key principles:
- Hands-on (reader follows along and builds something)
- Begins from scratch (no prerequisites beyond general knowledge)
- Focused on one goal (not comprehensive)
- Avoids rabbit holes (can't explore all options)
- Includes the "why" (not just "what")
BAD:
  1. Install the SDK
  2. Create an API key
  3. Make a request
  4. Parse the response
GOOD:
  1. Create an account at example.com
  2. Navigate to API Keys (left sidebar, "Settings" -> "API Keys")
  3. Click "Generate New Key", copy the key
  4. In your terminal, create main.py:
     ```
     import requests
     api_key = "your-key-here"
     response = requests.get("https://api.example.com/users",
                            headers={"Authorization": f"Bearer {api_key}"})
     print(response.json())
     ```
  5. Run: python main.py
  6. Expected output: List of users in JSON format
```
**2. How-to Guides (Task-oriented)**
```
Purpose: Help user accomplish a specific task
Structure: Prerequisites -> steps -> verification
Content: Focused on one task, assumes prior knowledge
Length: 3-10 minutes per task
Example: "How to set up webhooks", "How to configure rate limiting"
Key principles:
- Focused on one task
- Assumes reader knows basics (doesn't explain fundamentals)
- Provides specific steps, not generic advice
- Includes verification step ("how do I know it worked?")
- Real examples (not illustrative pseudocode)
BAD:
  "Configure authentication by setting up your API key in the config file"
GOOD:
  "Configure authentication:
   1. Open config.yaml
   2. Add line: api_key: your-key-here
   3. Verify: Run `python check_auth.py` and you should see 'Auth OK'"
```
**3. Reference Documentation (Information-oriented)**
```
Purpose: Look up specific information (API, config, command)
Structure: Organized by topic, searchable, concise
Content: What does this thing do| Parameters| Return values| Exceptions|
Length: 1-3 paragraphs per item
Example: API endpoint documentation, config parameter reference
Key principles:
- Organized by topic (API endpoints, config options, commands)
- Concise (say what it does, not how to use it)
- Complete (all parameters, all return values, all exceptions)
- Searchable (clear headings, index)
Example (API reference):
  POST /v1/users
  Creates a new user account.
  Request body:
    - email (string, required): User's email address
    - password (string, required): At least 8 characters, 1 uppercase
    - name (string, optional): User's display name
  Response (201 Created):
    - id (string): User ID, unique identifier
    - email (string): User's email (from request)
    - name (string): User's display name
    - created_at (timestamp): When user was created
  Errors:
    - 400 Bad Request: If email invalid or password weak
    - 409 Conflict: If email already exists
  Example:
    curl -X POST https://api.example.com/v1/users \
      -H "Content-Type: application/json" \
      -d '{
        "email": "alice@example.com",
        "password": "SecurePass123",
        "name": "Alice"
      }'
  Response:
    {
      "id": "user_abc123",
      "email": "alice@example.com",
      "name": "Alice",
      "created_at": "2026-03-19T10:30:00Z"
    }
```
**4. Explanations (Understanding-oriented)**
```
Purpose: Explain concepts, design decisions, architecture
Structure: Build understanding progressively, provide context
Content: Why| How| When to use| When not to|
Length: 5-20 minutes, can be longer
Example: "Understanding JWT authentication", "Why we chose PostgreSQL"
Key principles:
- Not prescriptive (explains trade-offs, not "the way")
- Conceptual (helps reader understand, not just follow steps)
- Provides context (where does this fit in the bigger picture|)
- Addresses misconceptions (what people get wrong)
Example:
  "Why we use exponential backoff:
   When a service is overloaded, many clients will retry immediately.
   If they all retry at the same time, they create another spike,
   making the problem worse.
   Exponential backoff staggers retries:
   - First failure: retry after 1 second
   - Second failure: retry after 2 seconds
   - Third failure: retry after 4 seconds
   - And so on...
   This spreads out retry attempts, preventing retry storms.
   See 'How to implement exponential backoff' for code examples."
```
**Decision matrix (which type to write?):**
```
Reader needs...              | Use this type
-----------------------------|-------------------
A working example quickly    | Tutorial
Step-by-step for a task      | How-to Guide
Look up a parameter/API      | Reference
Understand a concept         | Explanation
Reader skill level:          | Doc type priority
-----------------------------|-------------------
Beginner (new to tool)       | Tutorial > How-to > Reference > Explanation
Intermediate (has context)   | How-to > Reference > Explanation > Tutorial
Expert (knows it already)    | Reference > Explanation > How-to > Tutorial
```
**Red flags:**
- One doc that mixes all four types (Tutorial + Reference + How-to in same doc = confusing)
- Missing tutorials (beginners don't know where to start)
- Missing reference docs (experienced users don't know exact parameters)
- Explanation docs that read like tutorials (should not have steps)
**Quantitative thresholds:**
- Docs without clear type classification: rewrite to fit Diataxis framework
- Tutorial > 15 minutes: break into smaller tutorials
- Reference doc > 5 paragraphs per item: break into smaller chunks
### 3. Information Hierarchy & Progressive Disclosure
Layer information so readers find what they need without overwhelming.
**What to look for:**
- **Hierarchy:** Is there a clear path from basic to advanced? (Or all mixed together?)
- **Table of contents:** Is navigation clear? Can reader find what they need in 30 seconds?
- **Length:** Is information chunked into sections? (10-15 min reads, not 1 hour)
- **Front-loading:** Are prerequisites and key concepts at the top? (Or buried in step 8?)
- **Collapsible sections:** Are optional details behind expandable "Advanced" sections?
**Progressive disclosure pattern:**
```
[Basic concept in 1 paragraph]
  down
[Simple example in 5 lines of code]
  down
[Common use cases (2-3 bullets)]
  down
[Detailed explanation]
  down
[Advanced options (in collapsible section)]
  down
[Troubleshooting (in collapsible section)]
This way:
- Reader gets basic understanding immediately
- Reader can apply it with simple example
- Reader understands when to use it
- Reader can learn deeper if interested
- Reader doesn't feel overwhelmed
```
**Example (bad vs good structure):**
```
BAD (everything mixed):
  "To implement authentication, first understand the OAuth 2.0 spec (RFC 6749).
   The spec defines four grant types: authorization code, implicit, client
   credentials, and resource owner password. The authorization code flow...
   [Continues for 3 pages before mentioning how to use it]"
GOOD (progressive disclosure):
  "Authentication basics
   To make API calls, you need an API key. Get your key from Settings.
   Example (copy and paste):
     curl -H "Authorization: Bearer YOUR-KEY" https://api.example.com/users
   [At this point, reader can use the API. Advanced details in sections below]
   How to get your API key
   1. Navigate to Settings (left sidebar)
   2. Click API Keys
   3. Click Generate New Key
   4. Copy the key and keep it safe
   Understanding authentication: How it works
   [Explanation of OAuth, JWT, etc. for readers who want to understand]
   Advanced options (collapsible section)
   [Scopes, expiration, rotation, etc.]"
```
**Red flags:**
- Docs that start with theory before practical example
- No table of contents or navigation
- Documents > 20 minutes to read without section breaks
- All details front-loaded (reader drowns in information)
**Quantitative thresholds:**
- Sections should be 5-15 minutes to read (not 1 hour)
- Table of contents missing if doc > 3 sections
- Key concepts should appear in first 30 seconds
### 4. Clarity Standards
Write clear prose that doesn't require re-reading.
**What to look for:**
- **Sentence length:** Long sentences (> 20 words) are hard to parse
- **Voice:** Active (you do X) vs passive (X is done)
- **Jargon:** Unexplained technical terms confuse readers
- **One idea per paragraph:** Multiple ideas = hard to scan
- **Concrete examples:** "Use X" vs "You can use X, Y, or Z depending on..."
**Clarity principles:**
**1. One idea per paragraph**
```
BAD:
  "The database stores customer records and products, and you can
   query them using SQL or our REST API, which also supports filtering
   and pagination, though pagination is not available for certain endpoints."
GOOD:
  "The database stores customer records and products.
   You can query data using SQL or REST API.
   Both query methods support filtering and pagination.
   Note: Pagination is not available for certain endpoints."
```
**2. Active voice**
```
BAD (passive):
  "The API key should be generated in Settings."
GOOD (active):
  "To generate an API key, go to Settings."
Why: Active voice tells reader what to DO. Passive voice hides the actor.
```
**3. Explain jargon on first use**
```
BAD:
  "Configure your idempotency key to prevent duplicate requests."
GOOD:
  "Configure your idempotency key (a unique identifier that prevents
   duplicate requests if the API is called twice) to avoid double-charging
   customers."
```
**4. Use concrete examples**
```
BAD:
  "You can optionally specify a timeout parameter."
GOOD:
  "You can optionally specify a timeout parameter (in milliseconds).
   Example: timeout=5000 waits up to 5 seconds. Default: 30000 (30 seconds)."
```
**5. Use tables for comparison**
```
BAD (paragraphs):
  "There are two authentication methods. Bearer tokens are simpler but less
   secure. API keys are more secure but harder to rotate. Use bearer tokens
   for development and API keys for production."
GOOD (table):
  | Method       | Pros              | Cons         | Use case       |
  |--------------|-------------------|--------------|----------------|
  | Bearer Token | Simple            | Less secure  | Development    |
  | API Key      | More secure       | Hard to rotate| Production     |
```
**Red flags:**
- Paragraphs > 5 sentences (too dense)
- Passive voice (hides action)
- Jargon without explanation
- No examples (reader can't apply concept)
- Walls of text (no tables, bullets, or sections)
**Quantitative thresholds:**
- Average sentence length > 20 words: rewrite shorter
- Paragraphs without example: add one
- More than 3 paragraphs without section break: add header
