# Repository Guidelines

## Non-Negotiable Rules

- All documentation must be written in English.
- All code-related language must be written in English, including comments,
  identifiers, and developer-facing text.

## Product Context

Adventure Vault Character is an offline-first D&D 5e character builder built
with Flutter and Drift.

Work against these product constraints at all times:

- Support official SRD content plus custom XML imports.
- Automate character logic such as level progression, spell preparation,
  attacks, modifiers, and derived sheet views.
- Keep game rules deterministic and testable.
- Preserve strict separation between `domain`, `application`, `data`, and
  `presentation`.
- Design for extensibility so homebrew and future compendium sources do not
  force rewrites across layers.

Do not treat this repository as a generic CRUD app. Character rules,
compendium ingestion, and offline persistence are core product behavior.

## Project Structure & Module Organization

Use the repository layout as the default source of truth:

- `lib/src/app/`: app bootstrap and top-level wiring.
- `lib/src/core/`: shared cross-cutting code such as navigation and common
  app primitives.
- `lib/src/features/<feature>/`: feature-first modules.
- `lib/src/features/<feature>/application/`: orchestration, use cases, and
  feature services.
- `lib/src/features/<feature>/domain/`: business rules, entities, value
  objects, validation, and pure mapping logic.
- `lib/src/features/<feature>/data/`: repositories, Drift adapters, asset
  loaders, and persistence-specific models.
- `lib/src/features/<feature>/presentation/`: screens, widgets, controllers,
  and view-facing state.
- `test/`: tests that mirror production behavior and feature boundaries.
- `assets/`: bundled runtime assets such as compendium catalog data.
- `local-assets/`: local XML source files used for SRD and custom rule data.
- `docs/specs/`: feature and screen specifications.
- `docs/architecture/`: architectural documentation.
- `docs/adr/`: architecture decision records.
- `docs/project/`: session continuity and project state documents.

Reflect the current feature layout when making decisions:

- `access`: entry and access flow UI.
- `bootstrap`: startup and initialization flow.
- `characters`: character creation, storage, summaries, and sheet behavior.
- `compendium`: compendium catalog access and source loading.
- `main_menu`: top-level menu and character list experience.

Prefer extending an existing feature slice before creating a new top-level
feature. Add shared code to `core` only when it is truly cross-cutting and not
domain-specific.

## Build, Test, and Development Commands

Use these commands for routine work:

- `flutter pub get`: install or refresh dependencies.
- `flutter run -d chrome`: run the app locally on web.
- `flutter run -d android`: run the app on an Android device or emulator.
- `flutter analyze`: run static analysis and lint checks.
- `flutter test`: run the test suite.
- `dart run build_runner build --delete-conflicting-outputs`: regenerate Drift
  and other generated files after schema changes.

Do not hand-edit generated files.

Before closing meaningful implementation work, run at least:

- `flutter analyze`
- `flutter test`

If persistence or generated models changed, also run the relevant
`build_runner` command.

## Coding Style & Layering Rules

Follow `analysis_options.yaml` and format code with `dart format .`.

Apply these naming and layering rules:

- Use 2-space indentation.
- Use `UpperCamelCase` for types.
- Use `snake_case` for files and directories.
- Use `lowerCamelCase` for Dart members.
- Keep widgets thin and presentation-focused.
- Keep business rules out of widgets.
- Keep persistence concerns out of domain entities and services.
- Keep `material`, widgets, and other UI-specific Flutter imports out of
  `domain` and `data`.
- Allow narrow use of `package:flutter/foundation.dart` in `domain` models when
  it only supports immutability or diagnostics and does not pull UI concerns
  across the boundary.
- Prefer descriptive names tied to the product domain.

Use the layer boundaries as hard constraints:

- `presentation` may depend on `application` and domain-facing models.
- `application` may coordinate `domain` and `data` abstractions.
- `domain` must remain deterministic and free of UI, platform, and persistence
  concerns.
- Prefer framework-agnostic `domain` code. If `package:flutter/foundation.dart`
  is used, keep it narrow and limited to immutability or diagnostics helpers.
- `data` may depend on Drift, assets, XML parsing, and repository contracts,
  but must not absorb UI behavior.

If a change pushes rule evaluation into widgets or stores a UI convenience field
in the database, stop and redesign it.

## Domain and Persistence Constraints

Treat D&D rules logic as a first-class subsystem.

Domain rules:

- Encode rule logic in domain or application services, not in widgets and not
  in Drift table definitions.
- Keep calculations deterministic and side-effect free whenever possible.
- Model canonical character state and derive sheet values from that state.
- Prefer composable rule objects, mappers, and validators over feature-local
  one-off conditionals scattered across the UI.

Persistence rules:

- Use Drift for local persistence.
- Avoid storing duplicated or derived values when they can be recomputed from
  canonical state.
- Design schemas so future XML and homebrew extensions can be added without
  schema churn across unrelated tables.
- Keep repository interfaces focused on domain needs, not storage details.
- Regenerate code after schema updates and cover migration impact with tests.

Compendium rules:

- Treat SRD and custom XML as supported content sources, not temporary input.
- Keep parsing, ingestion, and storage concerns separated from game rule
  evaluation.
- Do not hardcode assumptions that only one source file or only official
  content exists.

## Testing Expectations

Use `flutter_test` for unit and widget coverage.

Write tests whenever you change:

- domain rules
- validation logic
- repository behavior
- Drift tables, queries, or migrations
- XML or compendium ingestion behavior
- UI flows with meaningful state transitions

