# Compendium Screen Specification

## Status

Draft

## Summary

The compendium screen is the first dedicated destination behind the
`Compendio` main-menu action. It exposes the active compendium source policy,
section-by-section source coverage, a compact summary of what local
content is currently available offline, and the first read-only management
placeholders for future pack/import workflows.

## Goals

- Turn the main-menu compendium status from a summary card into a real screen.
- Let the player inspect which local rules sources are active.
- Make section coverage visible before pack management or import flows exist.
- Keep future compendium-pack and XML-import entry points visible without
  implementing those workflows yet.

## In Scope

- Navigation from the main menu into a dedicated compendium screen
- Read-only display of the active compendium source label
- Read-only display of the fallback source label
- Display of current bundled-base and optional-pack state
- Local activation/deactivation state for optional packs
- Read-only visibility of the future XML import entry point
- Local XML paste-and-register flow for optional pack metadata
- Navigation into a dedicated read-only pack-management screen
- Coverage counts for currently loaded catalog sections
- Section-by-section source policy details for primary and supplemental inputs
- Back navigation to the main menu

## Out of Scope

- Full XML content ingestion into the active catalog
- Deep browsing of every race, class, spell, feat, or monster entry
- Rules reference presentation

## Entry Conditions

- The user is in the main menu and chooses `Compendio`.

## Exit Paths

- Return to the main menu

## Primary Actions

- Review active source policy
- Review current pack/import readiness state
- Activate or deactivate persisted optional pack state
- Review current offline section coverage
- Review which source files feed each section
- Open the read-only pack-management screen
- Trigger an explicit not-yet-implemented XML import message
- Register pasted XML as a local optional pack

## Required Data

- `CompendiumCatalog`
- `CompendiumSourcePolicy`
- Section coverage counts derived from the loaded catalog

## UI States

- Populated: source summary, management state, coverage metrics, section
  source details, and persisted pack-state controls
- Empty policy fallback: source summary plus a message that no detailed section
  policy is available

## Acceptance Criteria

- Tapping `Compendio` in the main menu opens this screen.
- The screen works fully offline from the already loaded local catalog.
- The screen shows the active source label and the fallback source label.
- The screen shows that the bundled base compendium is active.
- The screen shows persisted local state for bundled-base and optional packs.
- Tapping `Administrar packs` opens a dedicated screen that keeps the bundled
  base compendium fixed as active and allows optional pack state to be stored
  locally.
- Optional pack state affects the effective compendium shown by this screen,
  including current coverage and source-policy supplemental inputs.
- Optional-pack filtering should be driven by explicit compendium metadata
  carried on affected content and source-policy sections, not by UI-local
  heuristics.
- Tapping `Importar XML` opens a dedicated import screen.
- The import screen accepts pasted XML, validates a minimal compatible
  structure, and registers the XML as a local optional pack.
- Successfully registered XML appears in `Administrar packs`.
- Active imported packs now contribute supported imported entries to the live
  compendium catalog and annotate affected source-policy sections.
- The current import slice still does not ingest imported narrative option
  catalogs or more advanced structured rules data.
- The screen shows current counts for major compendium sections such as races,
  classes, backgrounds, spells, feats, monsters, and narrative groups.
- The screen lists each published source-policy section with its source type,
  primary sources, and supplemental sources when present.
- The user can navigate back to the main menu without losing the current app
  state.

## Architectural Notes

- The screen should consume the existing `CompendiumCatalog` contract rather
  than reading raw assets or persistence rows directly.
- Persisted pack state should stay local-first and use the existing Drift
  database instead of introducing a separate storage path.
- The effective catalog shown in the UI should be filtered from persisted pack
  state through the existing compendium repository boundary.
- Future import behavior belongs to the compendium feature but should build on
  this route instead of replacing the contract.
