# Hermes Profile Setup Recommendation

## Current State
- **Existing profiles:** Only `default` (~/.hermes)
- **Local model:** `Qwen3.5-4B-Coding` via llama.cpp at `http://127.0.0.1:8080/v1`
- **Skills:** 20+ installed (apple, creative, devops, flutter, gaming, etc.)
- **Gateway:** Running

## Recommendation: MINIMAL 2-PROFILE SETUP

For role-based delegation (coding/light/general/vision), the **smallest useful** setup is:

### Profile 1: `default` (REUSE - DO NOT CREATE)
Already configured and working. Keep as-is.

**Commands to use:**
```bash
hermes chat              # Use default
hermes -p default chat   # Explicit
```

### Profile 2: `coder` (CREATE ONCE)
Clone from default, customize for coding role.

**Exact commands:**
```bash
# Create coder profile from default
hermes profile create coder --clone

# Or minimal clone (just config, not state)
hermes profile create coder --clone-config
```

**Then customize `coder/config.yaml`:**
```yaml
model:
  default: Qwen3.5-4B-Coding
  provider: custom
  base_url: http://127.0.0.1:8080/v1
  api_key: local

agent:
  system_prompt: |
    You are a coding expert. Be concise, provide working code examples,
    explain technical concepts clearly, and use tools when needed.

toolsets:
  - hermes-cli
  - code_execution
  - terminal
  - file
  - skills
  - delegation
  # Enable coding-specific tools

display:
  skin: kawaii
  personality: technical
```

**Set as active:**
```bash
hermes profile use coder
```

## Why This Is Minimal

| Profile | Purpose | Why Not More? |
|---------|---------|---------------|
| `default` | General assistant | Already configured, no need to duplicate |
| `coder` | Coding delegation | Same local router handles all roles |

**No need for more profiles because:**
1. **Single local endpoint** - llama.cpp at 127.0.0.1:8080 handles all roles
2. **Same model** - Qwen3.5-4B-Coding works for all roles
3. **Profiles are isolated HERMES_HOMEs** - each ~1-2GB; duplication is wasteful
4. **Role switching** - just `hermes profile use <role>`

## To Create the Coder Profile

```bash
cd /home/juanestrada/.hermes

# Create from default
hermes profile create coder --clone

# Activate
hermes profile use coder

# Verify
hermes profile list

# Use for coding tasks
hermes chat "Write a Python script for..."
```

## Files Created
- `/home/juanestrada/.hermes/profiles/coder/` (full clone)
- `~/.local/bin/coder` (wrapper script)
- `/home/juanestrada/dev/adventure-vault-character/hermes_profile_recommendation.md` (this file)

## Files to Reuse (DO NOT CREATE)
- `~/.hermes` (default profile) - already exists
- `~/.hermes/config.yaml` - base config
- `~/.hermes/.env` - API keys
- `~/.hermes/skills/` - installed skills

## Summary
**2 profiles minimum:**
1. `default` - reuse existing
2. `coder` - create once with --clone

All other roles (general, vision) can use either profile by adjusting `display.personality` in config.
