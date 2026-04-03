# Character Sheet Screen Specification

## Status

Draft

## Summary

The character sheet screen is the main post-creation destination and the
primary in-session screen for the player. It presents the selected
character's core information and becomes the central navigation point for
later gameplay-support features.

The first sheet should use a panel-based layout as its visual foundation so
that combat, abilities, equipment, and features can grow later without
replacing the core screen structure.

## Goals

- Give the user a stable main screen after character creation or selection.
- Present core character information in a readable session-ready form.
- Establish the destination screen that later connects to dice, resources,
  inventory, spells, and editing.
- Start with a layout that already matches the intended multi-panel character
  experience.

## In Scope

- Read-only presentation of core character information
- Visible presentation of selected background details relevant to play
- Entry from character list and create character flow
- Refresh from local persisted data
- Navigation entry points for future related screens
- Header and panel-navigation layout for the first character sheet
- MVP population of the abilities and features-style panels
- MVP hit-points presentation in the combat panel
- Optional portrait preview in header/top context when persisted value is
  available and safely renderable
- Passive perception visibility derived from existing character state
- Dedicated skills visibility and organized proficiency/language presentation

## Out of Scope

- Full combat automation
- Inventory management details
- Full spell management details
- Rich editing workflows
- Fully implemented non-MVP panel interactions

## Entry Conditions

- The user selects a character from the character list.
- The app creates a new character successfully.

## Exit Paths

- Return to character list
- Navigate to future related feature screens
- Enter edit flow when that feature exists

## Primary Actions

- Review core character information
- Navigate back to character list
- Open future related sections from the character context
- Move between character panels

## Required Data

- Character identity summary
- Selected background summary
- Background bonuses and social perks
- Final ability scores with per-ability modifiers
- Skill list with deterministic bonus display
- Ability score generation method summary
- Core stats and derived summary fields
- Locally persisted character state for the selected record
- Optional local load error information
- Panel selection state

## Visual Layout Direction

The first sheet should use these assets as visual references:

- `local-ui-assets/ability-skills-panel/00_ability_skills_panel_main.jpg`
- `local-ui-assets/character-menu/00_character_drawer_menu.jpg`
- `local-ui-assets/combat-panel/12_combat_panel_main_named_character.jpg`
- `local-ui-assets/equipment-panel/00_equipment_panel_main.jpg`
- `local-ui-assets/features-notes-panel/00_features_notes_panel_main.jpg`

These references imply:

- a dark, utility-first screen
- persistent character identity in the top area
- icon-based panel navigation near the top
- content grouped into strong horizontal sections
- a drawer or overflow path for contextual character actions

## Layout Structure

### 1. Header

The sheet header should show:

- back navigation
- character name
- access to the character menu or drawer

The header should make it immediately clear which character is active and give
the user a fast path back to the main menu.

### 2. Top Character Context

Near the top of the sheet, the user should be able to understand:

- character name
- race
- class
- level
- experience

This context may be part of the header area or the first content block, but
it must remain visually prominent.

### 3. Panel Navigation

The first sheet should adopt a panel-navigation structure inspired by the
reference assets.

The first panel set should support:

- `Combat`
- `Abilities`
- `Equipment`
- `Features / Notes`

MVP rule:

- the layout should expose these panel destinations even if some panels are
  only partially populated at first

### 4. MVP Default Panel

For the MVP, the default landing panel should be `Abilities` or an equivalent
core-summary-first panel, because that panel already contains required first-
sheet information.

## MVP Panel Content

### Abilities Panel

This panel should carry the densest MVP content.

It must show:

- the six final ability scores
- per-ability modifiers
- ability score generation method summary
- proficiency bonus
- progress toward next level

If the layout grows later into saving throws or skills, the first MVP should
still remain valid without requiring those additions.

### Features / Notes Panel

For MVP, this panel should carry the first background-facing information.

It must show:

- selected background name
- background summary text
- background bonuses
- background social perks

