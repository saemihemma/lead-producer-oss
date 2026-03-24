# Source Contracts and Schema Reference
Deep reference material for source contracts, schema design, and analytics modeling choices.
### 1. Source Analysis & Contract Definition
Understand what data you're getting and what guarantees you have about it.
**What to look for:**
- **Source reliability:** Is this a database, API, or file upload? Is there retry logic if it fails?
- **Schema contract:** Is the schema documented? What happens if a new column appears? If a column is removed?
- **Completeness:** What percentage of records are expected? How do you detect missing data?
- **Freshness:** How often does the source update? (hourly? daily? real-time?) What's the latency from source update to your pipeline reading it?
- **Volume:** How many rows per load? Is volume growing? (100GB/day -> 1TB/day in 12 months = partition strategy matters)
**Data contract checklist (document this for every source):**
```
Source: customers_db (PostgreSQL)
Schema version: v2 (last updated 2026-03-01)
Columns:
- customer_id (PK, INT, never NULL)
- email (VARCHAR, may be NULL, unique)
- created_at (TIMESTAMP, never NULL)
- status (ENUM: active|inactive|deleted, never NULL)
- metadata (JSON, may contain any keys, NULL if no metadata)
Change protocol:
- If new column added: announce in #data-changes 1 week before
- If column removed: set to NULL for 2 weeks before removal
- If column renamed: alias old name for backward compatibility (3 month deprecation)
Completeness SLA:
- Expected rows per day: 5M - 10M (range due to international signup patterns)
- Freshness: Synced every 1 hour (6 hours max latency acceptable)
- If < 4.5M rows in a load, alert (possible upstream issue)
Owners: [Backend team lead, email for escalation]
```
**Red flags:**
- No documented schema (source is a black box)
- Schema changes announced after they happen
- No completeness validation (pipeline just trusts the data)
- Freshness SLA undefined (can't build timely downstream processes)
- No owner (who do you call when the schema breaks?)
**Quantitative thresholds:**
- If data latency > 24 hours, downstream analytics are stale and decisions lag
- If > 5% of rows missing on a load, alert and investigate (suggests upstream issue)
- If schema changes > 2x per quarter, source team isn't versioning-enforce contract
---
### 3. Schema Design for Analytics
Structure your data warehouse for performance and clarity.
**What to look for:**
- **Dimension tables (slowly changing dimensions, SCDs):** Customers, products, dates. Do they have SCD Type handling? (Type 2 = keep history, Type 1 = overwrite)
- **Fact tables:** Events, transactions. Are they denormalized or normalized?
- **Granularity:** What's one row? (One purchase? One line item?) Is this consistent?
- **Surrogate keys:** Are there unique, stable keys for joining? Or are you joining on business keys?
**Example: Star schema for e-commerce**
```
FACT TABLE: orders
- order_id (PK, surrogate key for uniqueness)
- order_timestamp
- customer_id (FK)
- product_id (FK)
- order_amount
- quantity
Grain: One row per line item (if order has 3 items, 3 rows)
DIMENSION TABLE: customers (SCD Type 2)
- customer_surrogate_id (unique key for history)
- customer_id (business key)
- email
- status
- start_date (when this version was created)
- end_date (when this version was superseded)
- is_current (True if latest version)
Grain: One row per customer per version (if customer email changed, 2 rows)
DIMENSION TABLE: products
- product_id (PK)
- name
- category
- price
- created_at
Grain: One row per product
```
**Denormalization vs normalization:**
- Denormalize if queries always join (e.g., orders always with customer_name, not customer_id)
- Normalize if space is a constraint or updates are frequent
- Reality: Denormalize in star schema (analytics doesn't care about normalization), normalize in operational databases
**Red flags:**
- Fact table with no grain definition (ambiguous joins)
- SCD Type 1 being used where Type 2 is needed (history lost)
- No surrogate keys (business keys can change, breaking joins)
- Wide denormalized tables (100+ columns, difficult to maintain)
**Quantitative thresholds:**
- If a fact table has > 10 billion rows, partitioning is required (date, region)
- If a fact table has > 50 columns, consider separating into multiple narrow tables
