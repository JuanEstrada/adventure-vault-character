# Local Rule Bases

Inventario operativo de las bases locales que ya existen para construir reglas,
catálogos y opciones oficiales dentro de la app.

Este archivo no define la implementación final. Sirve para saber:

- qué fuentes locales ya tenemos;
- qué datos ya son aprovechables;
- qué reglas o catálogos siguen faltando;
- y qué fuente conviene usar como origen de verdad para cada área.

## Fecha de corte

- 2026-03-27

## Objetivo

Usar `local-assets/` como base local de trabajo para formalizar reglas de D&D,
catálogos compendium-backed y futuras opciones oficiales del producto, sin
depender de búsquedas externas.

## Bases que ya tenemos

## 1. XML estructurado activo para la app

Ruta principal:

- `local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/`

Estado:

- Es la fuente estructurada activa consumida por la app para compendio local.
- Ya se usa para `backgrounds`, `races`, `classes`, `spells`, `feats` y
  `monsters`.

Sirve hoy para:

- datos compendium-backed de creación;
- clases, razas y backgrounds base;
- hechizos, feats y monstruos SRD;
- futuras extracciones estructuradas cuando el dato exista como XML limpio.

Limitación actual:

- no cubre por sí sola todas las tablas narrativas o variantes de settings
  fuera del SRD base.

## 2. XML amplio de Wizards of the Coast

Rutas:

- `local-assets/FightClub5eXML-master/Sources/DND_5.5e/WizardsOfTheCoast_5.5e/`
- `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/`

Estado:

- Es la mejor base local para buscar material oficial más amplio que el SRD.
- Incluye `backgrounds-*.xml`, settings, aventuras y suplementos.

Sirve hoy para:

- buscar tablas y textos oficiales para `traits`, `ideals`, `bonds` y `flaws`;
- encontrar opciones de `faction` en settings específicos;
- identificar contenido oficial reutilizable para futuras reglas o catálogos.

Hallazgos confirmados:

- `traits / ideals / bonds / flaws` aparecen en backgrounds oficiales de
  `DND_5e/WizardsOfTheCoast`.
- `faction` aparece como dato aprovechable en fuentes como:
  `Sword_Coast_Adventurers_Guide`,
  `Planescape_Adventures_in_the_Multiverse`,
  `Guildmasters_Guide_to_Ravnica`,
  `Eberron_Rising_From_the_Last_War`.

Archivos especialmente útiles:

- `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/01_Core/01_Players_Handbook/backgrounds-phb.xml`
- `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Sword_Coast_Adventurers_Guide/backgrounds-scag.xml`
- `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Planescape_Adventures_in_the_Multiverse/backgrounds-pam.xml`
- `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Guildmasters_Guide_to_Ravnica/backgrounds-ggr.xml`
- `local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Eberron_Rising_From_the_Last_War/backgrounds-erlw.xml`

Estado actual:

- el contenido ya empezó a extraerse y normalizarse hacia tablas internas de
  la app para `traits`, `ideals`, `bonds`, `flaws` y una base inicial de
  `faction`.
- la política final de precedencia y filtrado por contexto sigue pendiente.

## 3. Corpus markdown SRD limpio

Ruta:

- `local-assets/dnd-5e-srd-markdown-master/`

Estado:

- Es la mejor referencia semántica local para leer reglas y definiciones.
- No es un asset runtime de la app.

Sirve hoy para:

- consultar reglas de forma legible;
- verificar definiciones como `alignment`;
- apoyar extracción semántica y validación de reglas.

Ejemplos útiles:

- `character-creation.md`: definición y texto de alignments
- `rules-glossary.md`: definiciones generales
- `classes.md`, `spells.md`, `equipment.md`: soporte semántico para reglas

Limitación actual:

- no reemplaza al XML como fuente estructurada primaria para el runtime.

## 4. Árbol markdown generado por secciones

Ruta:

- `local-assets/por ordenar/srd_55e_source_from_markdown/`

Estado:

- Es una referencia derivada y más fácil de recorrer por secciones.
- Está pensada para consulta local y apoyo a extracción.

Sirve hoy para:

- navegar reglas por bloque temático;
- aislar secciones de `Character Creation`, `Classes`, `Equipment`, `Spells`
  y `Rules Glossary`.

Limitación actual:

- no es la fuente canónica estructurada del app runtime;
- sigue siendo referencia derivada.

## 5. Documentos fuente de validación

Ruta:

- `local-assets/reference/source_documents/`