Optional notes editing is out of MVP scope, but the panel structure should
anticipate future notes and feature expansion.

### Combat Panel

The combat panel may exist visually in MVP but should not block delivery of
the first character sheet.

MVP expectation:

- the panel can exist as a structural destination
- it must show a real hit-points block in MVP
- it may still use placeholder content for deeper combat features
- it should not require full combat-system implementation

### Equipment Panel

The equipment panel may also exist visually in MVP without requiring complete
equipment-management behavior.

MVP expectation:

- the panel can exist as a structural destination
- it should use a simple placeholder state in MVP
- detailed equipment interactions remain out of scope for the first sheet

### Spells Panel

The sheet may expose a first read-only `Spells` panel when the active class is
a spellcaster.

Foundation expectation:

- the panel can exist as a structural and informational destination before
  full spell management is implemented
- it should show the character's spellcasting ability
- it should show the derived spellcasting modifier
- it should show `spell save DC`
- it should show `spell attack bonus`
- it may show a read-only list of locally available compendium spells for the
  active class
- prepared spells, spell slots, and resource editing remain out of scope for
  this first spell foundation
- the next implemented slice may promote selected spells and current slot
  usage into persisted read/write character state while still deferring richer
  spellbook and rest-recovery systems

## UI States

- Loading: selected character data is being resolved
- Success: core character information is visible
- Empty or missing record: selected character no longer exists
- Error: local read failed and user needs a retry path
- Partial panel population: the layout exists, but some non-MVP panels expose
  only minimal or placeholder content
- Combat partial population: hit points are real MVP content even if other
  combat features are still placeholders

## User Flows

1. User opens a character from the character list.
2. App loads the selected character from local storage.
3. Character sheet renders the header, top context, and panel navigation.
4. The default panel shows the first required MVP information.
5. User reviews character information or continues to future panel areas.

### Post-Creation Flow

1. User creates a character successfully.
2. App routes directly to the new character sheet.
3. The user sees the created character as the active context.
4. The newly created character sheet uses the same panel-based structure as a
   reopened saved character.

## Acceptance Criteria

- The selected character can be loaded fully offline.
- The screen presents enough core information to serve as the main home for a
  selected character.
- The screen uses a stable panel-based layout aligned with the provided visual
  references.
- The header and top character context make the active character obvious.
- The selected background, its bonuses, and its social perks are visible on
  the character sheet.
- The six final ability scores and their modifiers are visible on the
  character sheet.
- The combat panel shows current, maximum, and temporary hit points in MVP.
- The combat panel also shows passive perception derived from existing
  character data via deterministic formula logic outside widgets.
- If a persisted portrait value exists and can be rendered safely, the sheet
  shows it in the top context area; otherwise it degrades gracefully.
- The sheet exposes a visible skills section and separates languages from other
  proficiencies for faster in-session lookup.
- When the active class is a spellcaster, the sheet can show a read-only
  spellcasting summary derived from domain logic and the local compendium.
- When persisted spell state exists, the sheet should also show the stored
  selected spells plus remaining spell slots for the current level.
- `Equipment` may still appear as a simple placeholder in MVP.
- The character sheet can be opened from the character card without layout
  mismatch or a separate temporary detail screen.
- A missing or deleted character record is handled explicitly.
- The character sheet can serve as the hub for future in-session features.

## Architectural Notes

- The screen should consume mapped view data rather than raw persistence
  entities.
- Derived rule values should come from domain or application logic, not be
  computed ad hoc in widgets.
- The first sheet layout should separate structural navigation from content
  completeness so future panels can be filled without redesigning the screen.
- This screen is the anchor for Phase 3 and later roadmap phases.
- Related roadmap phases: Phase 2 and Phase 3 in
  `docs/project/ROADMAP.md`.

## Related Documents

- `docs/specs/character-card.md`
- `docs/specs/first-character-sheet-contents.md`
- `docs/specs/initial-character-domain-model.md`
