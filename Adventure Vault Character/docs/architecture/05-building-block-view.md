# 05. Building Block View

## Bloques principales propuestos

- `Cliente de jugador`: interfaz para login, creacion guiada, consulta y edicion.
- `API de Adventure Vault`: punto de entrada de aplicacion para operaciones del cliente.
- `Servicio de personajes`: logica para crear, leer y actualizar personajes.
- `Servicio de contenido`: acceso a clases, razas, spells, items y monstruos.
- `Servicio de importacion`: procesa y valida contenido agregado por XML.
- `Servicio de sesion`: coordina la conexion del personaje con una sesion del master.
- `Persistencia`: almacenamiento de personajes, progreso y contenido importado.

## Relacion con C4

Estos bloques corresponden a la descomposicion mostrada en `c4/container-view.md` y `c4/component-view-backend.md`. Si cambia un nombre o una responsabilidad aqui, debe cambiar tambien en esas vistas.

## Observaciones

- Esta descomposicion es inicial y debera validarse cuando exista implementacion real.
- Si el sistema comienza como monolito, estos bloques pueden vivir como modulos internos antes de separarse fisicamente.
- `Servicio de sesion` describe la capacidad de integracion desde la app de jugador; no implica que la app del master forme parte del mismo repositorio.
