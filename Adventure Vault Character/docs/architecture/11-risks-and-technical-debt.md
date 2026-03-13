# 11. Risks And Technical Debt

## Riesgos actuales

- El dominio esta descrito de forma preliminar y puede cambiar al validarlo con usuarios.
- La conexion con la app del master aun no tiene contrato definido.
- El soporte futuro a multiples sistemas puede quedar comprometido si la primera version se acopla demasiado a DND.
- La importacion XML puede introducir inconsistencias si no se define un modelo claro de validacion.

## Deuda tecnica potencial

- Mezclar logica de reglas con interfaz.
- Duplicar definiciones de contenido entre fuentes base e importadas.
- Documentar arquitectura aspiracional sin marcar que aun no esta implementada.

## Mitigaciones

- Mantener ADR pequenos y frecuentes.
- Revisar y actualizar C4 cuando aparezcan nuevos limites del sistema.
- Separar desde temprano dominio, integraciones y experiencia de usuario.
