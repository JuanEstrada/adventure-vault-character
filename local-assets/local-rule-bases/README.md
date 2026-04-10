# Local Rule Bases

This folder documents the local rule-source references used to support
compendium extraction, deterministic rules work, and future import decisions.

It is not an implementation contract. It is an operational reference that
clarifies:

- which local sources already exist,
- which data is already useful,
- which catalogs/rules still need extraction,
- and which source should be treated as the best available baseline per area.

## Current Local Sources

### 1) FightClub SRD 5.5e XML

Path:

- `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/`

Use:

- primary structured source for runtime compendium extraction
- current baseline for `backgrounds`, `races`, `classes`, `spells`, `feats`,
  and `monsters`

### 2) Wizards-of-the-Coast XML Supplements

Path:

- `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/`

Use:

- wider official XML coverage beyond SRD-only scope
- especially relevant for narrative-option expansions and settings-specific data

### 3) SRD Markdown Reference

Path:

- `local-assets/dnd-5e-srd-markdown-master/`

Use:

- semantic cross-checks for extracted rules
- text-level consistency checks for deterministic rule implementation

### 4) Source Document References

Path:

- `local-assets/reference/source_documents/`

Use:

- manual verification reference when extraction results look ambiguous

## Recommended Source Priority

1. FightClub SRD 5.5e XML for structured runtime extraction
2. Official Wizards XML supplements for broader non-SRD catalogs
3. SRD Markdown for semantic validation and wording checks
4. Source-document references for manual review

## Known Gaps

- Narrative finishing-details catalogs still require broader official extraction
  policy decisions.
- Source precedence between 5e and 5.5e materials is not fully closed.
- Several future systems (deeper inventory rules, advanced combat/resource
  behavior) still need normalized extraction plans.

## Next Recommended Extraction Slice

1. Expand narrative-option extraction from official XML supplements.
2. Keep extraction behind compendium boundaries (no widget-local parsing).
3. Define explicit precedence policy for overlapping 5e/5.5e sources.
4. Add regression coverage for new extracted categories and filters.
