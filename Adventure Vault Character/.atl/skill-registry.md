# Skill Registry

**Delegator use only.** Any agent that launches sub-agents reads this registry to resolve compact rules, then injects them directly into sub-agent prompts. Sub-agents do NOT read this registry or individual SKILL.md files.

See `_shared/skill-resolver.md` for the full resolution protocol.

## User Skills

| Trigger | Skill | Path |
|---------|-------|------|
| When creating a pull request, opening a PR, or preparing changes for review. | branch-pr | /home/mocy/.config/opencode/skills/branch-pr/SKILL.md |
| Architecture and design review for specified files/dirs/repo. | review-codebase | /home/mocy/.agents/skills/review-codebase/SKILL.md |
| Debug or fix failing GitHub PR checks that run in GitHub Actions. | gh-fix-ci | /home/mocy/.agents/skills/gh-fix-ci/SKILL.md |
| Generate high-quality Product Requirements Documents (PRDs). | prd | /home/mocy/.agents/skills/prd/SKILL.md |
| Create Mermaid diagrams and validate/render them locally. | mermaid | /home/mocy/.agents/skills/mermaid/SKILL.md |
| Generate Excalidraw diagrams from natural language descriptions. | excalidraw-diagram-generator | /home/mocy/.agents/skills/excalidraw-diagram-generator/SKILL.md |
| Expert-level browser automation, debugging, and performance analysis. | chrome-devtools | /home/mocy/.agents/skills/chrome-devtools/SKILL.md |
| Comprehensive project architecture blueprint generation. | architecture-blueprint-generator | /home/mocy/.agents/skills/architecture-blueprint-generator/SKILL.md |
| Create C4 architecture documentation and diagrams. | c4-architecture | /home/mocy/.agents/skills/c4-architecture/SKILL.md |
| Flutter app architecture and implementation guidance. | flutter | /home/mocy/.agents/skills/flutter/SKILL.md |
| Flutter + Drift/SQLite persistence patterns. | flutter-drift | /home/mocy/.agents/skills/flutter-drift/SKILL.md |
| Flutter testing patterns and test strategy. | flutter-testing | /home/mocy/.agents/skills/flutter-testing/SKILL.md |
| Flutter clean architecture patterns. | flutter-clean-arch | /home/mocy/.agents/skills/flutter-clean-arch/SKILL.md |
| Clean architecture and boundary enforcement. | clean-architecture | /home/mocy/.agents/skills/clean-architecture/SKILL.md |
| Review code changes and identify risks. | code-review | /home/mocy/.agents/skills/code-review/SKILL.md |
| Discover installable skills and recommend relevant ones. | find-skills | /home/mocy/.agents/skills/find-skills/SKILL.md |
| Create GitHub issues using repo conventions. | issue-creation | /home/mocy/.config/opencode/skills/issue-creation/SKILL.md |
| Dual adversarial review by parallel judges. | judgment-day | /home/mocy/.config/opencode/skills/judgment-day/SKILL.md |
| Create or update skills. | skill-creator | /home/mocy/.config/opencode/skills/skill-creator/SKILL.md |
| Install Codex skills from curated lists or GitHub repos. | skill-installer | /home/mocy/.codex/skills/.system/skill-installer/SKILL.md |
| OpenAI docs lookup from official sources. | openai-docs | /home/mocy/.codex/skills/.system/openai-docs/SKILL.md |
| Generate or edit raster images. | imagegen | /home/mocy/.codex/skills/.system/imagegen/SKILL.md |
| Scaffold Codex plugins. | plugin-creator | /home/mocy/.codex/skills/.system/plugin-creator/SKILL.md |

## Compact Rules

### branch-pr
- Every PR must link an approved issue before opening.
- Use exactly one `type:*` label on each PR.
- Branches must follow `type/description` lowercase naming.
- Run relevant checks before merge and respect PR template requirements.
- Use for branch prep, PR creation, and review-ready changes.

### review-codebase
- Review current state of files/dirs/repo, not just diffs.
- Cover architecture, boundaries, patterns, tech debt, dependencies, security, and performance.
- Every finding should cite specific file:line references when possible.
- Organize large-scope reviews by layer/module and prioritize actionable issues.
- Use when auditing a module or the full repository.

### gh-fix-ci
- Use `gh` to inspect failing GitHub Actions checks and logs.
- Verify `gh auth status` first; ask user to authenticate if needed.
- Summarize failing checks and propose a fix plan before implementing.
- Treat non-GitHub Actions providers as out of scope; report only details URL.
- Re-run or suggest rechecking checks after fixes.

### prd
- Start with discovery questions; do not draft PRDs from assumptions.
- Define problem, solution, measurable success criteria, scope, and non-goals.
- Prefer concrete, testable requirements over vague adjectives.
- Use PRD as product/business layer, not a replacement for implementation specs.
- Best for early feature framing and stakeholder alignment.

### mermaid
- Return Mermaid in fenced markdown blocks.
- Choose the appropriate diagram type before drafting.
- Keep diagrams compact and readable for markdown renderers.
- Validate or render locally when needed instead of relying on web services.
- Prefer Mermaid for lightweight architecture and flow documentation.

### excalidraw-diagram-generator
- Convert natural-language requests into `.excalidraw` JSON files.
- Pick diagram type first: flowchart, architecture, ER, sequence, etc.
- Limit complexity; split oversized diagrams into smaller ones.
- Use consistent spacing, colors, and readable text sizing.
- Best for editable visual docs beyond Mermaid.

