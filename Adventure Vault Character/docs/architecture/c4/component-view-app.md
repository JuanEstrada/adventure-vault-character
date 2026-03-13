# Component View App

## Componentes propuestos del cliente

```mermaid
flowchart TD
    UI["Interfaz de usuario"] --> AuthFlow["Flujo de autenticacion"]
    UI --> CharacterFlow["Flujo de personaje"]
    UI --> ContentFlow["Flujo de contenido"]
    UI --> SessionFlow["Flujo de sesion"]
    CharacterFlow --> Wizard["Guia asistida"]
    CharacterFlow --> Sheet["Vista del personaje"]
```

## Responsabilidades

- `Flujo de autenticacion`: acceso del jugador.
- `Flujo de personaje`: creacion, consulta y actualizacion.
- `Guia asistida`: apoya alta de personaje y subida de nivel.
- `Vista del personaje`: presenta estado jugable actual.
