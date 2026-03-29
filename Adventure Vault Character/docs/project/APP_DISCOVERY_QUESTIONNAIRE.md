# App Discovery Snapshot

Operational project summary for AI tools and fast session restarts without
reconstructing app state from scratch.

## Verification Date

- 2026-03-29, aligned with post-normalization `v15` state

## Sources of Truth

- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `docs/project/PROJECT_GUIDELINES.md`

## How To Use This File

- Use it as a short briefing of current product state.
- Use it for quick scope, stack, architecture, and constraints alignment.
- Do not use it as a replacement for ADRs, specs, or architecture docs.

## Current App State

- State: In development
- Current maturity: Partial functional MVP on top of an implemented baseline
- Already working:
  - Offline flow `bootstrap -> access -> main menu`
  - Guided character creation
  - Local character persistence with Drift over SQLite
  - Saved character list
  - Character sheet opening
  - Reopen and edit existing characters
  - Local SRD compendium loading with baseline XML-source support

## Stack

- Frontend: Flutter + Dart
- Backend: No production backend in the current app
- Database: Drift over local SQLite
- Product model: offline-first, with the local device as source of truth

## What Is Already Done

- Feature-first application shell
- Layer separation between `presentation`, `application`, `domain`, and `data`
- Normalized local persistence for characters and compendium in Drift
- MVP flow `create -> save -> card -> open sheet -> edit -> save`
- Shared rules for modifiers, proficiency bonus, progression, and initial hit
  points
- Normalized compendium rule bases in Drift for
  `character advancement` and `standard array by class`
- Normalized official narrative catalogs in Drift for
  `alignment`, `personality traits`, `ideals`, `bonds`, `flaws`, and an initial
  `faction` base
- Baseline migration and core-flow coverage
- Compendium state with dedicated screen, pack management, and baseline XML
  import integrated

## What The Final App Should Include

- Characters: Yes
- Dice rolling: Likely in the future, not finalized as MVP scope
- Spells: Yes
- Inventory: Yes
- Online DM features: No in this app
- Other expected capabilities:
  - Local compendium
  - XML `compendium pack` import
  - Offline SRD rules reference
  - Character sheet with deterministic calculations

## D&D Fidelity Level

- Selection: SRD-accurate behavior
- Note: The project prioritizes rule accuracy, deterministic behavior, and
  traceable calculations over UI simplifications or implementation shortcuts.

## Design

- Selection: Functional minimalism
- Current design status:
  - Functional decisions already exist, such as panel-based sheet layout and
    library-style character cards
  - A final complete visual system is not yet fully closed

## Architecture

- Selection: Already defined
- Current architecture:
  - Offline-first
  - Flutter + Dart
  - Drift over SQLite
  - Feature-first structure
  - Strict separation between `presentation`, `application`, `domain`, and
    `data`
  - Character rules outside widgets and outside persistence implementations

## Margin For Code Changes

- Selection: Improve
- Meaning in this project:
  - Refactoring is allowed to improve clarity, extensibility, and separation of
    responsibilities
  - Do not rebuild core foundations without need or break accepted decisions
- Constraints:
  - Respect current architecture and accepted ADRs
  - Maintain layer separation
  - Do not move rules logic into widgets
  - Do not couple domain rules to Drift or Flutter UI

## Documentation And Tests

- Selection: Yes
- Current expectation:
  - Keep `SESSION_RESUME.md` and `PROJECT_SNAPSHOT.md` up to date
  - Update specs, architecture docs, or ADRs when behavior or structure changes
  - Add or update tests when rules, persistence, or meaningful flows change

## Where This Prompt Is Used

- Selection: Codex
- Primary audience for this document: fast context for AI sessions

## Key Constraints That Must Not Break

- Rule accuracy has priority over UI convenience
- Core player functions must work offline
- The local device is the source of truth for character state
- The player app and future DM app are separate products
- Domain logic must remain deterministic and testable

## Expected Next Focus Areas

- Extend editing beyond the current guided MVP fields
- Increase compendium fidelity from local XML sources
- Formalize more character rules through deterministic domain contracts and
  services
- Continue expanding narrative and spell rules for advanced cases
- Populate sheet areas that are still MVP-level or partial

## Limits Of This Document

- It does not replace `docs/specs/`
- It does not replace `docs/adr/`
- It does not define detailed implementation contracts
- It is a short verified snapshot, not a full specification
