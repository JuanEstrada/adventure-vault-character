# Character Card Specification

## Status

Proposed

## Summary

The character card is the main-menu representation of a locally saved
character. It gives the player a fast way to recognize an existing character
and open that character's sheet.

The first card should follow a library-style visual layout with a dominant
portrait or placeholder image and a short text summary anchored at the bottom
of the card.

## Goals

- Make saved characters recognizable at a glance.
- Connect character persistence to the main-menu home experience.
- Provide a direct entry point into the character sheet.

## In Scope

- Character card content for the main menu
- Immediate appearance of a newly saved character in the card list
- Open-character action from the card
- Offline rendering from local summary data
- Library-style visual presentation with image-first emphasis

## Out of Scope

- Character deletion
- Reordering, sorting, or filtering beyond simple defaults
- Rich card actions such as edit, duplicate, or archive

## Entry Conditions

- The main menu loads existing character summaries from local storage.
- A new character is successfully finalized and persisted.

## Exit Paths

- Open the selected character sheet

## Primary Actions

- Review the saved-character summary
- Tap the card to open the character sheet

## Required Data

- character id
- character name
- race display name
- class display name
- level
- optional portrait thumbnail when available

## Recommended Visible Fields

The first character card should show:

- portrait or placeholder image as the dominant visual element
- character name
- race
- class
- level

Optional enhancement for MVP if already available from saved data:

- portrait image from finishing details instead of the placeholder

The card should not require deeper character-sheet-only data such as
background bonuses, full ability scores, equipment, or notes.

## Visual Reference

The first card should use this reference as its primary visual direction:

- `local-ui-assets/character-library/03_character_library_card_view.jpg`

That reference implies:

- a vertical library-style card
- a large image or placeholder block
- title text near the lower area of the card
- a short secondary identity line under the title
- fast visual scanning across multiple saved characters

## Layout Guidance

The first card layout should be:

- top and center area dominated by portrait or placeholder
- lower overlay or lower text area for identity summary
- primary text: character name
- secondary text: race, class, and level in one compact line

If no portrait exists, the placeholder should still produce a complete and
readable card without visual breakage.

## UI States

- Populated: summary fields are visible and the card can be opened
- Missing portrait: the card still renders cleanly with text-only identity
- Error or stale reference: the card cannot resolve to a full character and
  the app must handle that on open

## User Flows

### Existing Character Flow

1. The main menu loads saved character summaries.
2. The app renders one character card per locally available character.
3. The user recognizes a character from the visible summary.
4. The user taps the card.
5. The app opens that character's sheet.

### Newly Created Character Flow

1. The user finalizes character creation.
2. The app persists the character locally.
3. The app adds the new character summary to the main-menu card list.
4. The user can later reopen the character from that card.

## Acceptance Criteria

- A saved character appears as a card in the main menu using local summary
  data only.
- A newly created character appears in the card list after successful save.
- Tapping the card opens the matching character sheet.
- The card remains usable offline.
- The first card does not depend on loading the full character-sheet payload
  just to render the summary.
- The card layout remains readable whether the character has a portrait or
  only a placeholder image.

## Architectural Notes

- Character cards should consume a summary view model, not raw persistence
  entities.
- The summary model should stay intentionally smaller than the full character
  aggregate.
- The card is the bridge between `create -> save -> main menu -> open sheet`.
- Portrait usage should come from saved finishing-details data when available,
  but card rendering must not depend on portrait presence.

## Related Documents

- `docs/specs/main-menu-screen.md`
- `docs/specs/create-character-screen.md`
- `docs/specs/character-sheet-screen.md`
- `docs/specs/first-character-sheet-contents.md`
- `docs/specs/initial-character-domain-model.md`
