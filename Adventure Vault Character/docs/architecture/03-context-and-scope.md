# 03. Context And Scope

## Alcance inicial

Adventure Vault Character cubre la experiencia del jugador para:

- autenticarse
- crear personajes mediante una guia asistida
- consultar y gestionar personajes existentes
- visualizar contenido base y contenido importado
- conectarse a una sesion del master
- actualizar el estado del personaje durante la sesion

## Fuera de alcance por ahora

- Gestion completa de la aplicacion del master
- Marketplace o distribucion de contenido
- Soporte completo para multiples sistemas desde la primera version

## Contexto del sistema

```mermaid
flowchart LR
    Player["Jugador"] --> App["Adventure Vault Character"]
    App --> Auth["Servicio de autenticacion"]
    App --> Content["Repositorio de contenido del juego"]
    App --> Session["Servicio de sesion del master"]
    App --> Storage["Persistencia de personajes"]
```

## Relacion con otros sistemas

- `Servicio de autenticacion`: valida identidad y acceso.
- `Repositorio de contenido del juego`: provee clases, razas, spells, items y monstruos.
- `Servicio de sesion del master`: sincroniza el estado del personaje durante una partida y pertenece al contexto de integracion, no al alcance de implementacion actual.
- `Persistencia de personajes`: conserva progreso, inventario, experiencia y decisiones del jugador.

## Nota de consistencia

Las vistas de `docs/architecture/c4/` desarrollan este contexto con un nivel de detalle mayor. Si una relacion cambia aqui, debe actualizarse tambien en C4 y en los ADR afectados.
