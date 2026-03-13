# System Context

## Descripcion

Adventure Vault Character sirve al jugador y se integra con servicios de autenticacion, contenido, persistencia y un servicio externo de sesion del master.

```mermaid
flowchart LR
    Player["Jugador"] --> AVC["Adventure Vault Character"]
    AVC --> Auth["Servicio de autenticacion"]
    AVC --> Content["Repositorio de contenido"]
    AVC --> Session["Servicio externo de sesion del master"]
    AVC --> Storage["Persistencia de personajes"]
```

## Responsabilidades

- El jugador interactua solo con la app de personaje.
- La app coordina acceso, consulta de contenido y actualizacion de estado.
- La capacidad del master se modela aqui como integracion externa y no como contenedor propio de esta solucion.
