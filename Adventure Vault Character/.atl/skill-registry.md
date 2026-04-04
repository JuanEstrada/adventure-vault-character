# Skill Registry

**Delegator use only.** Any agent that launches sub-agents reads this registry to resolve compact rules, then injects them directly into sub-agent prompts. Sub-agents do NOT read this registry or individual SKILL.md files.

## User Skills

| Trigger | Skill | Path |
|---------|-------|------|
| When the user wants functionality that may exist as an installable skill | find-skills | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\.agents\skills\find-skills\SKILL.md` |
| Prompt design, prompt refactoring, prompt comparison, or lightweight evals | promptineer-evals | `C:\Users\Mocy\.config\opencode\skills\promptineer-evals\SKILL.md` |
| Creating a GitHub issue, reporting a bug, or requesting a feature | issue-creation | `C:\Users\Mocy\.config\opencode\skills\issue-creation\SKILL.md` |
| Creating a pull request, opening a PR, or preparing changes for review | branch-pr | `C:\Users\Mocy\.config\opencode\skills\branch-pr\SKILL.md` |
| Creating a new AI skill, agent instructions, or reusable AI workflow docs | skill-creator | `C:\Users\Mocy\.config\opencode\skills\skill-creator\SKILL.md` |
| Writing Go tests, teatest/Bubbletea TUI tests, or adding Go test coverage | go-testing | `C:\Users\Mocy\.config\opencode\skills\go-testing\SKILL.md` |
| User explicitly asks for judgment day / dual adversarial review | judgment-day | `C:\Users\Mocy\.config\opencode\skills\judgment-day\SKILL.md` |
| Mermaid flowcharts, sequence/state diagrams, or Mermaid validation/rendering | mermaid | `C:\Users\Mocy\.agents\skills\mermaid\SKILL.md` |
| Creating or updating a README.md or broad project documentation | readme | `C:\Users\Mocy\.agents\skills\readme\SKILL.md` |
| Generating or editing raster images and bitmap assets | imagegen | `C:\Users\Mocy\.agents\skills\imagegen\SKILL.md` |
| Flutter apps that need Drift-based local persistence | flutter-drift | `C:\Users\Mocy\.agents\skills\flutter-drift\SKILL.md` |
| Visually strong landing page, website, app, prototype, demo, or game UI | frontend-skill | `C:\Users\Mocy\.agents\skills\frontend-skill\SKILL.md` |
| Structuring or refactoring a Flutter app for scalable layered architecture | flutter-architecting-apps | `C:\Users\Mocy\.agents\skills\flutter-architecting-apps\SKILL.md` |
| Flutter routing, nested navigation, or deep-linkable flows | flutter-implementing-navigation-and-routing | `C:\Users\Mocy\.agents\skills\flutter-implementing-navigation-and-routing\SKILL.md` |
| Flutter shared state, app state, or complex UI state transitions | flutter-managing-state | `C:\Users\Mocy\.agents\skills\flutter-managing-state\SKILL.md` |
| Android Kotlin development with Coroutines, Compose, Hilt, and MockK | android-kotlin | `C:\Users\Mocy\.agents\skills\android-kotlin\SKILL.md` |
| Kotlin, Flow, Compose, KMP, Ktor, or idiomatic Kotlin DSL work | kotlin-specialist | `C:\Users\Mocy\.agents\skills\kotlin-specialist\SKILL.md` |
| Comprehensive architecture documentation using arc42 | arc42-documentation | `C:\Users\Mocy\.agents\skills\arc42-documentation\SKILL.md` |
| Writing Architecture Decision Records with MADR | adr-writing | `C:\Users\Mocy\.agents\skills\adr-writing\SKILL.md` |
| Docs-as-code workflow, docs pipeline automation, or docs tooling guidance | docs-as-code | `C:\Users\Mocy\.agents\skills\docs-as-code\SKILL.md` |
| Markdown docs, GitHub Flavored Markdown, or README formatting | markdown-documentation | `C:\Users\Mocy\.agents\skills\markdown-documentation\SKILL.md` |
| Turning an epic feature into a focused PRD | breakdown-feature-prd | `C:\Users\Mocy\.agents\skills\breakdown-feature-prd\SKILL.md` |
| Writing a full PRD for software systems or AI-powered features | prd | `C:\Users\Mocy\.agents\skills\prd\SKILL.md` |
| C4 system context, container, component, dynamic, or deployment diagrams | c4-architecture | `C:\Users\Mocy\.agents\skills\c4-architecture\SKILL.md` |
| Creating, editing, analyzing, or formatting spreadsheets | spreadsheet | `C:\Users\Mocy\.agents\skills\spreadsheet\SKILL.md` |
| Explicit security review, secure-by-default coding help, or security best practices guidance | security-best-practices | `C:\Users\Mocy\.agents\skills\security-best-practices\SKILL.md` |
| Reading, creating, or reviewing PDFs where rendering matters | pdf | `C:\Users\Mocy\.agents\skills\pdf\SKILL.md` |
| Reading, creating, or editing DOCX files where layout matters | doc | `C:\Users\Mocy\.agents\skills\doc\SKILL.md` |

## Compact Rules

Pre-digested rules per skill. Delegators copy matching blocks into sub-agent prompts as `## Project Standards (auto-resolved)`.

