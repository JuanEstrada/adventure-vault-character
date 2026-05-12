# App Function / Module Map

Status: working inventory from real code + `docs/specs/*`

## Scope used for this map

```text
Scope: D (UI + logic + data/persistence)
Detail: C (deep)
"Test status": D = has direct test coverage detected in `test/`
"Mejorar": F = UX + architecture + spec consistency + tests + flow clarity
Source of truth: B = real code + docs/specs
```

## Reading rules

```text
Existe?   = implemented in code and reachable either as an app route, nested screen,
            dialog, service, domain rule, or repository module.
Test status = YES when direct tests were detected for that item or its immediate unit.
            PARTIAL when only nearby/indirect coverage is evident.
            NO TEST when no direct test coverage was detected.
```

## Table 1 — Top-level modules

```text
+-------------+------------------------------------+-------------------------------+---------+-----------+------------------------------------------------------+
| Module      | Purpose                            | Main entry points             | Existe? | Test status | Usable / improve?                                    |
+-------------+------------------------------------+-------------------------------+---------+-----------+------------------------------------------------------+
| bootstrap   | Startup + initial local loading    | BootstrapScreen, initialize() | YES | NO TEST |Usable, but missing direct screen tests.            |
| access      | Offline continuation entry         | AccessScreen                  | YES | NO TEST |Usable, but missing direct screen tests.            |
| main_menu   | Home hub + character entry         | MainMenuScreen, CharacterCard | YES | NO TEST |Usable, but missing direct widget/screen tests.     |
| compendium  | Browse/import/manage local content | 3 screens + repository stack  | YES     | PARTIAL   | Good base; packs/import screens need more tests.    |
| settings    | Persisted system settings          | SystemSettingsScreen          | YES     | PARTIAL   | Data layer tested; screen lacks direct tests.       |
| characters  | Core app domain                    | create/sheet/edit/inventory   | YES     | PARTIAL   | Strongest area; still uneven across UI surfaces.    |
+-------------+------------------------------------+-------------------------------+---------+-----------+------------------------------------------------------+
```

## Table 2 — App routes and primary screens

```text
+----+---------------+----------------------------+---------------------------+---------+-----------+--------------------------------------------------------------+
| ID | Module        | Screen / route             | Key widgets / children    | Existe? | Test status | Usable / improve?                                            |
+----+---------------+----------------------------+---------------------------+---------+-----------+--------------------------------------------------------------+
| 01 | bootstrap     | BootstrapScreen            | loading + retry state     | YES | NO TEST |Add direct widget tests for loading/error/retry.            |
| 02 | access        | AccessScreen               | continue offline CTA      | YES | NO TEST |Add direct tests for offline path and accessibility labels. |
| 03 | main_menu     | MainMenuScreen             | CharacterSummaryCard list | YES | NO TEST |Add tests for empty/populated states and menu actions.      |
| 04 | compendium    | CompendiumScreen           | catalog overview          | YES     | YES       | Good base; extend tests to richer source-policy cases.      |
| 05 | compendium    | CompendiumPacksScreen      | pack activation controls  | YES | NO TEST |Needs direct screen tests and state-flow validation.        |
| 06 | compendium    | CompendiumImportScreen     | XML import flow           | YES | NO TEST |Needs direct widget tests for validation and failure paths. |
| 07 | settings      | SystemSettingsScreen       | coin-weight toggle        | YES | NO TEST |Add direct screen tests for toggle and save feedback.       |
| 08 | characters    | CreateCharacterScreen      | guided builder            | YES | NO TEST |High-value gap: add direct flow tests for builder sections. |
| 09 | characters    | CharacterSheetScreen       | inventory/spell/combat UI | YES     | YES       | Most tested screen; continue E2E and interaction coverage.  |
| 10 | characters    | EditCharacterScreen        | editor controller         | YES | NO TEST |Add direct tests for load/edit/save/cancel flow.            |
+----+---------------+----------------------------+---------------------------+---------+-----------+--------------------------------------------------------------+
```

## Table 3 — Nested widgets, dialogs, and sub-screens

