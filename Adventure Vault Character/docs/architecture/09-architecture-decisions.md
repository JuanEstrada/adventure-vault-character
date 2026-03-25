# 09. Architecture Decisions

The following ADRs capture the active architectural decisions for Adventure
Vault Character:

| ADR | Summary |
| --- | --- |
| [ADR-002](../adr/ADR-002-offline-first-architecture.md) | Local data and local business logic remain authoritative. |
| [ADR-004](../adr/ADR-004-separate-player-and-dm-apps.md) | Player and DM products stay as separate applications. |
| [ADR-006](../adr/ADR-006-use-flutter-for-client-application.md) | Flutter and Dart are the client application baseline. |
| [ADR-007](../adr/ADR-007-use-drift-for-local-persistence.md) | Drift over SQLite is the local persistence strategy. |
| [ADR-008](../adr/ADR-008-use-compendium-and-compendium-import-system-terminology.md) | Compendio and Compendium Import System are the standard terms for imported rules content and XML ingestion. |

These decisions establish the implementation framework, local-first operating
model, persistence strategy, and application boundary between the player and
future DM products. Historical ADRs remain available in
[../adr/README.md](../adr/README.md).
