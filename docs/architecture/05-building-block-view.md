# 05. Building Block View

## Level 1: System

### Adventure Vault Character

Adventure Vault Character is the player-facing Flutter application. It stores
character state locally, applies deterministic D20 rules in domain logic, and
loads/imports compendium content for offline use.

## Level 2: Containers

### Flutter Client

Single deployable app containing feature modules and layered application logic.

### Local Persistence

Drift over SQLite for character state, compendium definitions, imported-pack
registration, and pack activation state.

### Local Rule Sources

Bundled and imported XML/JSON compendium sources used by the compendium
pipeline.

## Level 3: Components (Inside Flutter Client)

### Feature Modules (Feature-First)

The codebase is organized by feature (for example: `characters`, `compendium`,
`settings`, `navigation`) rather than by global technical folders.

### Presentation Layer

- Screens, widgets, and route-level controllers.
- Renders state and forwards intents.
- Must not own business rules.

### Application Layer

- Use-case services and orchestration.
- Coordinates presentation intents with domain and repository contracts.
- Owns transaction-like workflow sequencing for user actions.

### Domain Layer

- Domain models, value objects, and deterministic rules.
- Inventory, combat, spell, rest, and validation semantics live here.
- Provides stable behavior independent of UI and storage details.

### Data Layer

- Repository implementations, Drift DAOs, compendium parsing/mapping, and
  persistence adapters.
- Converts external and storage models into domain/application contracts.

## Decomposition Notes

- These are logical boundaries inside one Flutter application, not separate
  deployable services.
- Dependencies flow inward: presentation -> application -> domain, with data
  implementations plugged in via repository boundaries.
- This layered feature-first structure is required to keep rules correctness,
  testability, and offline resilience as the project expands.