### chrome-devtools
- Use snapshot-first to identify elements before interacting.
- Prefer console + network inspection when troubleshooting pages.
- Use performance tracing for browser-side bottlenecks.
- Useful for screenshots, form interaction, and browser debugging.
- Most relevant for Flutter Web or browser-based UI workflows.

### architecture-blueprint-generator
- Analyze the actual codebase before documenting architecture.
- Document implemented layers, boundaries, dependencies, and extension points.
- Generate high-level plus component-level views grounded in real structure.
- Use to produce a reusable architecture reference, not ad-hoc notes.
- Good for onboarding and keeping architectural consistency.

### c4-architecture
- Use C4-style diagrams and descriptions for system/container/component views.
- Keep diagrams aligned with actual code structure and dependencies.
- Prefer concise architecture explanations with clear boundaries.
- Combine well with Mermaid for markdown-native architecture docs.
- Use when documenting architecture, modules, and interactions.

### flutter
- Preserve existing Flutter project structure and patterns.
- Prefer idiomatic Dart/Flutter, null safety, and strong typing.
- Reuse existing app architecture and state-management conventions.
- Keep widgets/components focused and composable.
- Use for feature work, refactors, and architecture guidance.

### flutter-drift
- Keep Drift schema, DAOs, queries, and migrations synchronized.
- Favor clear repository/DAO boundaries over embedding SQL everywhere.
- Validate schema changes with migration-aware tests.
- Respect platform-specific Drift setup (native/web) already in use.
- Use for persistence, local DB modeling, and migration work.

### flutter-testing
- Prefer targeted unit/widget tests for the behavior being changed.
- Keep tests deterministic and focused on user-visible behavior.
- Cover critical state transitions, validation, and repository behavior.
- Add integration-style coverage only when unit/widget tests are insufficient.
- Use when adding or fixing tests across Flutter layers.

### flutter-clean-arch
- Separate presentation, application, domain, and data responsibilities.
- Keep dependencies flowing inward toward domain logic.
- Prefer use-cases/services for orchestration over bloated widgets/repositories.
- Use to maintain clean boundaries in Flutter-specific code organization.
- Best for larger feature design or refactors.

### clean-architecture
- Enforce boundaries between layers and avoid cross-layer leakage.
- Keep business rules independent from frameworks and UI details.
- Prefer abstractions at boundaries and explicit dependency direction.
- Use to audit or design system structure and module responsibilities.
- Complements project-specific Flutter architecture patterns.

### code-review
- Review diffs for correctness, regressions, clarity, and maintainability.
- Prioritize actionable issues over style nitpicks.
- Highlight risks, missing tests, and boundary violations.
- Use before PRs or when validating significant code changes.
- Complements broader repo audits from review-codebase.

### find-skills
- Check leaderboard/search results before recommending skills.
- Verify quality by source reputation and install popularity when possible.
- Don’t recommend skills solely from a name; inspect summary/usefulness first.
- Offer install commands and explain why the skill fits the task.
- Use when extending capabilities or searching for missing workflows.

### issue-creation
- Use issue templates; blank issues are not allowed.
- Search for duplicates before filing new issues.
- Make required fields complete and accurate.
- Respect approval workflow before PR work starts.
- Use for repo issue creation and triage.

### judgment-day
- Launch two parallel blind judges for adversarial review.
- Use the skill registry to inject project standards into judge prompts first.
- Synthesize both verdicts yourself; don’t review in place as orchestrator.
- Fix confirmed issues, then re-judge up to two iterations.
- Best for high-confidence review before merge.

### skill-creator
- Create/update skills with clear triggers, constraints, and actionable rules.
- Keep instructions concise, reusable, and directly applicable.
- Prefer explicit workflows and examples over vague guidance.
- Use when encoding repeatable agent behaviors into skills.
- Avoid bloated or redundant skill definitions.

### skill-installer
- Use provided install/list scripts rather than ad-hoc cloning when possible.
- Prefer curated or explicit GitHub sources.
- Restart Codex after installing a skill.
- Use when the user wants to add new skills from repos or curated lists.
- Do not reinstall preinstalled system skills unless explicitly requested.

### openai-docs
- Use official OpenAI docs sources first.
- Cite docs precisely and avoid speculation.
- Restrict fallback browsing to official OpenAI domains.
- Use for model selection, API usage, and up-to-date OpenAI guidance.
- Treat current docs as authoritative over cached references.

### imagegen
- Use the built-in image tool by default, not custom scripts.
- Save project-bound image outputs into the workspace before finishing.
- Don’t overwrite existing assets unless the user asked for replacement.
- Use for raster images, mockups, textures, or concept visuals.
- Avoid using it for SVG/vector/code-native assets.

### plugin-creator
- Scaffold plugins with required metadata and baseline structure.
- Reuse the provided script/template flow instead of manual scaffolding.
- Keep plugin names normalized and metadata complete.
- Use when creating or updating local Codex plugins.
- Generate marketplace entries only when relevant.

## Project Conventions

| File | Path | Notes |
|------|------|-------|
| AGENTS.md | /home/mocy/projects/adventure-vault-character/Adventure Vault Character/AGENTS.md | Project conventions and completion checklist |

Read the convention files listed above for project-specific patterns and rules. All referenced paths have been extracted — no need to read index files to discover more.
