# 07. Deployment View

## Vision inicial

Todavia no hay una arquitectura de despliegue confirmada. Como base de trabajo, se asume una solucion con estos nodos logicos:

- cliente de jugador
- backend de aplicacion
- almacenamiento persistente
- servicio de autenticacion
- servicio externo de sesion del master

## Direccion esperada

- El cliente puede evolucionar como aplicacion web o cliente multiplataforma.
- El backend deberia exponer APIs claras para personajes, contenido y sesiones.
- La persistencia debe soportar progreso transaccional del personaje y contenido importado.
- La integracion con la sesion del master debe aislarse detras de contratos de aplicacion, no mezclarse con la interfaz de usuario.

## Pendientes concretos

- Seleccion de plataforma de despliegue
- estrategia de observabilidad
- manejo de secretos y configuracion
- necesidades offline o sincronizacion parcial
- contrato de integracion entre la app del jugador y el contexto del master
