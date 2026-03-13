# Component View Backend

## Componentes propuestos del backend

```mermaid
flowchart TD
    Api["API"] --> CharacterService["Servicio de personajes"]
    Api --> ContentService["Servicio de contenido"]
    Api --> SessionService["Servicio de sesion"]
    Api --> ImportService["Servicio de importacion XML"]
    CharacterService --> Rules["Motor de reglas del sistema"]
    ContentService --> Catalog["Catalogo de contenido"]
    ImportService --> Validation["Validacion de contenido"]
    SessionService --> Sync["Adaptador de sesion del master"]
```

## Responsabilidades

- `Servicio de personajes`: gestiona estado y progreso.
- `Motor de reglas del sistema`: encapsula reglas del juego.
- `Servicio de contenido`: entrega catalogos disponibles.
- `Servicio de importacion XML`: valida e integra contenido agregado.
- `Servicio de sesion`: coordina el intercambio con el contexto del master a traves de un adaptador aislado.
