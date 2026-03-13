# 11. Risks and Technical Debt

## Rule Changes Across D&D Versions

Different editions and content variations may redefine core mechanics, spell behavior, modifiers, or data structures. If domain rules are encoded too rigidly, the application may become expensive to adapt.

## XML Schema Evolution

External XML formats may evolve over time or vary across sources. Tight coupling between import logic and a single schema version would increase maintenance cost and import failure risk.

## Synchronization Complexity

Supporting future synchronization and potential real-time interaction with Adventure Vault Master will introduce identity mapping, conflict handling, data ownership, and session consistency concerns.

## Potential Technical Debt Areas

- embedding rules logic inside UI layers
- coupling imported content models directly to persistence entities
- assuming future synchronization will match current local identifiers exactly
- over-optimizing for backend scenarios before the local-first application is mature