```text
+----+ Parent screen           | Nested surface                  | Role                                              | Existe? | Test status | Usable / improve?                                           |
+----+-------------------------+---------------------------------+---------------------------------------------------+---------+-----------+-------------------------------------------------------------+
| 01 | MainMenuScreen          | CharacterSummaryCard            | saved-character summary card                      | YES | NO TEST |Add direct widget tests and selection semantics coverage.  |
| 02 | CharacterSheetScreen    | ContainerManagementDialog       | create/rename/delete containers                   | YES     | YES       | Good base; rename/delete wiring still deserves regression. |
| 03 | CharacterSheetScreen    | TransferToContainerDialog       | move stack/item into container                    | YES     | YES       | Good base; add more edge-case quantity/capacity tests.     |
| 04 | CharacterSheetScreen    | SplitStackDialog                | split inventory stacks                            | YES     | YES       | Good dialog coverage; connect to more end-to-end flows.    |
| 05 | CharacterSheetScreen    | MergeStackDialog                | merge compatible stacks                           | YES     | YES       | Good dialog coverage; add cross-container merge guards.    |
| 06 | CreateCharacterScreen   | PreparedSpellSelectionScreen    | prepared-spell selection                          | YES     | YES       | Tested; could use integration coverage from builder flow.  |
| 07 | CreateCharacterScreen   | SpellbookManagementScreen       | spellbook / known spell management                | YES     | YES       | Tested; needs stronger integration into create/edit flows. |
| 08 | EditCharacterScreen     | CharacterEditorController       | screen state/controller bridge                    | YES | NO TEST |Add direct controller tests around dirty-state flows.      |
+----+-------------------------+---------------------------------+---------------------------------------------------+---------+-----------+-------------------------------------------------------------+
```

## Table 4 — Character business functions (general -> particular)

```text
+----+ Layer        | Function / module                               | Main files                                                  | Existe? | Test status | Usable / improve?                                                     |
+----+--------------+--------------------------------------------------+-------------------------------------------------------------+---------+-----------+-----------------------------------------------------------------------+
| 01 | application  | create character                                | create_character_service.dart                               | YES     | PARTIAL   | Core capability exists; needs more direct create-flow UI tests.       |
| 02 | application  | load/edit/save editable character               | editable_character_service.dart, character_record_loader.dart | YES   | YES       | Service coverage exists; screen-level editing flow needs more tests.  |
| 03 | application  | auto-save + change tracking                     | auto_save_service.dart, character_change_tracker.dart       | YES     | YES       | Keep, but add UI-level dirty-state regression tests.                  |
| 04 | application  | finishing details assembly                      | finishing_details_service.dart                              | YES     | YES       | Covered; keep aligned with builder UX and validation rules.           |
| 05 | application  | inventory mutation orchestration                | character_inventory_service.dart                            | YES     | PARTIAL   | Strong rules/tests nearby; add broader end-to-end inventory coverage. |
| 06 | application  | short/long rest recovery                        | character_recovery_service.dart                             | YES     | PARTIAL   | Screen semantics tested; service-specific direct tests could grow.    |
| 07 | application  | death saves                                     | character_death_save_service.dart                           | YES     | PARTIAL   | Exposed on sheet; add more explicit service/UI direct tests.          |
| 08 | application  | sheet composition                               | character_sheet_service.dart                                | YES     | PARTIAL   | Valuable service; ensure more direct tests for composition variants.  |
| 09 | domain       | draft validation                                | character_draft_validator.dart                              | YES     | YES       | Good; maintain alongside builder constraints.                         |
| 10 | domain       | combat rules                                    | character_combat_rules.dart                                 | YES     | YES       | Well covered; continue if combat UI expands.                          |
| 11 | domain       | spell rules                                     | character_spell_rules.dart                                  | YES     | YES       | Good; keep aligned with spellbook/prepared flows.                     |
| 12 | domain       | spell slot usage codec                          | character_spell_slot_usage_codec.dart                       | YES     | YES       | Good unit coverage.                                                   |
| 13 | domain       | class resource rules                            | character_class_resource_rules.dart                         | YES     | YES       | Good; add UI integration as resources expand.                         |
| 14 | domain       | rest rules                                      | character_rest_rules.dart                                   | YES     | YES       | Good rule coverage.                                                   |
| 15 | domain       | encumbrance rules                               | character_encumbrance_rules.dart                            | YES     | YES       | Good; keep tied to settings toggle and inventory flows.               |
| 16 | domain       | inventory stack rules                           | character_inventory_stack_rules.dart                        | YES     | YES       | Good; still needs higher-level interaction regression.                |
| 17 | domain       | quantity / validation contracts                 | quantity_rules + validation_error                           | YES     | PARTIAL   | Formalized, but add direct tests if validations grow.                 |
| 18 | data         | character repository abstraction                | character_repository.dart                                   | YES     | PARTIAL   | Contract exists; document behavior edge cases more explicitly.        |
| 19 | data         | in-memory repository                            | in_memory_character_repository.dart                         | YES     | YES       | Good for tests; maintain parity with Drift implementation.            |
| 20 | data         | Drift repository                                | drift_character_repository.dart                             | YES     | YES       | Good; migration/integration coverage exists.                          |
| 21 | data         | Drift database + DAOs                           | app_database.dart + DAOs                                    | YES     | YES       | Good base; keep migration discipline.                                 |
+----+--------------+--------------------------------------------------+-------------------------------------------------------------+---------+-----------+-----------------------------------------------------------------------+
```

