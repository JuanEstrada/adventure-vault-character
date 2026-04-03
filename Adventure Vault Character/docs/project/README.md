# Project Documentation Index

This directory contains project-state documents used to move from architecture
definition into early implementation.

Policy note: `docs/README.md` is the canonical documentation policy. Keep this
index focused on routing and project-state ownership.

## Documents

| Document | Purpose |
| --- | --- |
| [SESSION_RESUME.md](SESSION_RESUME.md) | Single-file handoff to resume the next work session. |
| [PROJECT_SNAPSHOT.md](PROJECT_SNAPSHOT.md) | Current phase, status, and next recommended steps. |
| [PROJECT_GUIDELINES.md](PROJECT_GUIDELINES.md) | Official product and technical guidelines for proposals and implementation. |
| [ROADMAP.md](ROADMAP.md) | Phase-based delivery direction. |
| [FUTURE_SPECS.md](FUTURE_SPECS.md) | Deferred and future-facing feature candidates. |
| [AI_SESSION_GUIDE.md](AI_SESSION_GUIDE.md) | Canonical session runbook for AI-assisted work. |
| [APP_DISCOVERY_QUESTIONNAIRE.md](APP_DISCOVERY_QUESTIONNAIRE.md) | Short questionnaire to capture app scope, architecture, and prompt usage context. |
| [USER_INPUTS_AND_AUTOMATIC_CALCULATIONS.md](USER_INPUTS_AND_AUTOMATIC_CALCULATIONS.md) | Quick reference for what the app calculates automatically versus what the player must enter or confirm. |
| [SESSION_CLOSE_CHECKLIST.md](SESSION_CLOSE_CHECKLIST.md) | Canonical during-session + close-session checklist. |

## Scope Boundary

- `docs/project/` owns durable project continuity: current status, next steps,
  and operational runbooks.
- Transient session notes should live outside the repo and only be promoted
  here when they become stable, durable project context.

## Recommended Reading Order

1. [SESSION_RESUME.md](SESSION_RESUME.md)
2. [PROJECT_GUIDELINES.md](PROJECT_GUIDELINES.md)
3. [PROJECT_SNAPSHOT.md](PROJECT_SNAPSHOT.md)
4. [ROADMAP.md](ROADMAP.md)
5. [../specs/README.md](../specs/README.md)
6. [FUTURE_SPECS.md](FUTURE_SPECS.md)
