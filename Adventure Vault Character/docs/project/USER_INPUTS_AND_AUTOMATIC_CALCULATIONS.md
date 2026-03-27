# User Inputs And Automatic Calculations

Resumen rapido de que datos calcula la app por si sola y que datos debe
ingresar, elegir o confirmar el usuario.

## Fecha de verificacion

- 2026-03-27

## Fuentes de verdad

- `docs/project/SESSION_RESUME.md`
- `docs/project/PROJECT_SNAPSHOT.md`
- `docs/specs/create-character-screen.md`
- `docs/specs/character-sheet-screen.md`
- `docs/specs/first-character-sheet-contents.md`
- `docs/project/ROADMAP.md`

## Como leer este documento

- `Actual`: comportamiento ya respaldado por el estado actual del repo
- `Futuro esperado`: direccion documentada en roadmap o specs futuras
- `No automatizado`: la app todavia no lo resuelve automaticamente

## Que calcula automaticamente la app

### Actual

- Modificador de cada ability score a partir del valor final de
  `Strength`, `Dexterity`, `Constitution`, `Intelligence`, `Wisdom` y
  `Charisma`
- `Proficiency bonus` a partir del nivel
- Progreso hacia el siguiente nivel a partir de nivel y experiencia
- Nivel cuando el usuario cambia la experiencia en el flujo de creacion
- Experiencia minima requerida cuando el usuario cambia manualmente el nivel
- Hit points iniciales a partir de clase, nivel y Constitution
- Hit points maximos al editar si cambian clase, nivel o Constitution
- Recomendacion de `Standard Array by Class` cuando la clase cambia y el
  metodo activo es `generated set assignment`
- Validacion de secciones obligatorias antes de guardar:
  `Race + name`, `Background`, `Ability scores`,
  `Class / level / experience`
- Resumenes derivados visibles en la hoja, como method label de abilities,
  progreso de nivel y composicion visible de equipo cuando aplica

### Futuro esperado

- Resultados de tiradas y utilidades conectadas al contexto del personaje
- Resumenes mas ricos de inventario, hechizos y recursos del personaje
- Gestion mas completa de compendium packs activos e inactivos
- Resolucion por tirada o seleccion manual sobre opciones oficiales para cada
  campo narrativo de `finishing details`

### No automatizado hoy

- Calculo completo de ataques
- Spell slots y uso detallado de hechizos
- Armor Class, initiative y combate avanzado como sistema completo
- Reglas de inventario completo fuera del flujo MVP de equipo inicial
- Automatizacion total de recursos de clase, rasgos o consumos por descanso

## Que debe ingresar o confirmar el usuario

### Actual

- Nombre del personaje
- Raza elegida desde el compendio
- Background elegido desde el compendio
- Clase elegida desde el compendio
- Nivel inicial o experiencia inicial
- Metodo de ability scores
- Asignacion final de los seis ability scores
- Equipo inicial seleccionado
- Cantidad de objetos comprables cuando aplique
- Confirmacion de costo total frente al dinero disponible al comprar equipo
- `portrait` opcional como campo libre
- `appearance` opcional como campo libre
- Para `alignment`, `faction`, `personality traits`, `ideals`, `bonds` y
  `flaws`, eleccion del modo por campo:
  escribir o dejar vacio, tirar dado, o seleccionar manualmente
- Si el usuario usa tirada o seleccion manual en uno de esos campos
  narrativos, la app trabaja sobre opciones oficiales para ese campo

### Futuro esperado

- Tiradas manuales o acciones iniciadas por el jugador desde una pantalla de
  dados
- Ajustes detallados de inventario
- Gestion de hechizos y recursos
- Seleccion de compendium packs opcionales cuando exista el selector de
  contenido

## Que se sincroniza automaticamente cuando cambia un dato

- Si cambia la experiencia, la app recalcula el nivel segun los thresholds
  definidos
- Si cambia el nivel, la app resetea la experiencia al minimo requerido para
  ese nivel
- Si cambia la clase y el metodo de abilities es `generated set assignment`,
  cambia la recomendacion visible del array
- Si cambian clase, nivel o Constitution durante edicion, la app recomputa
  HP maximo y conserva HP actual cuando es posible
- En el comportamiento documentado para futuro cercano, la app tambien
  podra resolver por tirada los campos narrativos de `finishing details`
  usando opciones oficiales cuando el usuario elija ese modo
- La hoja de personaje reutiliza valores derivados del dominio en lugar de
  recalcularlos dentro de widgets

## Reglas de frontera

- Que un dato se vea en pantalla no significa que lo escriba el usuario
- Que un dato exista en persistencia no significa que sea canonico o no
  derivado
- Los calculos deben vivir en `domain` o `application`, no en widgets
- La persistencia no debe almacenar derivados evitables si pueden
  recomputarse desde el estado canonico

## Vista corta por categoria

### Calculado por la app

- Ability modifiers
- Proficiency bonus
- Level progress
- Sincronizacion `level <-> experience`
- HP inicial y HP maximo recomputado en edicion
- Recomendacion de standard array por clase
- Validacion de secciones obligatorias

### Ingresado o confirmado por el usuario

- Identidad del personaje
- Race, background y class
- Experience o level inicial
- Ability score method
- Valores finales de abilities
- Equipo inicial y compras
- `portrait` y `appearance` como detalles opcionales libres
- Modo de captura y posible seleccion final de cada detalle narrativo guiado

## Limites de este documento

- No reemplaza specs de pantalla ni de dominio
- No define contratos tecnicos de persistencia o API
- No promete automatizaciones no aprobadas en roadmap o specs
- Sirve como referencia rapida para sesiones de IA y alineacion del proyecto
