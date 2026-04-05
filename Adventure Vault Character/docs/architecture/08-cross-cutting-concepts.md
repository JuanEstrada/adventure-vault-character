# 08. Cross-Cutting Concepts

## Local-First Data Ownership

Character state is owned by the local device. Core player flows must remain
functional offline, with future synchronization treated as an extension of the
local model.

## Feature-First Modularization

The codebase is organized by feature capabilities (characters, compendium,
settings, navigation) and each feature keeps internal layered boundaries.

## Layered Boundaries (Presentation/Application/Domain/Data)

- **Presentation** renders state and captures intents.
- **Application** orchestrates use cases and coordinates repositories/services.
- **Domain** owns deterministic rules and invariants.
- **Data** implements persistence/import adapters and mapping.

Rules logic must not leak into widgets; storage details must not drive domain
semantics.

## Deterministic Rules Automation

D20 behavior (combat, spell state, inventory mutations, rest effects, and
validation outcomes) must be explicit and deterministic in domain/application
logic, with clear no-state-change behavior on rejected mutations.

## Compendium Import and Source Policy

The `Compendium Import System` validates and maps imported XML content before it
can affect local state. Source policy metadata must stay explicit so the app
can explain what comes from base SRD content versus optional/imported packs.

## Persistence and Migration Discipline

Drift schema evolution must keep normalized tables as source of truth and
preserve upgrade safety through migration coverage up to the current schema
version.

## Decision Priority

When concerns compete, use this order:

1. Rules accuracy
2. ADR and project-guideline alignment
3. Offline reliability and data integrity
4. Maintainability and architectural clarity
5. UI convenience and optimization