### find-skills
- Use this only when the user is asking for a capability that may already exist as an installable skill.
- Check the `skills.sh` leaderboard before CLI search when the domain is common.
- Verify quality before recommending: prefer high installs, reputable publishers, and solid source repos.
- Present install count, source, install command, and learning link together.
- If no skill fits, say so clearly and offer to do the task directly.

### promptineer-evals
- Use only for prompt authoring, refactoring, comparison, portability, or lightweight eval design.
- Keep prompt-memory persistence isolated to project `promptineer-memory` with topic keys prefixed `promptineer/`.
- Do not write prompt learnings into the active project memory unless the user explicitly asks.
- Return structured prompt outputs: system prompt, user template, constraints, output format, assumptions, and risks.
- For non-trivial prompts, also include rubric, test cases, pass conditions, failure modes, and manual review checklist.

### issue-creation
- Never create a blank issue; always use the repository template.
- Search for duplicates before opening a new issue.
- Questions belong in Discussions, not Issues.
- Every new issue starts as `status:needs-review`; no PR should be opened until maintainers add `status:approved`.
- Fill all required template fields and keep the issue concrete and reproducible.

### branch-pr
- Every PR must link one approved issue and carry exactly one `type:*` label.
- Branch names must follow `type/description` in lowercase with only `a-z0-9._-`.
- Use conventional commits only; never add `Co-Authored-By` trailers.
- Build the PR body from the template: linked issue, one PR type, summary bullets, changes table, and test plan.
- If issue linkage or approval is missing, stop and resolve that first.

### skill-creator
- Create a skill only for reusable, non-trivial patterns that AI needs repeatedly.
- Follow the standard skill structure with `SKILL.md` plus optional `assets/` and `references/`.
- Frontmatter must be complete and the description must include trigger text.
- Keep examples minimal and focused; reference local docs instead of duplicating them.
- After creation, register the skill in the project instructions/index.

### go-testing
- Default to table-driven tests for pure logic and multiple cases.
- Test Bubbletea state transitions directly through `Model.Update()` before heavier integration tests.
- Use `teatest` for full TUI flows and golden files for rendered output.
- Cover success, error, and edge cases explicitly; use `t.TempDir()` for filesystem work.
- Mock side effects and avoid coupling tests to unneeded runtime behavior.

### judgment-day
- Resolve project skills first: use the registry and inject only matching compact rules into every judge/fix prompt.
- Never review inline as the orchestrator; launch two blind judges in parallel.
- Synthesize findings by confidence: confirmed, suspect, or contradiction.
- Treat only confirmed CRITICAL and real WARNING issues as blockers; theoretical warnings are INFO.
- Ask the user before fixing confirmed issues, then re-judge after fixes as required.

### mermaid
- Pick the diagram type from the request: flowchart, sequenceDiagram, or stateDiagram-v2.
- Return valid fenced `mermaid` blocks and keep diagrams compact and readable.
- Validate with the bundled validator script before finalizing when verification matters.
- Render locally with Mermaid CLI when the user wants an image file; prefer SVG.
- Never depend on a web service for Mermaid rendering.

### readme
- Explore the codebase deeply before writing; do not document blindly.
- Cover local development, system understanding, and deployment in the README.
- Detect configuration, entry points, dependencies, scripts, database, and deployment targets from the repo.
- Ask questions only when critical context cannot be inferred from the repository.
- Prefer a thorough, operational README over a marketing summary.

### imagegen
- Use the built-in image generation flow by default; CLI fallback is explicit-only.
- Never switch to the CLI automatically and never modify the bundled image script.
- For project-bound assets, move/copy the final image into the workspace; do not leave it only in the default tool output area.
- Preserve invariants aggressively for edits and save non-destructively unless replacement was requested.
- Use raster generation only when the task truly calls for bitmap output, not repo-native SVG/code assets.

### flutter-drift
- Use Drift as a type-safe, reactive persistence layer and keep setup aligned with Flutter platform needs.
- Prefer streams/watch queries for UI reactivity rather than manual refresh plumbing.
- Use in-memory databases for tests and cover migrations when schema changes.
- Regenerate code with build_runner after schema updates; never hand-edit generated files.
- Keep database concerns in persistence/data layers, not in UI widgets.

