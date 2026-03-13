# 02. Architecture Constraints

## Restricciones actuales

- El proyecto parte de un nivel de definicion temprano y aun no muestra implementacion estable en el repositorio.
- La documentacion debe mantenerse en Markdown dentro del repositorio.
- El publico inicial son jugadores; la app para master se considera un sistema separado.
- Debe existir una ruta futura para soportar sistemas distintos a DND.
- El contenido de juego incluye datos base y contenido importado mediante XML.

## Restricciones de trabajo

- La arquitectura inicial debe ser facil de entender y barata de mantener.
- Las decisiones fundacionales deben quedar registradas como ADR.
- La documentacion debe evitar duplicar informacion entre producto y arquitectura.
- Las vistas C4 deben mantenerse alineadas con los bloques funcionales descritos en `05-building-block-view.md`.

## Supuestos que condicionan la arquitectura

- La solucion puede comenzar como una sola aplicacion con modulos internos bien delimitados.
- La autenticacion, el almacenamiento y la sesion del master pueden implementarse como servicios separados o integraciones externas segun evolucione el proyecto.
- El soporte multijuego se resolvera a traves de un modelo de reglas extensible, no duplicando toda la aplicacion por sistema.

## Restricciones abiertas

- No hay tecnologia final confirmada para frontend, backend, base de datos o integraciones.
- No hay definicion cerrada de autenticacion, sincronizacion, despliegue ni requerimientos offline.
