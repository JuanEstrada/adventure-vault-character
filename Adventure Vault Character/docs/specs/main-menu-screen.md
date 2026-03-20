# Main Menu Screen Specification

## Status

Draft

## Summary

The main menu screen is the central hub of the MVP. It is reached after the
user chooses to continue offline and provides top-level access to compendium,
rules, settings, existing character cards, and character creation.

## Goals

- Establish a stable home screen for the app.
- Surface both content navigation and player-character entry points.
- Keep character access and character creation visible at all times.

## In Scope

- Top-level menu actions for compendium, rules, and settings
- Character cards for existing local characters
- Persistent `Crear personaje nuevo` entry point
- Navigation to character sheet from character cards

## Out of Scope

- Detailed compendium browsing behavior
- Rules reference internals
- Settings subflows
- Character sorting and filtering beyond simple defaults

## Entry Conditions

- The user chooses `Continuar offline` from the access screen.
- The user returns from a character screen or creation flow.

## Exit Paths

- Open character sheet from a character card
- Open create character guided flow
- Open future compendium, rules, or settings screens

## Primary Actions

- Open an existing character
- Create a new character
- Enter compendium
- Enter rules
- Enter settings

## Required Data

- Local list of character summaries for card display
- Top-level navigation actions

## UI States

- Populated: one or more character cards plus create action
- No characters yet: create action remains visible
- Error: local character summaries could not be loaded

## Acceptance Criteria

- `Compendio`, `Reglas`, and `Settings` are visible in the upper section of
  the screen.
- `Crear personaje nuevo` is always visible, even when characters already
  exist.
- Tapping a character card opens that character's sheet directly.
- The screen works fully offline.

## Architectural Notes

- This screen supersedes the earlier idea of a plain character list as the app
  home.
- Character cards should use summary data produced by application boundaries,
  not raw persistence entities.
- Related roadmap phases: Phase 1 and Phase 2 in
  `docs/project/ROADMAP.md`.
