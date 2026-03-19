# ADR-006: Use Flutter for the Client Application

## Status

Accepted

## Context

Adventure Vault Character is still in the planning stage and no application
source tree has been scaffolded yet. The project needs a modern client
framework that supports a fast implementation loop, declarative UI, and future
platform flexibility without compromising the current Android-first delivery
plan.

The product remains offline-first, keeps player and DM applications separate,
and requires a maintainable structure for complex character management, dice,
inventory, spells, and imported rules content.

## Decision

Use Flutter as the primary client application framework for Adventure Vault
Character, with Dart as the implementation language.

The initial delivery target remains Android, but the client architecture should
avoid unnecessary coupling to Android-only presentation patterns when Flutter
abstractions are sufficient.

## Consequences

Flutter becomes the default UI and application framework baseline for the
project. Widget-based UI, route handling, and screen state management should be
designed around Flutter conventions.

Rules logic must remain outside widgets and other purely visual layers. Android
platform capabilities should be accessed through plugins or platform
integration seams only where needed.

This decision supersedes the prior Kotlin-native and Jetpack Compose-specific
direction captured in ADR-001 and ADR-005.
