# MVP Scope

Status: Draft

## Purpose

Define the first implementation slice of Adventure Vault Character.

## Goals

- Deliver a complete offline-first flow from app launch to a usable character
  sheet.
- Establish the app's startup, access, home, and first character-creation
  experience.
- Use compendium-backed race, background, and class data during guided
  character creation.
- Support guided ability score determination before the first save.

## In Scope

- Splash or bootstrap startup flow
- Local startup loading for config, saved characters, and XML content index
- Access screen with dummy online login and visible `Continuar offline`
- Main menu screen
- Top-level main menu entries for `Compendio`, `Reglas`, and `Settings`
- Character cards for existing local characters
- Always-visible `Crear personaje nuevo` entry point
- Guided create-character flow
- Character builder overview with XML load action
- Race selection from compendium data
- Background selection from compendium data
- Name capture
- Ability score determination
- Generated score-set assignment
- Manual point allocation with visible remaining budget
- Class selection
- Level selection
- Experience entry with automatic level recalculation
- Equipment selection after class and progression selection
- Starting money setup for equipment purchasing
- Compendium-backed equipment item selection
- Quantity and cost confirmation for equipment purchasing
- Final finishing-details step before save
- Experience reset to level minimum when level changes
- Progress percentage toward next level
- Hit points visible on the character sheet
- Background bonuses and social perks visible on the character sheet
- Final ability scores visible on the character sheet
- Character sheet as post-create and post-selection destination
- Local persistence for created characters
- XML load entry point exposed from the builder overview

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
9. App shows the builder overview with creation sections and a visible XML
   load action.
10. The XML load action exists as a documented entry point, but full import
    behavior is not required for MVP completion.
11. User completes the guided race, name, background, ability score,
    class, level, experience, equipment, and finishing-details flow.
12. App creates the character locally.
13. App opens the character sheet, including background information relevant
    to play and the final ability score block.

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
- The builder entry exposes a visible XML load action from its overview
  screen.
- The visible XML load action does not require full MVP XML import support.
- Existing characters appear as cards in the main menu when present.
- Character creation uses compendium-backed race data.
- Character creation uses compendium-backed background data.
- Character creation requires a complete ability score assignment.
- The MVP ability score step supports generated set assignment and manual
  point allocation with visible remaining points.
- After ability scores are accepted, the guided flow continues into class and
  progression selection before equipment completion.
- The equipment step shows available money, item-category selection, and
  quantity-and-cost confirmation for chosen equipment.
- After class and progression selection, the guided flow continues into a
  final finishing-details step before save.
- The finalize action validates `Race + name`, `Background`,
  `Ability scores`, and `Class / level / experience`, and blocks save if any
  are incomplete.
- Finalizing from finishing details persists the character and makes it appear
  in the main-menu character cards.
- Class progression, class features, and level thresholds are visible during
  class selection.
- Experience and level stay synchronized.
- The character sheet shows current, maximum, and temporary hit points.
- The character sheet shows the selected background plus its bonuses and
  social perks.
- The character sheet shows the six final ability scores.
- Successful creation persists locally and opens the character sheet.

## Dependencies on Architecture Decisions

- `ADR-002`: offline-first operation
- `ADR-006`: Flutter and Dart client baseline
- `ADR-007`: Drift over SQLite local persistence

## Implementation Follow-Up

- Confirm the first Drift schema from the proposed character model.
- Confirm package and module boundaries for `lib/`.
- Define application services and mappers for creation, card summaries, and
  character-sheet rendering.
- Decide when XML import moves from documented entry point to implemented
  import flow.
