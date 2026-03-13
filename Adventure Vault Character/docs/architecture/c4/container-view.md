# Container View

## Contenedores iniciales

```mermaid
flowchart LR
    Player["Jugador"] --> Client["Cliente de jugador"]
    Client --> Api["API de Adventure Vault"]
    Api --> Character["Servicio de personajes"]
    Api --> Content["Servicio de contenido"]
    Api --> Session["Servicio de sesion"]
    Api --> Import["Servicio de importacion XML"]
    Character --> Db["Persistencia"]
    Content --> Db
    Import --> Db
    Session --> ExternalSession["Servicio externo de sesion del master"]
    Session --> Db
```

## Interpretacion

- `Cliente de jugador`: interfaz principal del usuario.
- `API de Adventure Vault`: punto de entrada de la logica de aplicacion.
- `Servicio de sesion`: capacidad interna de integracion desde la app del jugador.
- `Servicio externo de sesion del master`: sistema fuera del alcance actual del repositorio.
