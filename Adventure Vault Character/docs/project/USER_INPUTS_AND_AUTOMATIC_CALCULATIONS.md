# User Inputs And Automatic Calculations

Quick reference for what the app calculates automatically versus what the user
must enter, choose, or confirm.

## Verification Date

- 2026-03-29, aligned with post-normalization `v15` state

## Sources of Truth

- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `docs/specs/create-character-screen.md`
- `docs/specs/character-sheet-screen.md`
- `docs/specs/first-character-sheet-contents.md`
- `docs/project/ROADMAP.md`

## How To Read This Document

- `Current`: behavior already supported by the current repository state
- `Expected future`: documented direction in roadmap or future specs
- `Not automated`: behavior the app does not yet automate

## What The App Calculates Automatically

### Current

- Ability score modifier from final `Strength`, `Dexterity`, `Constitution`,
  `Intelligence`, `Wisdom`, and `Charisma`
- `Proficiency bonus` from level
- Progress to next level from level and experience
- Level when the user changes experience during character creation
- Minimum required experience when the user manually changes level
- Initial hit points from class, level, and Constitution
- Maximum hit points recalculation during edits when class, level, or
  Constitution changes
- `Standard Array by Class` recommendation when class changes and the active
  method is `generated set assignment`
- Loading and local persistence of normalized official rule bases for
  `character advancement` and `standard array by class`
- Loading and local persistence of normalized official narrative catalogs for
  `alignment`, `personality traits`, `ideals`, `bonds`, `flaws`, and an initial
  `faction` base, used by visible `empty / rolled / manual` modes
- Required-section validation before save:
  `Race + name`, `Background`, `Ability scores`,
  `Class / level / experience`
- Sheet-visible derived summaries such as ability method label, level progress,
  and visible equipment composition when applicable
- Deterministic spell-slot progression for currently supported caster classes,
  including sheet-visible remaining-slot summaries
- Simplified class-based limits for selected spell count in currently supported
  standard caster classes

### Expected Future

- Dice utilities and roll outcomes connected to character context
- Richer inventory, spell, and character-resource summaries
- Broader management of active/inactive compendium packs
- Richer narrative-field coverage (more sources, contextual rules, and advanced
  UX) in `finishing details`
- Special-case models such as `warlock` pact magic and full separation between
  spellbook and prepared spells for `wizard`

### Not Automated Today

- Full attack calculation
- Complete spellcasting special cases, rest recovery behavior, and limits
  beyond the current simplified spell-selection model
- Full Armor Class, initiative, and advanced combat as a complete subsystem
- Complete inventory rules beyond MVP starter-equipment flow
- Full automation for class resources, traits, or rest-based consumption

## What The User Must Enter Or Confirm

### Current

- Character name
- Race selected from compendium
- Background selected from compendium
- Class selected from compendium
- Initial level or initial experience
- Ability-score method
- Final assignment of the six ability scores
- Selected starter equipment
- Purchasable-item quantities when applicable
- Total cost confirmation against available funds during purchases
- Optional `portrait` free text/field
- Optional `appearance` free text/field
- Per-field narrative selections in `empty / rolled / manual` for
  `alignment`, `faction`, `personality traits`, `ideals`, `bonds`, and `flaws`
- Optional `narrative details` free-form note when the user wants it
- Spell selection and current spell-slot usage for supported caster classes
- Final confirmation that selected spells fit the visible derived limit for
  current class, level, and casting ability

### Expected Future

- Manual rolls or player-started dice actions from a dedicated dice surface
- Detailed inventory adjustments
- Deeper spell and resource management
- Optional compendium-pack selection in richer content-selector flows

## What Syncs Automatically When Data Changes

- If experience changes, the app recalculates level using defined thresholds
- If level changes, the app resets experience to minimum required for that
  level
- If class changes and ability method is `generated set assignment`, the visible
  array recommendation updates
- If class, level, or Constitution changes during editing, the app recomputes
  maximum HP and preserves current HP when possible
- Narrative `finishing details` fields resolve via roll or manual selection
  using normalized official catalogs
- If class or level changes in a supported caster class, the app trims spells
  above currently castable level and adjusts slot usage to the new derived max
- If class, level, or casting ability changes in a supported caster class, the
  app recalculates selected-spell limit and trims overflow deterministically
- The character sheet reuses domain-derived values instead of recalculating
  inside widgets

## Boundary Rules

- A visible value on screen does not imply user-entered data
- A persisted value does not automatically mean canonical or non-derived
- Calculations must live in `domain` or `application`, not in widgets
- Persistence should not store avoidable derived values when they can be
  recomputed from canonical state

## Short View By Category

### Calculated by the App

- Ability modifiers
- Proficiency bonus
- Level progress
- `level <-> experience` synchronization
- Initial HP and edit-time maximum HP recomputation
- Class-based standard-array recommendation
- Local loading of official narrative and progression catalogs
- Required-section validation

### Entered or Confirmed by the User

- Character identity
- Race, background, and class
- Initial experience or level
- Ability-score method
- Final ability values
- Starter equipment and purchases
- Optional `portrait` and `appearance` free-form details
- Narrative selections and optional narrative notes

## Finishing Details Clarification

- The repository includes normalized official bases for
  `alignment`, `faction`, `personality traits`, `ideals`, `bonds`, and `flaws`
- The visible flow supports full per-field `empty / rolled / manual` selection
  and persists/reopens that state
- Remaining work targets advanced UX and special-case behavior, not baseline
  UI/domain integration

## Limits Of This Document

- It does not replace screen or domain specs
- It does not define persistence/API implementation contracts
- It does not promise automation not approved by roadmap or specs
- It is a quick reference for AI sessions and project alignment
