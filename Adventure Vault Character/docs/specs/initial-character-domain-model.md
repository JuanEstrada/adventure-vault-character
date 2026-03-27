# Initial Character Domain Model

## Status

Proposed

## Purpose

Define the first implementation-oriented domain model for MVP character
creation, local persistence, and character-sheet rendering.

This document translates the accepted MVP field set into stable domain
boundaries that can be implemented in Dart and persisted through Drift without
placing rule logic inside widgets.

## Scope

This specification defines:

- the first character aggregate for MVP
- ability score modeling and provenance
- background output modeling
- equipment purchase and owned-item modeling
- finishing-details modeling
- minimum persistence-oriented boundaries

This specification does not define:

- full inventory behavior after creation
- combat automation
- spell systems
- edit-history or audit logging beyond MVP provenance
- final Drift table syntax

## Design Constraints

- The local device is the source of truth.
- The first persisted model must support fully offline creation and viewing.
- Domain entities must preserve rule-relevant meaning, not only display text.
- View models must be mapped from domain or application-layer outputs.
- Widgets must not compute rule logic ad hoc.

## Domain Boundary

For MVP, character creation and character viewing should revolve around a
single aggregate root:

- `Character`

The aggregate is responsible for owning the minimum data required to:

- validate a newly created character
- persist the created record locally
- render the first character sheet
- reopen the character later without external dependencies beyond local
  compendium references

## Character Aggregate

The first `Character` aggregate should contain:

- `id`
- `name`
- `race`
- `background`
- `abilityScores`
- `hitPoints`
- `equipment`
- `classProgression`
- `finishingDetails`
- `createdAt`
- `updatedAt`

The aggregate should be considered valid for MVP only when all required
creation steps are complete.

## Character Identity

Minimum fields:

- `CharacterId`
- `CharacterName`

Rules:

- `id` is a stable local identifier.
- `name` is required before save.

## Race Reference

The first race model should be reference-based, not a full embedded compendium
copy.

Minimum fields:

- `raceId`
- `displayName`

Rules:

- `raceId` links back to compendium-backed content.
- `displayName` is denormalized for resilient local rendering and list views.

## Background Model

The background model must preserve both compendium identity and the player-
facing outputs required later by the character sheet.

Minimum fields:

- `backgroundId`
- `displayName`
- `summaryText`
- `bonuses`
- `socialPerks`

### Background Bonus Item

Minimum fields:

- `id`
- `label`
- `description`

### Background Social Perk Item

Minimum fields:

- `id`
- `label`
- `description`

Rules:

- `bonuses` and `socialPerks` remain separate collections.
- The stored shape should preserve enough structured data to render later
  without reparsing raw compendium text.
- The background model should not collapse into one free-form note field.

## Ability Score Model

The ability score model should separate:

- final per-ability results
- selected generation method
- method-specific provenance

Minimum root fields:

- `method`
- `strength`
- `dexterity`
- `constitution`
- `intelligence`
- `wisdom`
- `charisma`
- `provenance`

### Ability Score Entry

Each of the six stored ability entries should support:

- `ability`
- `score`

The final modifier should be derived outside widgets from the final score
unless there is a later persistence reason to store it explicitly.

### Supported Method Enum

The MVP method set should be:

- `generatedSetAssignment`
- `manualPointAllocation`

### Generated Set Assignment Provenance

Minimum fields:

- `sourceSet`
- `assignedScores`

Rules:

- `sourceSet` stores the generated or otherwise provided set offered to the
  player.
- `assignedScores` stores which source values ended up in each ability slot.

### Manual Point Allocation Provenance

Minimum fields:

- `assignedScores`
- `pointsBudget`
- `pointsSpent`
- `pointsRemaining`

Rules:

- the model must preserve enough state to validate the chosen values later
- the persisted shape must keep the six final assigned values even if budget
  values are also stored

## Equipment Model

The first equipment model is not full inventory management. It exists to
capture the equipment selected during creation in a way that can later expand
into inventory without discarding MVP data.

Minimum root fields:

- `startingMoney`
- `moneySpent`
- `moneyRemaining`
- `entries`

### Starting Money

Minimum fields:

- `amount`
- `currency`
- `source`

Rules:

- `source` captures how starting money was obtained for the creation flow
  such as roll-derived money or an equivalent standardized source.

### Equipment Entry

Each selected item should preserve:

- `itemId`
- `displayName`
- `category`
- `quantity`
- `unitCost`
- `totalCost`
- `ownershipState`

### Equipment Category Enum

The first category set should support at least:

- `armor`
- `weapon`
- `gear`
- `equipmentPack`
- `other`

### Ownership State

Minimum enum values:

- `owned`
- `notOwned`

Rules:

- The equipment summary screen can use ownership state to reflect whether a
  currently viewed item is already part of the selected loadout.
- MVP equipment data should support category summaries and later expansion
  into richer inventory state.

## Hit Points Model

The first hit-points model must support real MVP rendering and persistence for
the combat panel.

Minimum fields:

- `current`
- `maximum`
- `temporary`

Rules:

- current hit points must persist across app reopen
- temporary hit points must persist across app reopen
- maximum hit points must be available for character-sheet rendering
- deeper combat state can remain outside MVP