### frontend-skill
- Start from composition, hierarchy, and one dominant visual idea before choosing components.
- Default to restrained layouts: few typefaces, one accent color, minimal chrome, and no card soup.
- Make the first viewport strong: clear brand/product, one anchor visual, one primary action.
- Use intentional motion sparingly to improve hierarchy, not to add noise.
- Reject generic SaaS grids, weak branding, busy imagery behind text, and filler copy.

### flutter-architecting-apps
- Enforce separation of concerns across UI, Logic, and Data layers.
- Keep widgets lean and move business/data orchestration out of the widget tree.
- Treat repositories as the single source of truth and services as stateless external wrappers.
- Prefer immutable state and unidirectional data flow.
- Build features in order: domain models, services, repositories, view-models, then views.

### flutter-implementing-navigation-and-routing
- Use imperative `Navigator` only for simple flows without deep-link complexity.
- Prefer declarative routing such as `go_router` for deep linking, web URL sync, and larger route graphs.
- Avoid named routes as the default approach.
- Pass data through typed constructors or route settings explicitly; await returned results from `pop` when needed.
- Use nested navigators with `PopScope` for multi-step subflows.

### flutter-managing-state
- Distinguish ephemeral widget state from shared app state before choosing an approach.
- Use `setState()` only for local UI-only state.
- Use MVVM plus Provider/ChangeNotifier for shared state and complex flows.
- Keep repositories as the single source of truth and view-models responsible for presentation state.
- Rebuild only the necessary widget subtrees and verify `notifyListeners()` paths.

### android-kotlin
- Keep a clean separation between data, domain, DI, and UI packages.
- Use Coroutines/Flow for async work, Compose for UI, and Hilt for dependency injection.
- Prefer Room/Repository patterns and explicit dispatcher control for I/O.
- Test with MockK, coroutine test utilities, and Compose/UI test tooling as appropriate.
- Keep modern Gradle Kotlin DSL and structured architecture as the default.

### kotlin-specialist
- Use structured concurrency; never use `GlobalScope` and avoid `runBlocking` in production code.
- Prefer sealed classes for state and explicit null-safety patterns.
- Use `suspend` and `Flow` idiomatically and verify cancellation handling on teardown.
- Run `detekt` and `ktlint` before considering Kotlin work complete.
- Keep platform-specific code out of common/shared modules.

### arc42-documentation
- Use todo tracking for the multi-step documentation workflow.
- Create arc42 docs under `docs/architecture/arc42/` and fill all 12 sections, marking gaps as `TBD` if needed.
- Base content on real repo/user evidence; never invent requirements or constraints.
- Include Mermaid diagrams for context/building blocks/deployment where useful.
- Update the documentation index to point to the new arc42 artifact.

### adr-writing
- Always start ADR files with valid YAML frontmatter including at least `status` and `date`.
- Follow the MADR structure and fill sections from verified decision context.
- Explore related code, existing ADRs, and discussion sources before writing.
- Apply the E.C.A.D.R. quality checklist and mark missing facts as explicit investigation prompts.
- Use zero-padded sequential filenames with slugified titles.

### docs-as-code
- Treat documentation as versioned engineering work with review, testing, and CI/CD concerns.
- Prefer repo-native docs workflows and automation over ad-hoc documents.
- Verify current tooling guidance before prescribing Docusaurus/MkDocs/Sphinx/etc.
- Build docs structure, linting, and deployment thinking into the plan from the start.
- Keep docs changes reviewable and maintainable alongside code.

### markdown-documentation
- Use standard Markdown/GFM with clear headings, descriptive links, and code fences with language tags.
- Keep long docs scannable with tables of contents, sections, and semantic line breaks.
- Prefer relative links for local docs and add alt text to images.
- Avoid walls of text, vague link text, and unnecessary HTML/Markdown mixing.
- Keep formatting readable and consistent.

### breakdown-feature-prd
- Turn a high-level feature into a focused PRD tied back to its parent epic.
- Write concrete user stories, requirements, acceptance criteria, and out-of-scope items.
- Keep the PRD anchored in problem, solution, and measurable impact.
- Cover primary flows and edge cases, not just the happy path.
- Save the feature PRD in the expected planning path structure.

### prd
- Never write a PRD without discovery; ask clarifying questions first when critical context is missing.
- Use measurable, testable requirements instead of vague adjectives.
- Follow the strict PRD structure: executive summary, UX/functionality, AI requirements if applicable, technical specs, and risks/roadmap.
- Define non-goals explicitly to control scope.
- Include testing/evaluation strategy, especially for AI behavior.

