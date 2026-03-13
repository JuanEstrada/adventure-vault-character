# 05. Building Block View

## Bloques principales propuestos

- `Cliente de jugador`: interfaz para login, creacion guiada, consulta y edicion.
- `Servicio de personajes`: logica para crear, leer y actualizar personajes.
- `Servicio de contenido`: acceso a clases, razas, spells, items y monstruos.
- `Servicio de importacion`: procesa contenido agregado por XML.
- `Servicio de sesion`: conecta el personaje del jugador con una sesion del master.
- `Persistencia`: almacenamiento de personajes, progreso y contenido importado.

## Observaciones

- Esta descomposicion es inicial y debera validarse cuando exista implementacion real.
- Si el sistema comienza como monolito, estos bloques pueden vivir como modulos internos antes de separarse fisicamente.
