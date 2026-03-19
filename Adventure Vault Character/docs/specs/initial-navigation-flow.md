# Initial Navigation Flow Specification

## Status

Draft

## Summary

This specification defines the canonical first-run and returning-user
navigation flow from app launch until the user reaches a stable destination
screen. It ties together bootstrap, empty state, character list, create
character, and character sheet behavior.

## Goals

- Define a single authoritative early navigation flow.
- Remove ambiguity about which screen appears first in each startup case.
- Ensure first-run and returning-user states are handled explicitly.

## In Scope

- Cold-start route order
- Route decisions based on local data presence
- Transition rules between bootstrap, empty state, character list, create
  character, and character sheet
- Basic failure routing during startup

## Out of Scope

- Deep links
- External navigation intents
- Settings, import, or advanced feature routes
- Background multi-window behavior

## Route Rules

- App launch always enters the bootstrap screen first.
- If initialization fails, the app stays in a startup recovery state.
- If initialization succeeds and no local characters exist, route to the
  empty-state screen.
- If initialization succeeds and local characters exist, route to the
  character list screen.
- If the user creates a character successfully, route to the new character
  sheet.
- If the user selects a character from the list, route to that character
  sheet.

## Canonical Flows

### First-Run Flow

1. App launch
2. Bootstrap
3. Empty state
4. Create character
5. Character sheet

### Returning User Flow

1. App launch
2. Bootstrap
3. Character list
4. Character sheet

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
