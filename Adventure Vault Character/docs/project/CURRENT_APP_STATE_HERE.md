# CURRENT_APP_STATE_HERE

Fecha de corte: 2026-03-27

Resumen:

- App Flutter offline-first para D&D 5e / 5.5e con arquitectura feature-first.
- Flujo implementado hoy: `bootstrap -> access -> main menu -> create -> save -> character sheet -> edit -> save -> reopen`.
- Persistencia local con Drift `v10` y modelo normalizado para personaje y compendio.
- El runtime actual usa XML SRD 5.5e locales y deja la importación de packs XML como capacidad futura.

## Project tree

- `lib/`
  - `main.dart`
  - `src/`
    - `app/`
      - `adventure_vault_app.dart`
      - `app_controller.dart`
    - `core/`
      - `navigation/app_screen.dart`
    - `features/`
      - `access/`
        - `presentation/access_screen.dart`
      - `bootstrap/`
        - `presentation/bootstrap_screen.dart`
      - `characters/`
        - `application/`
        - `data/`
          - `local/`
            - `app_database.dart`
            - `app_database.g.dart`
            - `character_read_dao.dart`
            - `character_reference_dao.dart`
            - `character_write_dao.dart`
          - `character_repository.dart`
          - `drift_character_repository.dart`
          - `in_memory_character_repository.dart`
        - `domain/`
        - `presentation/`
          - `create_character_screen.dart`
          - `edit_character_screen.dart`
          - `character_sheet_screen.dart`
          - `character_editor_controller.dart`
      - `compendium/`
        - `application/`
        - `data/`
          - `asset_compendium_repository.dart`
          - `compendium_repository.dart`
          - `in_memory_compendium_repository.dart`
        - `domain/`
          - `compendium_catalog.dart`
      - `main_menu/`
        - `presentation/`
          - `main_menu_screen.dart`
          - `character_card.dart`
- `assets/`
  - `compendium/catalog.json`
- `local-assets/`
  - `FightClub5eXML-master/`
  - `dnd-5e-srd-markdown-master/`
  - `local-rule-bases/`
  - `por ordenar/`
  - `reference/`
  - `templates/`
- `docs/`
  - `adr/`
  - `architecture/`
  - `project/`
  - `specs/`
- `test/`
  - `app_database_migration_test.dart`
  - `asset_compendium_repository_test.dart`
  - `character_domain_model_test.dart`
  - `character_draft_validator_test.dart`
  - `drift_character_repository_test.dart`
  - `editable_character_service_test.dart`
  - `widget_test.dart`

## Existing features

- `access`
- `bootstrap`
- `characters`
- `compendium`
- `main_menu`

Detalle rápido:

- `characters` es el feature más desarrollado y ya cubre `application`, `data`, `domain` y `presentation`.
- `compendium` ya tiene `domain` y `data`; `application/` existe como slice pero todavía sin archivos.
- `access`, `bootstrap` y `main_menu` están hoy centrados en `presentation`.

## Existing important files

- `lib/main.dart`
- `lib/src/app/adventure_vault_app.dart`
- `lib/src/app/app_controller.dart`
- `lib/src/core/navigation/app_screen.dart`
- `lib/src/features/main_menu/presentation/main_menu_screen.dart`
- `lib/src/features/characters/presentation/create_character_screen.dart`
- `lib/src/features/characters/presentation/edit_character_screen.dart`
- `lib/src/features/characters/presentation/character_sheet_screen.dart`
- `lib/src/features/characters/presentation/character_editor_controller.dart`
- `lib/src/features/characters/application/create_character_service.dart`
- `lib/src/features/characters/application/character_sheet_service.dart`
- `lib/src/features/characters/application/editable_character_service.dart`
- `lib/src/features/characters/application/character_record_loader.dart`
- `lib/src/features/characters/domain/character_rules.dart`
- `lib/src/features/characters/domain/character_domain_model.dart`
- `lib/src/features/characters/domain/character_domain_mapper.dart`
- `lib/src/features/characters/domain/character_record.dart`
- `lib/src/features/characters/domain/editable_character.dart`
- `lib/src/features/characters/domain/character_draft_validator.dart`
- `lib/src/features/characters/data/drift_character_repository.dart`
- `lib/src/features/characters/data/local/app_database.dart`
- `lib/src/features/characters/data/local/character_read_dao.dart`
- `lib/src/features/characters/data/local/character_reference_dao.dart`
- `lib/src/features/characters/data/local/character_write_dao.dart`
- `lib/src/features/compendium/data/asset_compendium_repository.dart`
- `lib/src/features/compendium/domain/compendium_catalog.dart`
- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `local-assets/local-rule-bases/README.md`

## Existing ADRs and architectural rules

ADRs existentes:

- `ADR-001` Use Kotlin for Android
- `ADR-002` Offline-first architecture
- `ADR-003` Use Room database
- `ADR-004` Separate player and DM apps
- `ADR-005` Use Jetpack Compose for UI
- `ADR-006` Use Flutter for client application
- `ADR-007` Use Drift for local persistence
- `ADR-008` Use `Compendio` and `Compendium Import System` terminology

ADRs vigentes en la implementación actual:

- `ADR-002`
- `ADR-004`
- `ADR-006`
- `ADR-007`
- `ADR-008`

Reglas arquitectónicas vigentes:

