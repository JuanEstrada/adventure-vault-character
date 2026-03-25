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

### Summary

Add a future compendium-management screen that lets the player review bundled
and imported compendium packs and control which optional packs are active.

### Goal

Make the active rules/content set explicit once the app supports a bundled
base compendium plus future imported XML compendium packs.

### Expected Behavior

- The player can open a `Compendio` management screen from the app.
- The screen shows the bundled base compendium and any imported compendium
  packs.
- The bundled base compendium remains always active.
- Optional imported packs can be enabled or disabled from the selector.
- The app warns the player before disabling a pack that may affect existing
  characters or creation options.
- The create-character flow and other compendium-backed screens read from the
  currently active compendium set.

### Notes

- This should be treated as a future content-management feature, not MVP.
- The feature depends on the `Compendium Import System` and on support for
  multiple compendium packs in local persistence.
- A later iteration should define precedence rules, conflict handling,
  compatibility warnings, and pack metadata shown in the UI.
