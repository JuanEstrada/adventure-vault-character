# ADR-008: Use Compendium and Compendium Import System Terminology

## Status

Accepted

## Context

Adventure Vault Character needs stable terminology for the rules content that
the app consumes and for the subsystem that imports that content from XML.
The project already depends on XML-backed local content and is expected to
support future user-supplied XML files that add or modify classes, races,
backgrounds, spells, equipment, and related rules data.

Without explicit terminology, documentation and implementation discussions can
drift between generic labels such as `XML import`, `rules content`, `catalog`,
or `data pack`, which makes boundaries less clear as the import surface grows.

## Decision

Use `Compendium` as the project term for the imported and queryable game
content set used by the app.

Use `Compendium Import System` as the project term for the subsystem that
validates, parses, maps, normalizes, and stores compendium content from XML
sources.

Treat future uploaded XML files that add or modify rules content as
`compendium packs` handled through the `Compendium Import System`.

## Consequences

Documentation, architecture discussions, and implementation naming should
prefer `Compendium`, `Compendium Import System`, and `compendium pack` over
looser alternatives when referring to these responsibilities.

Future XML ingestion work should remain behind the compendium import boundary
instead of letting screens, widgets, or character features parse uploaded XML
directly.

This decision improves consistency for future schema design, repository
boundaries, and user-facing import features, especially as official SRD data
and custom content packs begin to coexist.
