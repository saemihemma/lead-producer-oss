# Domain Glossary (Ubiquitous Language)

A domain glossary is a durable artifact that pins down what terms *mean* in this project, so code, docs, and conversation use words the same way. It is not a spec and not API docs — it is a shared vocabulary. Loose terminology is a source of bugs and miscommunication; this captures the agreed meaning before it drifts.

## When to produce one
- Terms are used loosely or inconsistently across code and docs.
- Onboarding repeatedly stalls on "what does X actually mean here?"
- A design or grilling session sharpened definitions worth keeping.
- Multiple subdomains use the same word for different things.

## Format
Single-domain repo: one `CONTEXT.md` (or `GLOSSARY.md`) at the root.
Multi-domain repo: a `CONTEXT-MAP.md` at the root listing subdomains, plus a per-subdomain glossary.

```markdown
# <Context Name>

## Language
**Term**: Definition in 1-2 sentences. What it is, precisely, in this domain.
_Avoid_: synonyms or near-terms that cause confusion, and why.

**Another Term**: ...

## Relationships
- Cardinality and dependencies between terms (e.g. "an Order has many LineItems; a LineItem belongs to exactly one Order").
```

## Rules
- Define a term once, in the place it is owned. Cross-reference rather than re-defining.
- Keep definitions behavioral and stable — avoid referencing file paths or line numbers that go stale.
- List the synonyms to *avoid*, not just the preferred term. Naming what not to say is half the value.
- A glossary that is never read is dead weight. Keep it small enough to maintain and point code/docs at it.

## Relationship to ADRs
The glossary captures *what terms mean*; an ADR (see `api-docs-and-adrs.md`) captures *why a decision was made*. A grilling or design session often produces both — fix the language here, record the trade-off there.
