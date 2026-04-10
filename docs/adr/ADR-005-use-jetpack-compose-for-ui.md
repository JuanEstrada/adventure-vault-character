# ADR-005: Use Jetpack Compose for Android UI

## Status

Superseded by [ADR-006](ADR-006-use-flutter-for-client-application.md)

## Context

Adventure Vault Character originally targeted a native Android presentation
stack and needed a declarative UI approach that worked well with Kotlin,
state-driven screens, and future feature growth.

## Decision

Use Jetpack Compose as the primary UI toolkit for Adventure Vault Character.

## Consequences

This decision established the first UI baseline for the project. It is kept as
historical context, but Flutter is now the active UI and application framework
direction.
