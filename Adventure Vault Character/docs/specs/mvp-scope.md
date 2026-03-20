# MVP Scope

Status: Draft

## Purpose

Define the first implementation slice of Adventure Vault Character.

## Goals

- Deliver a complete offline-first flow from app launch to a usable character
  sheet.
- Establish the app's startup, access, home, and first character-creation
  experience.
- Use compendium-backed race and class data during guided character creation.

## In Scope

- Splash or bootstrap startup flow
- Local startup loading for config, saved characters, and XML content index
- Access screen with dummy online login and visible `Continuar offline`
- Main menu screen
- Top-level main menu entries for `Compendio`, `Reglas`, and `Settings`
- Character cards for existing local characters
- Always-visible `Crear personaje nuevo` entry point
- Guided create-character flow
- Race selection from compendium data
- Name capture
- Class selection
- Level selection
- Experience entry with automatic level recalculation
- Experience reset to level minimum when level changes
- Progress percentage toward next level
- Character sheet as post-create and post-selection destination
- Local persistence for created characters

## Out of Scope

- Real online authentication
- Sync or cloud-backed user accounts
- Assisted preference-based creation wizard
- Name generator
- Inventory management
- Spell management
- Dice roller
- XML full-content browsing at startup
- Full edit-character flow

## Primary User Flows

### First-Run Offline Flow

1. User opens the app.
2. Splash or bootstrap screen appears.
3. App loads local configuration, saved character summaries, and the XML
   index.
4. Splash remains visible for at least 2 seconds.
5. App routes to the access screen.
6. User chooses `Continuar offline`.
7. App routes to the main menu.
8. User chooses `Crear personaje nuevo`.
9. User completes the guided race, name, class, level, and experience flow.
10. App creates the character locally.
11. App opens the character sheet.

### Returning User Offline Flow

1. User opens the app.
2. App completes splash startup work.
3. User chooses `Continuar offline`.
4. Main menu shows existing character cards.
5. User selects a character card.
6. App opens that character's sheet.

## Acceptance Criteria

- The app is usable end to end without network access.
- Startup always begins with splash or bootstrap.
- Startup loads only the XML index, not the full XML content body.
- `Continuar offline` is visible on the access screen.
- Main menu always shows `Compendio`, `Reglas`, `Settings`, and
  `Crear personaje nuevo`.
- Existing characters appear as cards in the main menu when present.
- Character creation uses compendium-backed race data.
- Class progression, class features, and level thresholds are visible during
  class selection.
- Experience and level stay synchronized.
- Successful creation persists locally and opens the character sheet.

## Dependencies on Architecture Decisions

- `ADR-002`: offline-first operation
- `ADR-006`: Flutter and Dart client baseline
- `ADR-007`: Drift over SQLite local persistence

## Open Questions For Next Session

- Whether any additional creation step is mandatory after race, name, class,
  level, and experience
- What exact data fields must be visible in the first character sheet
- How compendium, rules, and settings should behave inside the MVP shell
