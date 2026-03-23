# Specifications Index

This directory contains implementation-facing product specifications.

## Purpose

Use `docs/specs/` for accepted or actively planned requirements that sit
between high-level architecture and the roadmap.

## Current Specs

- [MVP Scope](mvp-scope.md): initial delivery boundary for the first
  implementation slice.
- [Bootstrap Screen](bootstrap-screen.md): startup screen, initialization
  rules, preload behavior, and splash timing.
- [Access Screen](access-screen.md): dummy online login plus supported offline
  continuation path.
- [Main Menu Screen](main-menu-screen.md): central home hub with top menus,
  character cards, and create entry.
- [Character List Screen](character-list-screen.md): earlier list-focused spec
  retained as reference while the main menu hub replaces it.
- [Empty State Screen](empty-state-screen.md): no-data entry point for first
  use and zero-character states. Retained as reference while main menu is now
  the primary hub.
- [Create Character Screen](create-character-screen.md): minimum viable
  character creation flow.
- [Character Card](character-card.md): proposed main-menu summary card for
  saved characters and the bridge into the character sheet.
- [Character Sheet Screen](character-sheet-screen.md): main post-creation and
  post-selection character destination.
- [First Character Sheet Contents](first-character-sheet-contents.md):
  proposed exact minimum contents for the first usable character sheet.
- [Initial Character Domain Model](initial-character-domain-model.md):
  proposed first character aggregate, ability score model, equipment model,
  and persistence boundaries for MVP implementation.
- [Initial Navigation Flow](initial-navigation-flow.md): canonical route flow
  from app launch to stable destination screens.
- [Feature Template](feature-template.md): structure for future feature specs.

## Usage Rules

- Put accepted or in-planning specs here.
- Keep deferred ideas in [../project/FUTURE_SPECS.md](../project/FUTURE_SPECS.md).
- Link architecture-impacting changes back to ADRs when needed.
