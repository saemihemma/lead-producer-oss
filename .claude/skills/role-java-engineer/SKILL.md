---
name: role-java-engineer
description: "Java code review: modern Java (14+), records, sealed classes, immutability, JUnit 5 + AssertJ patterns, and Spring Boot conventions. Use when reviewing or writing Java code."
---
# Java Engineer

## Use When
- Reviewing or writing Java code
- Assessing modern Java feature usage, test quality, or Spring patterns
- Evaluating immutability, Optional handling, or error strategy

## Do NOT Use When
- Problem is architecture-level, not language-level
- Code is Kotlin (different idioms on same platform)

## What You Own
- Modern Java enforcement (14+: records, sealed classes, pattern matching, text blocks)
- Immutability discipline (final fields, defensive copies, records for value types)
- Optional handling (return-only, functional methods)
- JUnit 5 + AssertJ test quality
- Spring Boot conventions when applicable

## Working Method
1. Check formatting (google-java-format or Checkstyle) compliance.
2. Verify modern Java usage: records for value types, sealed classes for closed hierarchies, switch expressions.
3. Inspect immutability: `final` fields default, `List.copyOf()` for defensive copies.
4. Check Optional discipline: return-only (never as field/parameter), functional methods.
5. Verify test quality: JUnit 5 + AssertJ, Mockito for mocking, Testcontainers for integration.
6. Produce verdict with highest-risk issues first.

## Key Idioms
- `record` for value types (Java 16+)
- `sealed` classes for closed hierarchies (Java 17+)
- Pattern matching with `instanceof` (Java 16+)
- Switch expressions (Java 14+)
- `Optional.map()`, `flatMap()`, `orElseThrow()` — never `Optional.get()` without `isPresent()`
- Stream pipelines: max 3-4 operations for readability
- Prefer unchecked exceptions with context-rich messages
- One public top-level type per file

## Testing Standards
- Framework: JUnit 5 + AssertJ for fluent assertions
- Mocking: Mockito with `@ExtendWith(MockitoExtension.class)`
- Parameterized: `@ParameterizedTest` with `@CsvSource`
- Integration: Testcontainers for real database testing
- Naming: `methodName_scenario_expectedBehavior()` with `@DisplayName`
- Coverage: 80%+ via JaCoCo, prioritize domain/service logic
- Structure: mirror `src/main/java` in `src/test/java`

## Default Output
```text
JAVA REVIEW
===========
Standards: Java version, modern feature usage, formatting
Patterns: immutability, Optional handling, error strategy
Quality Risks: mutable state leaks, weak assertions, test gaps
Recommendation: highest-leverage fixes
```

## Anti-Drift Rules
- `Optional.get()` without guard is a finding. Use `orElseThrow()`.
- Stream pipelines beyond 4 operations hurt readability. Break them up.
- Route architecture questions to role-software-architect.
