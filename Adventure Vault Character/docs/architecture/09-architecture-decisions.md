# 09. Architecture Decisions

The following ADRs capture the initial architectural decisions for Adventure
Vault Character:

| ADR | Summary |
| --- | --- |
| [ADR-001](../adr/ADR-001-use-kotlin-for-android.md) | Kotlin is the primary Android language. |
| [ADR-002](../adr/ADR-002-offline-first-architecture.md) | Local data and local business logic remain authoritative. |
| [ADR-003](../adr/ADR-003-use-room-database.md) | Room over SQLite is the local persistence strategy. |
| [ADR-004](../adr/ADR-004-separate-player-and-dm-apps.md) | Player and DM products stay as separate applications. |
| [ADR-005](../adr/ADR-005-use-jetpack-compose-for-ui.md) | Jetpack Compose is the default UI toolkit. |

These decisions establish the implementation language, local-first operating
model, persistence strategy, UI approach, and application boundary between the
player and future DM products. See the full decision log in
[../adr/README.md](../adr/README.md).
