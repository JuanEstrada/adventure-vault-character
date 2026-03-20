# Adventure Vault Character - Roadmap

## Purpose

This roadmap organizes delivery around the application lifecycle and the
player-facing screens that must exist from app boot to app exit. It is meant
to guide implementation planning, navigation design, and future screen-level
specifications.

## Planning Principle

The roadmap is ordered by usable end-to-end flows, not only by technical
capabilities. Each phase should leave the app in a more coherent state from
startup, through interaction, to backgrounding and closure.

## Phase 0 - Application Lifecycle Baseline

Goal: make the app start, initialize, route, and close predictably.

### Screens and Flows

- Splash or bootstrap screen
- Startup dependency initialization
- Local configuration load
- Saved character summary load
- XML content index load without full content preload
- Access screen after splash
- App resume from background
- App close and state persistence

### Expected Outcomes

- The app launches into a deterministic first screen.
- Initialization failures have a visible recovery path.
- Session state survives app pause, resume, and close.
- Navigation entry rules are documented before feature expansion.

## Phase 1 - First Playable Shell

Goal: let a player open the app, understand what it is for, and reach a
useful first screen even before deep gameplay features exist.

### Screens and Flows

- Access screen with dummy online login
- Continue offline action
- Main menu or home hub
- Top menu entries for compendium, rules, and settings
- Character cards in the main menu
- Always-visible create character entry point
- Basic character detail shell

### Expected Outcomes

- A new user can understand the first available action immediately.
- A returning user can find existing characters quickly.
- The app has a clear home hub for subsequent milestones.

## Phase 2 - Character Creation and Core Data

Goal: support creation and editing of a valid character record.

### Screens and Flows

- Guided character creation flow
- Race selection from compendium data
- Background selection from compendium data
- Name entry
- Ability score method selection and assignment
- Class selection
- Level and experience synchronization
- Class progression table and feature preview
- Save or cancel flow
- Edit existing character flow

### Expected Outcomes

- Characters can be created, stored locally, reopened, and updated.
- Validation rules exist for required fields and invalid values.
- Character creation and editing boundaries are documented screen by screen.
- Background-derived player-facing information is preserved and surfaced in
  the character sheet.
- Ability score choices are captured in a way that preserves both final values
  and the selected creation method.
- Progression rules are explicit during class and level selection.

## Phase 3 - Character Sheet and Session Use

Goal: support the primary in-session experience once a character exists.

### Screens and Flows

- Character sheet overview
- Background summary with bonuses and social perks
- Ability score block with final values and modifiers
- Derived combat values section
- Skills and saving throws view
- Hit points and temporary state updates
- Notes or lightweight session annotations

### Expected Outcomes

- The player can open a character and use core information during play.
- Derived values are presented consistently.
- The main in-session screen becomes the functional center of the app.

## Phase 4 - Action and Utility Screens

Goal: support common gameplay interactions without leaving the app flow.

### Screens and Flows

- Dice roller screen or panel
- Roll result presentation
- Quick actions for common checks
- Roll history or recent actions
- Shortcut navigation from character sheet to utility tools

### Expected Outcomes

- Dice interactions are fast enough for live session use.
- Action-oriented screens feel connected to the character context.
- Utility flows do not fragment the main navigation experience.

## Phase 5 - Inventory, Spells, and Character Resources

Goal: expand the character toward real tabletop session support.

### Screens and Flows

- Inventory list screen
- Inventory item detail or edit flow
- Spell list screen
- Spell slot or usage tracking
- Feature, trait, or resource tracking views

### Expected Outcomes

- Core session resources are available offline from the character context.
- Inventory and spell interactions follow the same navigation model as the
  rest of the app.
- Resource-heavy screens remain usable and comprehensible.

## Phase 6 - Import and Structured Content

Goal: allow controlled ingestion of external content into the local app model.

### Screens and Flows

- Import entry screen
- File selection or import source flow
- Validation progress screen
- Import result summary
- Import error state and recovery path

### Expected Outcomes

- Import workflows are explicit and auditable.
- XML or structured content errors are visible and actionable.
- Imported content fits the offline-first local model cleanly.

## Phase 7 - Quality, Recovery, and Lifecycle Completion

Goal: close the loop on app lifecycle quality after the primary screens exist.

### Screens and Flows

- Global error and recovery states
- Corrupted local data fallback path
- Settings or local app preferences
- Background resume behavior review
- Exit consistency and pending-write protection

### Expected Outcomes

- The app behaves predictably across interruptions and recovery scenarios.
- Error states are documented as first-class screens or routes.
- The user can leave and re-enter the app without losing expected progress.

## Phase 8 - Ecosystem Expansion Readiness

Goal: prepare the player app for future scope without breaking current
screen boundaries.

### Screens and Flows

- Future sync or account boundary review
- Future Adventure Vault Master integration touchpoints
- Homebrew or content-management expansion review
- Optional help or onboarding overlays for new players

### Expected Outcomes

- Screen boundaries remain stable as the product grows.
- Future integrations do not leak into current MVP flows prematurely.
- Expansion work can build on documented routes and states instead of
  redefining them.

## Cross-Cutting Documentation Rules

Every new screen spec added under `docs/specs/` should eventually document:

- Screen purpose
- Entry conditions
- Exit paths
- Primary actions
- Required data
- UI states: loading, empty, error, success
- Dependencies on navigation, persistence, and domain rules

## Suggested Next Documentation Steps

1. Confirm the exact persisted and displayed shape of background and ability
   score data in the first character model and character sheet.
2. Define the first character sheet contents in detail.
3. Add or refine screen specs around access, main menu, and guided creation.
4. Keep this roadmap aligned with `PROJECT_SNAPSHOT.md` and the MVP scope.

## Current Priority

Phase 0 - Application Lifecycle Baseline
then
Phase 1 - First Playable Shell