## Class Progression Model

For MVP, class and level data can remain intentionally compact while still
supporting the create-character and first character-sheet flows.

Minimum fields:

- `classId`
- `displayName`
- `level`
- `experience`

Derived values needed by application or domain services:

- `proficiencyBonus`
- `levelProgress`

Rules:

- `classId` points to compendium-backed class data.
- `displayName` is denormalized for resilient local rendering.
- `level` and `experience` must remain synchronized through domain rules.

## Finishing Details Model

The finishing-details model captures optional appearance and narrative fields
entered at the end of character creation.

Minimum fields:

- `portraitRef`
- `appearance`
- `characteristics`

### Portrait Reference

Minimum fields:

- `localAssetPath`

Rules:

- portrait support is optional for MVP
- the model should allow no portrait without invalidating the character

### Appearance

Minimum optional fields:

- `age`
- `height`
- `weight`
- `eyes`
- `skin`
- `hair`

### Characteristics

Minimum optional fields:

- `alignment`
- `faction`
- `personalityTraits`
- `ideals`
- `bonds`
- `flaws`

### Narrative Characteristic Selection

For `alignment`, `faction`, `personalityTraits`, `ideals`, `bonds`, and
`flaws`, the model should preserve not only the final optional value but also
how that value was chosen.

Minimum fields per narrative characteristic:

- `value`
- `selectionMode`
- `officialOptionsRef`

### Narrative Characteristic Selection Mode

Minimum enum values:

- `empty`
- `rolled`
- `manual`

Rules:

- `empty` means the user either left the field blank or entered no custom
  value.
- `rolled` means the app resolved the final value from the official options
  available for that field.
- `manual` means the user picked one value from the official options available
  for that field.
- `officialOptionsRef` should preserve a stable reference to the official
  option source used for roll or manual selection when applicable.

Rules:

- finishing details are optional and should not block character creation
- `portraitRef` and `appearance` remain optional free-entry fields
- the narrative characteristic fields support both free-entry and official-
  option selection paths through their selection mode
- the model should support later display on richer character-detail screens

## Aggregate Invariants

The first character aggregate should enforce these invariants:

- `name` is not empty
- a race is selected
- a background is selected
- all six final ability scores exist
- exactly one supported ability score method is selected
- the ability score provenance matches the selected method
- hit-point values are internally consistent
- equipment money values are internally consistent
- selected equipment entries do not exceed available money
- a class is selected
- level is valid for the chosen experience

## Suggested Persistence Boundary

The first persisted shape should avoid a single giant opaque JSON blob for the
entire character if that would erase queryable structure. At minimum, the
storage design should keep the top-level character record separate from the
most volatile substructures.

Suggested persistence groups:

- `characters`
- `character_background_outputs`
- `character_ability_scores`
- `character_equipment_entries`
- `character_finishing_details`

Optional compact persistence for MVP:

- method-specific provenance may be stored as structured JSON if Drift table
  complexity would otherwise slow implementation, provided the top-level
  character and its primary queryable fields remain explicit

## Suggested Application Services

The first implementation slice will likely need these services or equivalent
use cases:

- `CreateCharacter`
- `ValidateCharacterDraft`
- `CalculateAbilityModifier`
- `SynchronizeLevelAndExperience`
- `CalculateLevelProgress`
- `SummarizeCharacterForSheet`

## Draft Creation State

Before persistence, the guided flow should use a draft model distinct from the
saved aggregate:

- `CharacterDraft`

The draft should hold in-progress selections for:

- identity
- race
- background
- ability score method and provenance
- equipment money and selected entries
- class
- level
- experience
- finishing details

Rules:

- canceling the flow should discard the draft unless future autosave behavior
  is explicitly added
- save should convert a valid `CharacterDraft` into a persisted `Character`

## Character Sheet Mapping Contract

The first character-sheet mapper should be able to derive:

- identity header
- background summary
- background bonuses list
- background social perks list
- six ability rows with final score and modifier
- ability score method label
- proficiency bonus
- progress toward next level
- current hit points
- maximum hit points
- temporary hit points

Equipment is intentionally not required on the first character sheet even
though it is part of the saved aggregate.

Finishing details are also not required on the first character sheet.

## Acceptance Criteria

- The proposed model can represent every required field from MVP creation.
- The proposed model can render the first character sheet without requiring
  raw widget-side rules logic.
- Ability score method and provenance are preserved distinctly.
- Background bonuses and social perks remain distinct in persistence and
  mapping.
- Hit points can be persisted and rendered as real MVP character-sheet data.
- Equipment purchases can be represented with money context and owned entries.
- Optional finishing details can be stored without affecting MVP validity.
- The model can expand later toward fuller inventory and character systems
  without discarding MVP data.

## Next Step After Approval

1. translate this model into the first Drift schema from these persistence
   groups
2. define draft-to-aggregate mapping and validation use cases
3. replace temporary in-memory repository boundaries with Drift-backed
   implementations

## Related Documents

- `docs/specs/first-character-sheet-contents.md`
- `docs/specs/create-character-screen.md`
- `docs/specs/mvp-scope.md`
- `docs/adr/ADR-007-use-drift-for-local-persistence.md`
- `docs/project/PROJECT_GUIDELINES.md`
