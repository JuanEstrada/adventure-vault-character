# ADR-004: Separate Player and Dungeon Master Applications

## Status

Accepted

## Context

Adventure Vault includes both a player-facing application and a future Dungeon Master application. The player application must be useful on its own today while still allowing future interaction with the DM side.

## Decision

Treat Adventure Vault Character and Adventure Vault Master as separate applications with explicit integration boundaries.

## Consequences

Adventure Vault Character can evolve independently around player workflows and offline usage. Future collaboration between the applications will require stable contracts for synchronization or real-time exchange rather than assuming one shared monolithic architecture.