Archivos clave:

- `srd_cc_v5_2_1.pdf`
- `creating_a_character.docx`
- `dnd_5_5e_srd_info.docx`
- `wiki_xml_format.docx`

Sirven hoy para:

- validar texto fuente;
- entender formato de importación o extracción;
- contrastar decisiones cuando XML y markdown no bastan.

## Qué base usar por tema

| Tema | Base recomendada | Uso |
| --- | --- | --- |
| Razas, clases, backgrounds base | `System_Reference_Document_DND_5.5e/` | Runtime y compendio activo |
| Hechizos, feats, monstruos SRD | `System_Reference_Document_DND_5.5e/` | Runtime y compendio activo |
| Alignments | `dnd-5e-srd-markdown-master/character-creation.md` | Referencia oficial limpia |
| Traits / ideals / bonds / flaws | `DND_5e/WizardsOfTheCoast/.../backgrounds-*.xml` | Extracción oficial pendiente |
| Factions | `backgrounds-scag.xml`, `backgrounds-pam.xml`, `backgrounds-ggr.xml`, `backgrounds-erlw.xml` | Extracción oficial pendiente |
| Definiciones y validación semántica | `dnd-5e-srd-markdown-master/` | Soporte de reglas |
| Texto fuente de validación | `reference/source_documents/` | Validación manual |

## Bases ya utilizables

- Compendio SRD 5.5e estructurado para la creación actual
- Standard Array by Class
- Character Advancement
- Razas, clases, backgrounds, spells, feats y monsters SRD
- Alignments como lista oficial de referencia
- Background XML oficial con material para:
  `personality traits`, `ideals`, `bonds`, `flaws`
- Settings oficiales con material para `faction`

## Qué falta normalizar o extraer

## 1. Catálogo oficial de finishing details narrativos

Base inicial ya normalizada en la app para:

- `personality traits`
- `ideals`
- `bonds`
- `flaws`
- `faction`

Falta decidir:

- si la fuente será solo `PHB` o una mezcla de settings oficiales;
- si las opciones estarán ligadas al `background`;
- si las opciones se mostrarán completas o filtradas por contexto.

## 2. Política de origen de verdad para contenido no SRD

Falta decidir cómo priorizar:

- `System_Reference_Document_DND_5.5e`
- `DND_5e/WizardsOfTheCoast`
- `DND_5.5e/WizardsOfTheCoast_5.5e`

Problema:

- hoy el runtime usa SRD 5.5e, pero las mejores tablas narrativas halladas
  están en `DND_5e/WizardsOfTheCoast`.

## 3. Parser o extractor reutilizable para tablas narrativas

Ya existe una primera extracción consistente para:

- filas numeradas de traits, ideals, bonds y flaws;
- listas de factions;
- referencias por background o setting.

Pendiente:

- ampliar cobertura a más fuentes y variantes;
- decidir filtrado final por background o por setting;
- conectar la salida normalizada con el flujo real de finishing details.

## 4. Reglas futuras no cerradas como catálogo local

Todavía falta base normalizada para varias áreas futuras:

- ataques
- armor class
- initiative
- spell slots y tracking detallado
- recursos de clase
- reglas de inventario más profundas

Esto no significa que la información no exista en las fuentes, sino que aún no
hay una base local de producto preparada para usarse de forma determinista.

## 5. Portrait y appearance

No hay una base oficial equivalente para:

- `portrait`
- `appearance`

Por ahora deben seguir como:

- campo libre;
- vacío permitido;
- sin catálogo oficial obligatorio.

## Siguiente extracción recomendada

1. Extraer de `backgrounds-phb.xml` una base normalizada de:
   `personality traits`, `ideals`, `bonds`, `flaws`
2. Extraer de `backgrounds-scag.xml`, `backgrounds-pam.xml`,
   `backgrounds-ggr.xml` y `backgrounds-erlw.xml` una base inicial de
   `faction`
3. Crear una política de precedencia entre fuentes `5e` y `5.5e`
4. Guardar la salida en una forma reutilizable por la app:
   `json`, `xml` simplificado o tablas internas

## Regla operativa

Mientras no exista una base normalizada propia:

- usar `System_Reference_Document_DND_5.5e/` para runtime estructurado actual;
- usar `dnd-5e-srd-markdown-master/` para validación semántica;
- usar `DND_5e/WizardsOfTheCoast/.../backgrounds-*.xml` como cantera oficial
  para opciones narrativas y factions.
