# Adventure Vault Character – Future Specs

This document captures candidate features that are intentionally outside the
current implementation baseline but should remain visible for future planning.

## FS-001: New Player Help Text

### Summary

Add an optional in-app help mode that shows short explanatory text for new
players while they use the application.

### Goal

Reduce onboarding friction for players who are unfamiliar with Dungeons &
Dragons terminology, character sheets, or common in-session actions.

### Expected Behavior

- The player can enable or disable contextual help text.
- Help text appears near key screens or interactions such as character
  creation, dice rolling, spell management, and inventory updates.
- The feature is additive and should not block experienced players with
  mandatory walkthroughs.
- Help content must remain available offline.

### Notes

- This should be treated as a future usability feature, not part of the
  current architecture baseline.
- A later iteration can decide whether the help is implemented as tooltips,
  inline callouts, or a lightweight onboarding layer.

## FS-002: Backup and Restore

### Summary

Add a future backup and restore capability that lets the user export and
recover local characters, compendium data, and app-level information.

### Goal

Protect offline-first player data and make device migration or recovery
possible without requiring cloud sync.

### Expected Behavior

- The player can create a backup of local characters.
- The player can create a backup of imported or locally stored compendium
  content.
- The player can create a backup of app-level information such as local
  configuration and supported metadata.
- The player can restore from a previously created backup package.
- Backup and restore remain available without network access.

### Candidate Backup Scope

- characters and related character-owned data
- compendium imports or indexes needed by the app
- app settings and local configuration

### Notes

- This should be treated as a future recovery and migration feature, not MVP.
- The feature should align with the offline-first architecture and local
  source-of-truth rule.
- A later iteration should define backup format, encryption needs, versioning,
  partial restore behavior, and validation rules.

## FS-003: Compendium Content Selector

Status: Implemented baseline (promoted from future-only)

### Summary

Continue evolving the implemented compendium-management screens that already let
the player review bundled/imported packs and control optional pack activation.

### Goal

Deepen the current pack management behavior so the active rules/content set
remains explicit and predictable as more imported content is supported.

### Expected Behavior

- Compendium summary and management screens remain reachable from main menu.
- The bundled base compendium stays always active.
- Optional imported packs continue to be enabled/disabled locally with
  persistence.
- Filtering extends beyond the current narrative-focused coverage into broader
  compendium areas.
- The app adds compatibility warnings before disabling packs that may affect
  existing characters.
- Create/edit/sheet/compendium paths consistently read from the same effective
  active compendium set.

### Notes

- This is no longer future-only; the baseline exists and should be expanded.
- Next iterations should define precedence rules, conflict handling, and richer
  compatibility warnings across character dependencies.
