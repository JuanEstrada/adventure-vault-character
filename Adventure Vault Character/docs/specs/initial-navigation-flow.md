# Initial Navigation Flow Specification

## Status

Draft

## Summary

This specification defines the canonical first-run and returning-user
navigation flow from app launch until the user reaches a stable destination
screen. It ties together splash/bootstrap, access, main menu, create
character, and character sheet behavior.

## Goals

- Define a single authoritative early navigation flow.
- Remove ambiguity about which screen appears first in each startup case.
- Ensure first-run and returning-user states are handled explicitly.
- Preserve a future-facing login placeholder without blocking offline use.

## In Scope

- Cold-start route order
- Transition rules between bootstrap, access, main menu, create character,
  and character sheet
- Basic failure routing during startup

## Out of Scope

- Deep links
- External navigation intents
- Settings, import, or advanced feature routes
- Background multi-window behavior

## Route Rules

- App launch always enters the bootstrap screen first.
- Bootstrap loads local config, saved character summaries, and the XML index.
- Bootstrap remains visible for at least 2 seconds and longer if startup work
  is still running.
- If initialization fails, the app stays in a startup recovery state.
- If initialization succeeds, route to the access screen.
- The access screen shows a dummy online login plus `Continuar offline`.
- Choosing `Continuar offline` routes to the main menu.
- The main menu always shows `Compendio`, `Reglas`, and `Settings` in the
  upper area.
- The main menu always shows `Crear personaje nuevo`.
- If characters exist, the main menu also shows character cards.
- If the user selects a character card, route to that character sheet.
- If the user creates a character successfully, route to the new character
  sheet.

## Canonical Flows

### First-Run Flow

1. App launch
2. Bootstrap
3. Access screen
4. Continue offline
5. Main menu
6. Create character
7. Character sheet

### Returning User Flow

1. App launch
2. Bootstrap
3. Access screen
4. Continue offline
5. Main menu
6. Character sheet

### Startup Failure Flow

1. App launch
2. Bootstrap
3. Startup recovery state
4. Retry
5. Resume normal route selection

## Acceptance Criteria

- The initial route sequence is documented and deterministic.
- First-run and returning-user cases do not share ambiguous route logic.
- Bootstrap owns startup decisions, not downstream feature screens.
- Access screen preserves offline continuation as the supported MVP path.
- Character creation success transitions directly into a stable post-create
  destination.

## Architectural Notes

- This flow is the navigation baseline for the early Flutter app shell.
- The navigation coordinator should own route transitions while using app
  state provided by initialization and local persistence layers.
- This document should remain aligned with the related screen specs in
  `docs/specs/`.
- Related roadmap phases: Phase 0, Phase 1, and Phase 2 in
  `docs/project/ROADMAP.md`.