- Separación estricta entre `domain`, `application`, `data` y `presentation`.
- Regla de negocio y lógica D&D en `domain` o `application`, nunca en widgets.
- Persistencia local offline-first con Drift como fuente de verdad local.
- No guardar datos derivados si se pueden recomputar.
- `characters` actúa cada vez más como fila de identidad/resumen; las tablas normalizadas son la fuente canónica.
- `compendium` y la importación XML deben mantenerse separados de la lógica de reglas del personaje.
- El sistema debe seguir siendo extensible para SRD y futuros `compendium packs`.

## Naming conventions

- Tipos: `UpperCamelCase`
- Miembros Dart: `lowerCamelCase`
- Archivos y carpetas: `snake_case`
- Features: `lib/src/features/<feature>/`
- Capas por feature:
  - `application/`
  - `domain/`
  - `data/`
  - `presentation/`
- Nombres del producto:
  - dataset importado: `Compendio`
  - subsistema de ingestión XML: `Compendium Import System`

## Existing screens and missing screens

Pantallas implementadas en código:

- `BootstrapScreen`
- `AccessScreen`
- `MainMenuScreen`
- `CreateCharacterScreen`
- `CharacterSheetScreen`
- `EditCharacterScreen`

Pantallas/componentes documentados y al menos parcialmente representados:

- `CharacterCard`

Pantallas documentadas pero no implementadas como pantalla dedicada hoy:

- `Compendio`
- `Reglas`
- `Settings`
- `LOAD XML` real
- `Character List Screen` independiente
- `Empty State Screen` independiente

Pantallas o áreas funcionales que siguen faltando para el roadmap actual:

- Pantalla real de gestión de `Compendio` con selector de packs activos
- Flujo real de importación de `compendium packs`
- Superficie de reglas/consulta SRD dentro de la app
- Pantallas más profundas para combate, spells, inventory avanzado y recursos de clase
- Flujo completo de finishing details con modos `empty / rolled / manual`

## SRD content already loaded

Ya cargado o seed-eado en la app:

- `backgrounds`
- `races`
- `classes`
- `spells`
- `feats`
- `monsters`
- `skills`
- `equipment`
- `character advancement`
- `class standard array recommendations`
- `narrative option groups`
- `narrative options`
- `trinkets`

Ya normalizado para narrativa / finishing details:

- `alignment`
- `personality traits`
- `ideals`
- `bonds`
- `flaws`
- base inicial de `faction`

Todavía no está resuelto como sistema completo de producto:

- spell system completo
- armor class
- initiative
- ataques
- spell slots y tracking detallado
- recursos de clase
- reglas profundas de inventario/equipo

## Existing XMLs / compendium packs

Assets XML activos en runtime:

- `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_backgrounds_5.5e.xml`
- `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_races_5.5e.xml`
- `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_classes_5.5e.xml`
- `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_spells_5.5e.xml`
- `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_feats_5.5e.xml`
- `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_bestiary_5.5e.xml`

Packs / colecciones XML locales ya presentes en el repo:

- `Collections/System_Reference_Document_5.5e.xml`
- `Collections/System_Reference_Document_5e.xml`
- `Collections/Core_Rulebooks_5.5e.xml`
- `Collections/Complete_Compendium_5.5e.xml`
- `Collections/Complete_Compendium_5e.xml`
- muchas colecciones `WotC`, `Homebrew`, `ThirdParty`, `UnearthedArcana` y `Star_Wars_5e`

Fuentes XML oficiales adicionales ya presentes y útiles:

- `Sources/DND_5e/WizardsOfTheCoast/.../backgrounds-phb.xml`
- `Sources/DND_5e/WizardsOfTheCoast/.../backgrounds-scag.xml`
- `Sources/DND_5e/WizardsOfTheCoast/.../backgrounds-pam.xml`
- `Sources/DND_5e/WizardsOfTheCoast/.../backgrounds-ggr.xml`
- `Sources/DND_5e/WizardsOfTheCoast/.../backgrounds-erlw.xml`

Fallback no XML:

- `assets/compendium/catalog.json`

## Existing tests

Tests actuales:

- `test/app_database_migration_test.dart`
- `test/asset_compendium_repository_test.dart`
- `test/character_domain_model_test.dart`
- `test/character_draft_validator_test.dart`
- `test/drift_character_repository_test.dart`
- `test/editable_character_service_test.dart`
- `test/widget_test.dart`

Cobertura funcional visible:

- migraciones Drift hasta `v10`
- repositorio local de personajes
- carga de compendio desde assets/XML
- validación de draft
- dominio de personaje
- flujo editable `open -> edit -> save -> reopen`
- path offline hacia main menu

## Current priority

Prioridad recomendada:

- Completar el flujo real de `finishing details` usando las `narrative option groups` ya normalizadas.

Después de eso, el siguiente bloque con más valor sería:

- definir la política de source-of-truth entre SRD 5.5e y Wizards XML para opciones narrativas;
- seguir bajando reglas determinísticas al dominio para `spells`, `combat`, `armor class` y `attacks`;
- preparar la futura pantalla de `Compendio` y el soporte real para `compendium packs`.

## What I want you to do first

Si me vas a delegar una parte ahora, quiero que hagas primero:

- conectar `finishing details` en create/edit para soportar `empty / rolled / manual` usando el catálogo oficial ya cargado.

Razón:

- ya existe la base de datos normalizada;
- ya existen fuentes oficiales locales;
- ya existe el flujo create/edit;
- falta cerrar la integración de producto entre compendium, dominio y UI.
