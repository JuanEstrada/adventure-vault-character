# 09. Architecture Decisions

## Resumen

Las decisiones de arquitectura se registran formalmente en `adr/`. Esta seccion funciona como indice y resumen, no como reemplazo de los ADR.

## Decisiones iniciales

- `0001`: adoptar Docs-as-Code para mantener la documentacion dentro del repositorio.
- `0002`: usar `arc42` como estructura principal de arquitectura y `C4` como modelo de vistas.

## Regla de mantenimiento

Cuando una decision cambie el alcance, los bloques del sistema o las integraciones externas, deben revisarse tambien `03-context-and-scope.md`, `05-building-block-view.md` y las vistas de `c4/`.

## Referencias

- Ver [ADR README](./adr/README.md)
- Ver [0001 Use Docs As Code For Architecture](./adr/0001-use-docs-as-code-for-architecture.md)
- Ver [0002 Adopt arc42 Plus C4](./adr/0002-adopt-arc42-plus-c4.md)
