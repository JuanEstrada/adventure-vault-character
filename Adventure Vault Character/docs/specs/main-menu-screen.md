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
- Read-only summary of the active compendium source policy
- Character cards for existing local characters
- Persistent `Crear personaje nuevo` entry point
- Navigation to character sheet from character cards
- Entry into character import from XML through the builder flow

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
- Open load-character-from-XML flow from the builder entry
- Open future compendium, rules, or settings screens

## Primary Actions

- Open an existing character
- Create a new character
- Start character loading from XML
- Enter compendium
- Enter rules
- Enter settings

## Required Data

- Local list of character summaries for card display
- Top-level navigation actions

Character cards should use summary data defined by the character-card
specification, not full character-detail payloads.

## UI States

- Populated: one or more character cards plus create action
- No characters yet: create action remains visible
- Error: local character summaries could not be loaded

## Acceptance Criteria

- `Compendio`, `Reglas`, and `Settings` are visible in the upper section of
  the screen.
- The screen shows which compendium source policy is active, including whether
  the app is running from the FightClub XML bundle or the bundled JSON
  fallback.
- `Crear personaje nuevo` is always visible, even when characters already
  exist.
- Tapping a character card opens that character's sheet directly.
- Character cards show the minimum saved-character summary needed for quick
  recognition.
- The create-character entry leads to a builder overview that exposes a
  visible XML load action.
- The XML load action may exist as a documented entry point before full XML
  import behavior is implemented.
- The screen works fully offline.

## Architectural Notes

- This screen supersedes the earlier idea of a plain character list as the app
  home.
- Character cards should use summary data produced by application boundaries,
  not raw persistence entities.
- Character-card details should stay aligned with
  `docs/specs/character-card.md`.
- Related roadmap phases: Phase 1 and Phase 2 in
  `docs/project/ROADMAP.md`.