Testing expectations:

- Name test files with the `_test.dart` suffix.
- Mirror the production area under test when choosing test locations.
- Prefer behavior-focused test names.
- Cover both happy paths and edge cases for character rules.
- For persistence changes, test read/write behavior and migration safety.
- For calculated character outputs, verify derived values from canonical inputs
  rather than asserting on implementation details.

Do not ship schema or rule changes without tests unless the repository already
has an explicit, documented gap that prevents it.

## Documentation & Session Continuity

Documentation is part of the deliverable.

Update the relevant docs when behavior, scope, or architecture changes. At a
minimum, keep these files current when implementation meaningfully changes the
project state:

- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`

Also update related documents when applicable:

- `docs/specs/` for feature or screen behavior changes
- `docs/architecture/` for structural or cross-cutting design changes
- `docs/adr/` for decisions that deserve a durable architectural record

Do not let the code and the project narrative drift apart.

## Agent Roles

Use these roles as operating modes. A task may involve more than one role, but
each role has clear ownership boundaries.

### Agent: Architect

Focus:

- system design
- feature boundaries
- long-term extensibility
- dependency direction and layering

Use when:

- a task changes module boundaries
- a feature crosses multiple layers or features
- a new abstraction, workflow, or integration is needed
- the existing design is creating coupling or duplication

Must enforce:

- clean architecture boundaries
- feature-first organization
- extensibility for future rules/content sources
- low coupling between UI, rules, and persistence

Do not:

- solve architectural problems by pushing complexity into widgets
- introduce shortcuts that bind domain rules to Drift or Flutter

### Agent: Data Modeler

Focus:

- Drift schema design
- repository persistence shape
- relationships and canonical storage
- migration safety

Use when:

- tables or queries change
- repository contracts need persistence support
- XML or compendium data needs storage mapping

Must enforce:

- no duplicated canonical data
- no storage of avoidable derived values
- extensible schema choices for SRD and homebrew inputs
- clear separation between storage models and domain models

Do not:

- encode business rules in schema hacks
- make schema decisions based only on one current XML source

### Agent: Rules Engine

Focus:

- D&D 5e character logic
- level progression
- derived combat, spell, and sheet calculations
- domain validation and consistency

Use when:

- a task affects character rules
- derived values become incorrect or incomplete
- input validation depends on D&D logic

Must enforce:

- SRD-aligned behavior where applicable
- deterministic calculations
- framework-agnostic rule logic
- zero direct coupling to UI and database details

Do not:

- place calculations in widgets
- rely on persistence-specific fields for correctness

### Agent: Flutter UI

Focus:

- screen behavior
- widget composition
- presentation state
- responsive and maintainable user flows

Use when:

- creating or changing screens
- refining navigation and interaction flows
- presenting domain/application outputs to the user

Must enforce:

- no business logic in widgets
- use of application/domain outputs instead of re-deriving rules in UI
- clear state transitions and readable presentation code

Do not:

- bypass application services to reach into persistence directly
- duplicate character calculation logic for display convenience

### Agent: Reviewer

Focus:

- code quality
- architectural compliance
- regression risk
- missing tests and edge cases

Use when:

- validating a proposed or completed change
- reviewing for maintainability and correctness
- checking whether a cross-layer change broke constraints

Must check:

- separation of layers
- scalability risks
- missing edge cases
- inadequate test coverage
- contradictions between docs and implementation

Do not:

- limit review to style issues when logic or architecture risk exists

## Task Routing / Decision Rules

Route work by the dominant concern:

- Schema, queries, Drift migrations, repository persistence shape:
  `Data Modeler`
- D&D logic, validation rules, derived character behavior:
  `Rules Engine`
- Screens, widgets, visual state, navigation behavior:
  `Flutter UI`
- Cross-feature design, boundaries, abstractions, extensibility:
  `Architect`
- Validation, regression analysis, architectural review:
  `Reviewer`

For mixed tasks:

- start with the role that owns the hardest constraint
- keep ownership boundaries explicit
- coordinate through contracts, not by bypassing layers

Default tie-breakers:

- If the change affects correctness of character logic, prioritize
  `Rules Engine`.
- If the change affects long-term structure, prioritize `Architect`.
- If the change affects storage shape or migration safety, prioritize
  `Data Modeler`.
- If the change is mostly view composition, prioritize `Flutter UI`.
- If uncertainty remains, use `Reviewer` to validate the final shape against
  repository constraints.

## Promptineer Delegation Policy

Treat Promptineer as a delegation-enhancement layer, not as a standalone
delivery phase.

Use Promptineer before handing work to another agent when the delegated task
would benefit from sharper instructions, tighter constraints, or a more
structured output contract.

Preferred flow:

1. Orchestrator understands the user goal.
2. Promptineer rewrites or strengthens the delegation prompt.
3. The target agent executes the improved prompt.

Apply Promptineer when one or more of these are true:

- the task is ambiguous or underspecified
- the task crosses multiple layers or features
- architectural or layering constraints must be enforced explicitly
- ownership, file scope, or acceptance criteria need to be clarified
- a prior delegation produced weak, incomplete, or overly broad results
- the task needs a strict output schema for easier review or synthesis

Promptineer output should strengthen the delegated prompt with:

- a clear objective
- explicit scope and non-goals
- relevant architectural and product constraints
- file or module ownership when applicable
- acceptance criteria
- expected output structure
- known risks or failure modes

Do not invoke Promptineer for trivial, mechanical, or already well-scoped
delegations where the extra prompt pass would add cost without improving
quality.
