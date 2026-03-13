# Adventure Vault Docs

Esta carpeta centraliza la documentacion viva de Adventure Vault como parte del repositorio.

## Objetivos

- Mantener el contexto del producto y de la arquitectura junto al codigo.
- Reducir decisiones implicitas y duplicadas.
- Facilitar que la documentacion crezca con el proyecto.

## Estructura

- `product/`: define vision, alcance, usuarios y dominio. Es la referencia principal para el que y el por que del producto.
- `architecture/`: describe como se organiza la solucion mediante `arc42`, `C4` y `ADR`.
- `workflows/`: establece como mantener la documentacion sin duplicarla.

## Convenciones

- Todo esta escrito en Markdown para seguir un enfoque Docs-as-Code.
- `docs/product/` describe necesidades y alcance; `docs/architecture/` describe decisiones, restricciones y estructura de solucion.
- Las decisiones relevantes deben quedar registradas en `architecture/adr/` y resumidas desde `architecture/09-architecture-decisions.md`.
- Los diagramas iniciales usan Mermaid para minimizar friccion.
- Cuando algo sea una hipotesis o este pendiente de validacion, debe indicarse de forma explicita.
