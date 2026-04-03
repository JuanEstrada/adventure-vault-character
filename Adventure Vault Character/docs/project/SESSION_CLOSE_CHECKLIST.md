# Session Close Checklist

Use this checklist to close a session and leave the repository ready for the
next one.

Policy note: follow `docs/README.md` as the canonical documentation policy.

## 1. During the Session (If Real State Changes)

Review whether these need updates:

- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `README.md`
- `docs/README.md`
- `docs/project/README.md`
- any file under `docs/specs/`
- any file under `docs/architecture/`
- any file under `docs/adr/`

Update documentation when these change:

- implemented flow
- current repository state
- recommended next step
- newly accepted decisions
- newly created files or modules
- pending work that no longer applies
- any durable finding discovered during the session

Do not update by inertia:

- do not rewrite documents only for style changes
- do not duplicate information if a source-of-truth doc already exists
- do not change specs without a real product decision
- do not copy transient external notes into repo docs unless they are promoted
  as durable knowledge

## 2. Verify the Work

- run the required checks
- review `git diff`
- confirm documentation is not out of sync

## 3. Update Documentation

Update at minimum:

- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`

Also update any README, spec, architecture doc, or ADR made obsolete by
session changes.

## 4. Leave the Next Step Clear

In `docs/project/SESSION_RESUME.md`, record:

- what was completed
- what comes next
- which files are the source of truth to continue

## 5. Save the Work

```bash
git status --short
git add <files>
git commit -m "clear message"
# push only if it matches the current branch workflow
git push <remote> <branch>
```

## 6. Expected Closure

Before ending the session:

- the repo should be clean or have explicit intentional changes
- documentation should match the real code state
- the next work block should be clear

## 7. Memory and Promotion Hygiene

- Keep transient session notes outside the repo.
- Promote stable decisions/findings into the correct repo doc.
- Ensure promoted content is in English and does not duplicate an existing
  source of truth.
