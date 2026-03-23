# First Character Sheet Contents

## Status

Proposed

## Purpose

Define the exact minimum visible contents of the first usable character sheet
for the MVP. This document exists to unblock the first character domain model,
the initial persisted shape, and the first view-model mapping.

## Scope

This specification defines only what the first character sheet must display
and the minimum supporting data shape implied by that display.

This specification does not define:

- full edit behavior
- combat automation
- inventory or spell systems
- advanced derived-rule coverage beyond the first MVP summary

## Design Constraints

- The character sheet must be fully usable offline.
- The screen must consume mapped view data, not raw persistence entities.
- Rule logic must stay out of widgets.
- The displayed fields must come only from MVP-confirmed creation inputs or
  deterministic derivations from those inputs.

## Character Sheet Goal

The first character sheet must work as the player's stable post-creation home
screen and as the first session-usable summary. It should show the smallest
field set that still lets the player recognize the character, verify that
creation succeeded correctly, and review the most important play-facing data
introduced during MVP creation.

## Required Visible Sections

### 1. Identity Summary

The top summary must show:

- character name
- selected race name
- selected class name
- current level
- current experience

This section is required because it confirms the core created record and
anchors all later screens to a clear character identity.

### 2. Background Summary

The background section must show:

- selected background name
- short background description or summary text
- visible list of background bonuses
- visible list of background social perks

This section is required because background is a mandatory guided creation
step and its player-facing results must remain visible after save.

## Background Representation Rules

For the first character sheet, background output must be represented as two
distinct rendered lists:

- bonuses
- social perks

The first persisted and mapped shape should preserve these categories
explicitly rather than flattening them into a single undifferentiated text
blob.

Minimum expectation for each visible background item:

- stable source identifier when available
- short display label
- optional short explanatory text

If the compendium source is richer than the MVP needs, the first sheet should
map only the player-facing subset required for display and later recall.

### 3. Ability Scores

The ability score section must show all six final abilities:

- Strength
- Dexterity
- Constitution
- Intelligence
- Wisdom
- Charisma

For each ability, the screen must show:

- final score
- final modifier

The six abilities must always be shown as a complete set, not as a collapsed
summary or a partial preview.

This section is required because a complete ability score assignment is part
of the minimum valid character record and the final scores must be reviewable
after creation.

## Ability Score Representation Rules

The first persisted and mapped model must preserve both:

- the selected generation method
- the final assigned score per ability

The generation method must be visible on the character sheet as a short
summary label.

Supported MVP method labels:

- generated set assignment
- manual point allocation

To preserve later editing and validation options, the initial shape should
also keep assignment provenance separate from final displayed values.

Minimum stored or mapped ability-score information implied by this screen:

- method identifier
- final score for each of the six abilities
- modifier for each of the six abilities, whether persisted or deterministically
  derived outside widgets
- method-specific provenance data

For generated set assignment, the creation flow should present an automatically
generated or predefined score set that the player distributes across the six
abilities. The first shape must preserve both the source set and the final
per-ability assignment.

For generated set assignment, provenance should preserve:

- generated or provided source set
- final assignment from source values to abilities

For manual point allocation, provenance should preserve:

- assigned value per ability
- remaining or spent budget result needed for later validation or audit

For manual point allocation, the creation flow should expose all six
abilities directly and let the player adjust them individually within the
allowed rule boundaries while a visible budget summary updates.

## Ability Score Builder Reference

The intended MVP interaction should follow the visual structure shown in:

- `local-ui-assets/character-builder/10_builder_ability_scores.jpg`

That reference implies the following MVP requirements:

- the screen presents all six abilities at once
- one mode shows a generated score set available for assignment
- one mode shows direct per-ability adjustment controls
- the remaining point budget is visible in the manual-allocation mode
- the player can understand the final per-ability result before save

### 4. Core Derived Summary

The first character sheet must show a small derived summary block with:

- proficiency bonus
- progress toward next level as percentage or equivalent progress summary

These fields are already implied by the MVP creation flow and can be derived
deterministically from level and experience without introducing broader combat
or resource systems.

### 5. Hit Points Summary

The first character sheet must show a real hit-points block as part of MVP.

It must show:

- current hit points
- maximum hit points
- temporary hit points

This block is required because hit points are core in-session information and
must not be deferred behind a placeholder-only combat panel.

## Hit Points Representation Rules

The first persisted and mapped model must preserve:

- current hit points
- maximum hit points
- temporary hit points

The first MVP should allow the app to reopen and render hit-point state
correctly from local persistence.

## Explicitly Excluded From The First Sheet

The first character sheet should not require these fields for MVP approval:

- armor class
- initiative
- saving throws
- skills list
- attacks
- equipment
- spells
- feature catalog beyond the chosen background outputs
- notes

These may appear later, but they should not block the first persisted
character model or the first playable shell.

## Minimum Character Sheet Data Contract

The first character sheet view model must be able to supply, at minimum:

- character id
- name
- race summary
- class summary
- level
- experience
- level progress summary
- proficiency bonus
- current hit points
- maximum hit points
- temporary hit points
- background summary
- background bonuses collection
- background social perks collection
- ability score method summary
- six ability score rows with score and modifier

## Acceptance Criteria

- A newly created character can be opened and recognized immediately from the
  sheet header.
- The selected background, its bonuses, and its social perks are visible on
  the sheet.
- All six final ability scores and their modifiers are visible on the sheet.
- The chosen ability score generation method is visible on the sheet.
- Level and experience are visible together.
- Current, maximum, and temporary hit points are visible on the sheet.
- The first sheet does not depend on combat, inventory, or spell systems.
- The defined contents are sufficient to derive the first character domain
  model and initial persistence shape.

## Implications For Next Step

Once this specification is accepted, the next work should be:

1. define the first character domain entities from this displayed data set
2. define persistence boundaries for background outputs and ability-score
   provenance
3. define the first `lib/` package and module boundaries around creation,
   character viewing, compendium-backed lookups, and persistence

## Related Documents

- `docs/specs/character-sheet-screen.md`
- `docs/specs/create-character-screen.md`
- `docs/specs/mvp-scope.md`
- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_GUIDELINES.md`