### c4-architecture
- Start with Context and Container diagrams; only add deeper levels when they add real value.
- Use valid Mermaid C4 syntax with named elements, technology labels, and action-oriented relationships.
- Keep diagrams under control: focused scope, under ~20 elements, one abstraction level per diagram.
- Avoid mixing containers with components or inventing new abstraction layers.
- Add short explanatory context around diagrams, not diagrams in isolation.

### spreadsheet
- Use `openpyxl` for `.xlsx` structure/format preservation and `pandas` for analysis/CSV workflows.
- Prefer formulas for derived values and keep formulas simple, robust, and non-volatile when possible.
- Recalculate/render for visual review before delivery when tooling is available.
- Preserve existing formatting exactly unless the user explicitly requests a redesign.
- Keep final artifacts stable and clean up temporary spreadsheet outputs.

### security-best-practices
- Trigger this only for explicit security guidance/review requests, not for general debugging.
- Identify the real language/framework stack first and load only relevant security guidance.
- Prioritize high-impact findings and report them with severity, rationale, and line references.
- Fix one finding at a time and consider regression risk before changing behavior.
- Do not over-report TLS/HSTS advice blindly; respect deployment context and project overrides.

### pdf
- Prefer visual review by rendering pages before delivering PDF work.
- Use `reportlab` for generation and `pdfplumber`/`pypdf` for extraction checks, not layout truth.
- Re-render after meaningful changes and inspect spacing, clipping, legibility, and page polish.
- Keep outputs organized in stable paths and clean up intermediates when done.
- Do not ship PDFs with visual defects or placeholder artifacts.

### doc
- Prefer visual review for DOCX work by converting/rendering pages whenever possible.
- Use `python-docx` for structured edits and creation, not manual binary hacking.
- Re-render after meaningful changes and call out layout risk if visual review is impossible.
- Keep temp artifacts organized and final documents polished and client-ready.
- Do not leave broken tables, clipped text, unreadable characters, or default-template junk.

## Project Conventions

| File | Path | Notes |
|------|------|-------|
| AGENTS.md | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\AGENTS.md` | Index — primary project rules and architecture constraints |
| analysis_options.yaml | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\analysis_options.yaml` | Referenced by AGENTS.md for linting/style compliance |
| app bootstrap | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\lib\src\app\` | Referenced by AGENTS.md |
| shared core | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\lib\src\core\` | Referenced by AGENTS.md |
| feature slices | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\lib\src\features\` | Referenced by AGENTS.md |
| feature application layer | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\lib\src\features\<feature>\application\` | Referenced by AGENTS.md |
| feature domain layer | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\lib\src\features\<feature>\domain\` | Referenced by AGENTS.md |
| feature data layer | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\lib\src\features\<feature>\data\` | Referenced by AGENTS.md |
| feature presentation layer | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\lib\src\features\<feature>\presentation\` | Referenced by AGENTS.md |
| tests | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\test\` | Referenced by AGENTS.md |
| runtime assets | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\assets\` | Referenced by AGENTS.md |
| local XML assets | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\local-assets\` | Referenced by AGENTS.md |
| specs docs | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\docs\specs\` | Referenced by AGENTS.md |
| architecture docs | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\docs\architecture\` | Referenced by AGENTS.md |
| ADR docs | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\docs\adr\` | Referenced by AGENTS.md |
| project docs | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\docs\project\` | Referenced by AGENTS.md |
| session continuity | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\docs\project\SESSION_RESUME.md` | Must stay current when implementation meaningfully changes state |
| project snapshot | `C:\Users\Mocy\Documents\Playground\Adventure Vault Character\docs\project\PROJECT_SNAPSHOT.md` | Must stay current when implementation meaningfully changes state |

### Project Compact Rules
- Documentation, comments, identifiers, and developer-facing code text must be in English.
- Treat this as an offline-first Flutter + Drift D&D 5e character builder, not a generic CRUD app.
- Preserve strict separation between `domain`, `application`, `data`, and `presentation`.
- Keep D&D rules deterministic, testable, and outside widgets/Drift schema hacks.
- Prefer extending an existing feature slice before creating a new top-level feature.
- Do not store avoidable derived values in persistence; recompute from canonical character state.
- Support both official SRD content and custom XML imports without baking in single-source assumptions.
- Keep widgets thin; presentation depends on application/domain outputs, not direct persistence access.
- Run `flutter analyze` and `flutter test` before closing meaningful implementation work; run build_runner only when persistence/generated models changed.
- Never hand-edit generated files.

Read the convention files listed above for project-specific patterns and rules. All referenced paths have been extracted — no need to read index files to discover more.
