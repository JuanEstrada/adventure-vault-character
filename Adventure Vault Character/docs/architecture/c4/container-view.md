# Container View

## Contenedores iniciales

```mermaid
flowchart LR
    Player["Jugador"] --> Client["Cliente de jugador"]
    Client --> Api["API de Adventure Vault"]
    Api --> Character["Modulo de personajes"]
    Api --> Content["Modulo de contenido"]
    Api --> Session["Modulo de sesion"]
    Api --> Import["Modulo de importacion XML"]
    Character --> Db["Base de datos"]
    Content --> Db
    Import --> Db
    Session --> Db
```

## Interpretacion

- `Cliente de jugador`: interfaz principal del usuario.
- `API de Adventure Vault`: punto de entrada de la logica de aplicacion.
- `Modulos internos`: separaciones conceptuales que pueden vivir dentro de un mismo despliegue al inicio.
