# Component Diagram Description

This file provides a lightweight C4 Level 3 view of the Flutter app.
Canonical component responsibilities live in
[../architecture/05-building-block-view.md](../architecture/05-building-block-view.md).

## C4 Level 3 Components Inside the Flutter Client

```mermaid
flowchart TD
    UI[Presentation Layer\nScreens Widgets Controllers]
    APP[Application Layer\nUse-Case Services]
    DOMAIN[Domain Layer\nRules Models Invariants]
    DATA[Data Layer\nRepositories DAOs Parsers]

    CHAR[Characters Feature]
    COMP[Compendium Feature]
    SET[Settings Feature]

    DB[(Drift SQLite)]
    SRC[(Bundled or Imported XML/JSON Sources)]

    UI --> APP
    APP --> DOMAIN
    APP --> DATA
    DATA --> DB
    DATA --> SRC

    CHAR --> UI
    CHAR --> APP
    CHAR --> DOMAIN
    CHAR --> DATA

    COMP --> UI
    COMP --> APP
    COMP --> DOMAIN
    COMP --> DATA

    SET --> UI
    SET --> APP
    SET --> DOMAIN
    SET --> DATA
```

## Responsibilities

- **Presentation Layer**: declarative rendering, route composition, user intents.
- **Application Layer**: workflow orchestration and transaction-like use cases.
- **Domain Layer**: deterministic gameplay rules and invariant evaluation.
- **Data Layer**: local persistence, compendium import mapping, repository
  implementations.
- **Feature Modules**: keep these layers close to each feature capability,
  avoiding cross-feature rule leakage.
