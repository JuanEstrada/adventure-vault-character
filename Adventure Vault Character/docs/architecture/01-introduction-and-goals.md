# 01. Introduction And Goals

## Resumen

Adventure Vault Character busca ayudar a jugadores de rol a gestionar sus personajes de forma persistente, guiada y conectada con una sesion activa.

## Objetivos de negocio

- Permitir que un jugador cree y administre su personaje desde una app dedicada.
- Reducir friccion en tareas frecuentes como nivelar, gestionar inventario, conjuros y experiencia.
- Preparar una base extensible para soportar mas sistemas ademas de DND.

## Objetivos de arquitectura

- Separar claramente producto, dominio, interfaz, integraciones y decisiones tecnicas.
- Permitir evolucion futura hacia varios sistemas de juego y contenido importado.
- Hacer visibles las decisiones clave desde etapas tempranas.
- Mantener trazabilidad entre alcance de producto, vistas C4 y ADR.

## Supuestos iniciales

- El repositorio aun no contiene una implementacion tecnica consolidada.
- La primera version se enfoca en la experiencia del jugador.
- La app del master existira por separado y se integrara mediante contratos aun no definidos.
- La primera iteracion puede comenzar como monolito modular siempre que preserve limites claros entre dominios.

## Stakeholders principales

- Jugadores: usan la app para crear y gestionar personajes.
- Equipo de producto: define alcance, experiencia y priorizacion.
- Equipo tecnico: implementa y evoluciona la solucion.
- Futuro equipo de master: integrara su propia app con la experiencia del jugador.
