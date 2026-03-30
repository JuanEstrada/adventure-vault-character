# English Normalization Plan

Status: active
Last verified: 2026-03-29

This file freezes the scope for full English normalization (Option C): docs,
internal messages, runtime UI strings, and test assertions.

## Scope Buckets

- `docs_text`: mixed-language labels and terminology in `docs/**`
- `internal_error`: controller/repository/parser messages in `lib/src/**`
- `runtime_ui`: user-visible labels and helper text in presentation widgets
- `test_assertion`: `test/**` expectations bound to text values

## Glossary Baseline

- `Compendium`
- `Create character`
- `Back to menu`
- `Incomplete compendium`
- `Rules`

## Execution Phases

1. Docs normalization
2. Internal/dev-facing message normalization
3. Runtime UI string normalization
4. Test assertion alignment
5. Verify (`flutter analyze`, `flutter test`) and update continuity docs
