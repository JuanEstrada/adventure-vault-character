# Removed Local Assets

Removal date: 2026-03-25

Reason:
- The app now reads its active compendium XML directly from
  `local-assets/FightClub5eXML-master/`.
- The previous curated XML files under `local-assets/runtime/compendium/`
  are no longer part of the runtime path and were removed to avoid duplicated
  sources of truth.

Removed files:
- `local-assets/runtime/compendium/srd_5_2_1_app_base.xml`
- `local-assets/runtime/compendium/official_only_2024.xml`
- `local-assets/runtime/compendium/core_rulebooks.xml`

Removed directories:
- `local-assets/runtime/compendium/`
- `local-assets/runtime/`
