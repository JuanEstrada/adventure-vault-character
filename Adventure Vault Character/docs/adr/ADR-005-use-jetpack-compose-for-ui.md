# ADR-005: Use Jetpack Compose for Android UI

## Status

Accepted

## Context

Adventure Vault Character is being planned as a modern Android application with
an offline-first architecture, modular domain boundaries, and a Kotlin-based
technology stack. The project still has no implementation scaffold, so the UI
approach can be chosen now without migration cost from an existing view system.

The team needs a presentation model that works well with Kotlin, Jetpack,
state-driven screens, and future feature growth across character management,
dice rolling, spells, inventory, and onboarding help.

## Decision

Use Jetpack Compose as the primary UI toolkit for Adventure Vault Character.

## Consequences

Jetpack Compose aligns with the Kotlin-first stack and supports a declarative,
state-driven UI model that fits ViewModel-based Android architecture. It should
speed up iteration on complex player-facing screens and reduce XML-based UI
boilerplate.

The team must standardize Compose patterns for state handling, navigation,
testing, and design consistency. If interoperability with legacy Android views
is ever needed later, that should be treated as an exception rather than the
default UI approach.
