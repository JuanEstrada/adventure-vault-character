# Session Close Checklist

Usa esta lista para cerrar una sesion y dejar el repo listo para retomarlo en
la siguiente.

## 1. Verifica el Trabajo

- corre los checks necesarios
- revisa `git diff`
- confirma que la documentacion no quedo desalineada

## 2. Actualiza la Documentacion

Actualiza como minimo:

- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`

Actualiza tambien cualquier README, spec, arquitectura o ADR que haya quedado
obsoleto por los cambios de la sesion.

## 3. Deja Claro el Siguiente Paso

En `docs/project/SESSION_RESUME.md` deja escrito:

- que se completo
- que sigue
- que archivos son fuente de verdad para continuar

## 4. Guarda el Trabajo

```bash
git status --short
git add <archivos>
git commit -m "mensaje claro"
git push origin main
```

## 5. Cierre Esperado

Antes de terminar:

- el repo debe quedar limpio o con cambios intencionales explicitos
- la documentacion debe coincidir con el estado real del codigo
- el siguiente bloque de trabajo debe quedar claro
