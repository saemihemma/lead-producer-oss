# API Docs and ADRs Reference
Deep reference material for API documentation patterns and architecture decision records.
### 5. API Documentation Patterns
Create comprehensive, usable API docs.
**What to look for:**
- **Endpoint documentation:** Method, path, description clear?
- **Request format:** Parameters, body, headers all documented?
- **Response format:** Status codes, response body, error codes?
- **Examples:** Real request/response examples?
- **Authentication:** How to authenticate? (API key, OAuth, JWT?)
- **Rate limiting:** Limits documented? How to handle 429?
**API documentation template (per endpoint):**
```
METHOD /path
[One line description]
[Longer description if needed]
Authentication: [None / API Key / OAuth / JWT]
Path parameters:
  - {param_name} (type, required/optional): Description
Query parameters:
  - param_name (type, required/optional, default): Description
  - param_name (type, required/optional): Description
Request body:
  - field_name (type, required/optional): Description
  Content-Type: application/json
Response:
  Status: [200 / 201 / 204 / etc.]
  Content-Type: application/json
  Body:
    - field_name (type): Description
    - nested_field (type): Description
Error responses:
  - 400 Bad Request: [When this happens, example error body]
  - 401 Unauthorized: [When this happens, example error body]
  - 404 Not Found: [When this happens, example error body]
  - 429 Too Many Requests: [Rate limit, how to handle]
  - 500 Internal Server Error: [Server error, retry expected]
Example request:
  [Actual curl command or code example]
Example response (200):
  [Actual JSON response body]
Rate limits:
  - [X requests per minute per API key]
  - Headers: X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset
```
**Real example:**
```
POST /v1/users
Creates a new user account.
Authentication: None (public endpoint)
Request body:
  - email (string, required): User email. Must be unique.
  - password (string, required): Password. Minimum 8 characters.
  - name (string, optional): User display name.
Response (201 Created):
  - id (string): User ID
  - email (string): User email
  - name (string): User display name
  - created_at (ISO 8601): Account creation timestamp
Errors:
  - 400 Bad Request: Email invalid or password too weak
    {
      "error": "invalid_password",
      "message": "Password must be at least 8 characters"
    }
  - 409 Conflict: Email already exists
    {
      "error": "email_taken",
      "message": "Email alice@example.com already registered"
    }
Example request:
  curl -X POST https://api.example.com/v1/users \
    -H "Content-Type: application/json" \
    -d '{
      "email": "alice@example.com",
      "password": "SecurePass123",
      "name": "Alice"
    }'
Example response (201):
  {
    "id": "user_abc123",
    "email": "alice@example.com",
    "name": "Alice",
    "created_at": "2026-03-19T10:30:00Z"
  }
Rate limits:
  - 100 requests per minute per IP
  - Retry-After header included on 429 responses
```
**Red flags:**
- Missing request examples (reader doesn't know how to call it)
- Missing error documentation (reader doesn't know what can go wrong)
- No authentication documentation
- Response structure unclear (reader doesn't know how to parse response)
- Missing rate limit documentation (reader discovers limit by hitting it)
**Quantitative thresholds:**
- Every endpoint must have >= 1 example request and response
- All error codes must be documented (if endpoint can return 400, document why)
- If response has nested objects, all fields must be documented
### 6. Decision Documentation (ADRs - Architecture Decision Records)
Document why decisions were made, not just what was decided.
**What to look for:**
- **Decision clarity:** What decision was made?
- **Context:** Why was this decision needed?
- **Alternatives:** What other options were considered?
- **Trade-offs:** Pros and cons of chosen option?
- **Consequences:** What's the long-term impact?
**ADR template:**
```
# ADR 001: Use PostgreSQL instead of MongoDB
## Status
Accepted (date)
## Context
We need a database for customer records with complex relationships.
Considered options:
1. PostgreSQL (relational, strong consistency)
2. MongoDB (document, flexible schema)
3. DynamoDB (serverless, key-value)
## Decision
Use PostgreSQL.
## Rationale
Customers have complex relationships (user -> orders -> items -> payments).
Relational model is natural fit. Strong ACID guarantees reduce bugs.
PostgreSQL is mature, well-understood, cost-effective.
## Trade-offs
PostgreSQL (chosen):
  Pros: ACID transactions, joins are fast, mature
  Cons: Vertical scaling limits, schema migrations can be slow
MongoDB:
  Pros: Horizontal scaling, flexible schema
  Cons: Weak consistency by default, joins are slower, more RAM usage
DynamoDB:
  Pros: Serverless, auto-scaling
  Cons: Query language is limited, strong consistency has limits, expensive at scale
## Consequences
- Developers must learn SQL (not a risk, standard skill)
- Schema changes require migrations (mitigation: use Flyway for migrations)
- Horizontal scaling limited (OK for now, can shard later if needed)
## Next steps
- Use RDS for managed PostgreSQL (reduces ops burden)
- Plan for backup/recovery strategy
- Establish monitoring for query performance
```
**Red flags:**
- No ADRs for major decisions (future hires don't know why decisions were made)
- ADRs without alternatives (decision process hidden)
- No discussion of trade-offs (makes it look like one option was obviously better)
**Quantitative thresholds:**
- Every major architectural decision should have an ADR (database choice, language choice, framework)
- ADR should be written at decision time (not retroactively)