## Table 5 — Compendium, settings, and app-shell business functions

```text
+----+ Module      | Function / module                          | Main files                                           | Existe? | Test status | Usable / improve?                                                   |
+----+-------------+---------------------------------------------+------------------------------------------------------+---------+-----------+---------------------------------------------------------------------+
| 01 | app shell   | stateful navigation + orchestration         | app_controller.dart, adventure_vault_app.dart        | YES     | YES       | Controller is heavily exercised indirectly; document route policy. |
| 02 | compendium  | startup catalog load                        | compendium_repository.dart implementations           | YES     | PARTIAL   | Works; add more pack-filter and fallback-state tests.              |
| 03 | compendium  | search                                      | compendium_search_service.dart                       | YES     | YES       | Good direct coverage.                                              |
| 04 | compendium  | XML validation                              | xml_import_validation.dart                           | YES     | PARTIAL   | Add direct focused tests if import surface grows.                  |
| 05 | compendium  | XML equipment metadata extraction           | xml_equipment_metadata_extractor.dart                | YES     | PARTIAL   | Add direct extractor tests for edge formats.                       |
| 06 | compendium  | asset-backed repository                     | asset_compendium_repository.dart                     | YES     | YES       | Good direct repository coverage.                                   |
| 07 | settings    | settings repository contract                | system_settings_repository.dart                      | YES     | PARTIAL   | Fine; screen-level UX tests missing.                               |
| 08 | settings    | Drift settings persistence                  | drift_system_settings_repository.dart                | YES     | YES       | Good direct persistence test coverage.                             |
| 09 | settings    | in-memory settings persistence              | in_memory_system_settings_repository.dart            | YES     | PARTIAL   | Useful support layer; can add direct tests if needed.              |
| 10 | main_menu   | character summary presentation              | character_card.dart                                  | YES | NO TEST |Add direct tests for visual states and actions.                    |
| 11 | bootstrap   | startup recovery / retry contract           | bootstrap_screen.dart + AppController.initialize()   | YES     | PARTIAL   | Behavior exists; add dedicated screen and integration tests.       |
| 12 | access      | offline continuation contract               | access_screen.dart + continueOffline()               | YES     | PARTIAL   | Behavior exists; add direct widget tests.                          |
+----+-------------+---------------------------------------------+------------------------------------------------------+---------+-----------+---------------------------------------------------------------------+
```

## Notes and caveats

```text
1. The main menu still exposes a "Rules" entry in the app shell, but in the
   current code it routes to compendium behavior instead of a dedicated rules
   feature screen.

2. "Test status" here was intentionally reduced to test detection because that is
   the definition you selected. It does NOT mean full manual QA completeness.

3. Some items are marked PARTIAL because tests exist nearby (service/domain or
   screen semantics) but not directly on the exact UI surface.
```

## Recommended next documentation slice

```text
1. Add a second inventory focused table only for `characters`.
2. Add a route-to-test traceability matrix.
3. Add a spec-to-implementation gap table for items like Rules, packs, import,
   and edit flow coverage.
```
