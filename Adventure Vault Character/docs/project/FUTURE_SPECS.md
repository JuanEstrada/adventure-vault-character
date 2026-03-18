# Adventure Vault Character – Future Specs

This document captures candidate features that are intentionally outside the
current implementation baseline but should remain visible for future planning.

## FS-001: New Player Help Text

### Summary

Add an optional in-app help mode that shows short explanatory text for new
players while they use the application.

### Goal

Reduce onboarding friction for players who are unfamiliar with Dungeons &
Dragons terminology, character sheets, or common in-session actions.

### Expected Behavior

- The player can enable or disable contextual help text.
- Help text appears near key screens or interactions such as character
  creation, dice rolling, spell management, and inventory updates.
- The feature is additive and should not block experienced players with
  mandatory walkthroughs.
- Help content must remain available offline.

### Notes

- This should be treated as a future usability feature, not part of the
  current architecture baseline.
- A later iteration can decide whether the help is implemented as tooltips,
  inline callouts, or a lightweight onboarding layer.
