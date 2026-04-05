# Golden Path (Ruta Dorada): node-express-chatbox

Documento de incorporación (*onboarding*) del equipo de Plataforma. Describe la ruta canónica desde un clon limpio hasta un servidor de desarrollo en ejecución en menos de 3 minutos.

---

## Inicio Rápido (La Ruta Dorada)

**Prerrequisitos:** Node.js >=18, GNU Make
*(Windows: usar Git Bash, WSL o `choco install make`)*

```sh
git clone <repo-url>
cd lesson-6-node-express-chatbox
make setup
make dev
# Abrir http://localhost:3001 en tu navegador
```

---

## Artefactos Introducidos

| Artefacto | Propósito |
|---|---|
| `.nvmrc` | Fija la versión mayor de Node.js en la 18 para usuarios de nvm (`nvm use` funciona directamente). |
| `.env.example` | Documenta cada variable de entorno que lee la app; copiar a `.env` antes de ejecutar. |
| `Makefile` | Punto de entrada único para las operaciones de configuración (`setup`), desarrollo (`dev`), pruebas (`test`), auditoría (`audit`) y limpieza (`clean`). |
| `GOLDEN_PATH.md` | Este documento. |

## Cambios en Archivos Existentes

| Archivo | Cambio | Resuelve |
|---|---|---|
| `package.json` | Añadido campo `engines`; corregido `main` a `server.js`; añadidos scripts `start`/`dev`; reemplazado comando `test` roto; añadido `nodemon` a `devDependencies`; versiones de dependencias fijadas con exactitud. | #3, #4, #5, #6 |
| `server.js` | El puerto se lee de `process.env.PORT` con el 3001 como respaldo; el log de inicio ahora imprime la URL completa. | #1, #2, #7 |
| `public/js/chat.js` | Se eliminó `http://localhost:3001` hardcoded; ahora `io()` se conecta al mismo origen automáticamente. | #7 |

---

## Punto de Fricción → Artefacto → Estado

| # | Etiqueta | Descripción | Artefacto(s) | Estado |
|---|---|---|---|---|
| 1 | MISSING_DOC | Sin instrucciones para abrir la URL tras iniciar el servidor | `Makefile` (`make dev` imprime URL); Inicio rápido en GOLDEN_PATH.md | **CORREGIDO** |
| 2 | MISSING_DOC | Puerto 3001 no documentado en la configuración | `.env.example` (PORT=3001 con comentario); `Makefile` | **CORREGIDO** |
| 3 | IMPLICIT_DEP | `nodemon` requerido globalmente, no en package.json | `package.json` devDependencies + `npm ci` en Makefile | **CORREGIDO** |
| 4 | VERSION_HELL | Sin versión de Node.js especificada | `.nvmrc` (node 18); campo engines en `package.json` (>=18.0.0) | **CORREGIDO** |
| 5 | BROKEN_CMD | `npm test` falla con código de salida 1 | Script de prueba de humo (*smoke test*) en `package.json` | **CORREGIDO** |
| 6 | VERSION_HELL | Rangos con circunflejo permiten discrepancias entre máquinas | Versiones fijas en `package.json`; `npm ci` en `make setup` | **CORREGIDO** |
| 7 | ENV_GAP | Puerto y URL hardcoded en server.js y chat.js | `.env.example`; `server.js` lee `process.env.PORT`; `chat.js` usa `io()` | **CORREGIDO** |
| 8 | SILENT_FAIL | `npm install` reporta vulnerabilidades sin guía | `make audit` imprime reporte con instrucciones de remediación | **MITIGADO** |

### Nota sobre el Punto de Fricción 8 (Vulnerabilidades)

Ejecutar `make audit` muestra el reporte completo de vulnerabilidades. Estas provienen de dependencias transitivas de `socket.io 2.2.0`. La remediación completa requiere actualizar a socket.io 4.x, lo cual es un cambio de API que rompe la compatibilidad (*breaking change*) y está fuera del alcance de este ejercicio. El proyecto se ejecuta solo en localhost sin persistencia ni autenticación, lo que reduce la superficie de ataque práctica.
**Acción para nuevos ingenieros:** ejecutar `make audit`, leer la salida y escalar si se va a desplegar en un entorno compartido o público.

---

## Lista de Verificación para Validación de Incorporación

Después de `make setup` y `make dev`:

- [ ] La terminal imprime: `Listening on port 3001 — open http://localhost:3001`
- [ ] El navegador carga `http://localhost:3001` y la interfaz de chat se renderiza.
- [ ] Dos pestañas del navegador pueden intercambiar mensajes en tiempo real.
- [ ] Cambiar un nombre de usuario en una pestaña aparece en el panel de sistema de la otra.
- [ ] `make test` finaliza con código 0 e imprime `PASS`.
- [ ] `make audit` imprime el reporte de vulnerabilidades sin bloquearse.

**Importante:** Abrir siempre la app mediante `http://localhost:3001`, no haciendo doble clic en `public/index.html`. La llamada a `io()` en `chat.js` se conecta al mismo origen que la página; requiere un servidor HTTP, no una URL de tipo `file://`.

---

## Prompts de IA Utilizados

### Prompt 1 — Recomendación de artefactos

Se le entregó el siguiente prompt a Claude (claude-sonnet-4-6) con el contenido de `PAIN_LOG.md` pegado como contexto:

> "Actúa como un miembro del equipo de Plataforma. El archivo PAIN_LOG.md adjunto documenta 8 puntos de fricción en la incorporación para un proyecto de chatbox con Node.js/Express/Socket.io. El proyecto no tiene base de datos, ni autenticación, ni pipeline de CI. ¿Qué conjunto mínimo de artefactos recomendarías crear para resolver cada punto de dolor? Elige artefactos proporcionales a la complejidad real del proyecto y justifica cada uno."

La IA recomendó: `.nvmrc`, `.env.example`, `Makefile` y `GOLDEN_PATH.md` como artefactos nuevos, más cambios en `package.json`, `server.js` y `public/js/chat.js`. También sugirió un `Dockerfile` y `docker-compose.yml`, que fueron descartados.

### Prompt 2 — Generación de los artefactos

Con la lista de artefactos definida, se le dio un segundo prompt:

> "Crea los siguientes artefactos para el proyecto: un `.nvmrc` que fije Node 18, un `.env.example` con la variable PORT documentada, un `Makefile` y el `GOLDEN_PATH.md` que incluya el Quick Start. Usa `npm ci` en el target `setup`, no `npm install`."

---

## En qué se equivocó la IA

Esta sección documenta las correcciones realizadas al primer borrador generado por la IA.

### 1. Rango de versión en `engines` demasiado estricto

La IA generó inicialmente `"node": ">=18.0.0 <19.0.0"` en el `package.json`, lo que emitiría una advertencia (tratada como error por algunas herramientas de CI) para cualquiera que use Node 20, 22 o 24. El valor correcto es `">=18.0.0"`. El punto de fricción era la *falta de documentación de la versión*, no que *deba ser exactamente Node 18*. Un suelo mínimo es la restricción adecuada; un techo artificial añade fricción sin beneficio alguno.

### 2. Uso de `npm install` en lugar de `npm ci` en el target `make setup`

El borrador inicial del Makefile usaba `npm install`. Esta es la herramienta incorrecta para un paso de configuración reproducible: `npm install` puede actualizar silenciosamente el `package-lock.json` cuando los rangos en `package.json` resuelven a versiones más nuevas, que es exactamente la discrepancia que documenta el punto de fricción 6. `npm ci` lee el archivo *lock* como autoridad y falla explícitamente si el manifiesto y el *lockfile* divergen. Se cambió a `npm ci`.

### 3. Recomendación de Docker como artefacto principal

La IA sugirió un `Dockerfile` y `docker-compose.yml`. Para una app de un solo proceso, sin estado, sin base de datos y sin objetivo de despliegue definido, Docker añadiría un paso de instalación obligatorio (Docker Desktop) y una capa de abstracción que no resuelve ninguno de los 8 problemas documentados. Se rechazó en favor de `.nvmrc` + `Makefile`, que resuelven los mismos problemas sin requerir herramientas nuevas.

### 4. El *Smoke Test* iniciaba el servidor en el puerto por defecto sin vía de escape

El *smoke test* de la IA en `package.json` llamaba a `require('./server.js')`, el cual se vincula al puerto 3001. Si `make dev` ya está ejecutándose en otra terminal, `npm test` fallaría con un error `EADDRINUSE`. La solución se documentó en la lista de verificación ("ejecutar `make test` sin `make dev` activo") y puede solventarse con `PORT=3002 npm test`. Una solución más robusta requeriría refactorizar `server.js` para exportar el servidor, lo cual excedía el alcance de este entregable.

### 5. `grep PORT .env` capturaba la línea de comentario

El target `make dev` usaba `grep -s PORT .env` para leer el puerto configurado. Este patrón coincide también con las líneas de comentario que contienen la palabra "PORT" (p.ej. `# PORT: the TCP port...`), produciendo una salida como `Open http://localhost:# PORT: the TCP port...`. Se corrigió el patrón a `grep -s '^PORT=' .env` para capturar únicamente la línea de asignación.

### 6. `make dev` no verificaba si el puerto ya estaba en uso

La IA no incluyó ninguna comprobación previa al arranque del servidor. Si el puerto ya estaba ocupado, nodemon fallaba con un error `EADDRINUSE` sin ningún mensaje orientativo. Se añadió una verificación explícita al inicio del target `dev` que detiene la ejecución con el mensaje `ERROR: Port X is already in use. Stop the existing process and retry.` antes de intentar arrancar el servidor.

### 7. Los cambios a archivos existentes no se reflejaron en el README

La IA generó todos los artefactos nuevos correctamente, pero no actualizó el `README.md`. Las instrucciones de configuración seguían describiendo el flujo original: `npm install`, `npm install nodemon -g` y `nodemon server.js`. Un desarrollador que siguiera el README habría reproducido exactamente los mismos puntos de fricción que el PAIN_LOG documenta. Se reescribió el README para reflejar el nuevo flujo basado en `make setup` y `make dev`, corregir variables de entorno ficticias (`HOST`, `NODE_ENV`) que la IA había introducido en una versión intermedia, y eliminar la referencia a un `setup.sh` que nunca existió.

---

## Tiempo hasta la primera ejecución (Benchmark)

| Hito | Objetivo |
|---|---|
| Clonar → `make setup` completado | < 2 min |
| `make dev` imprime la URL de escucha | < 5 seg |
| El navegador renderiza la interfaz de chat | < 3 seg |
| **Total desde clon hasta UI funcional** | **< 3 minutos** |

Antes de la Ruta Dorada: **25–45 minutos** (según el `PAIN_LOG.md`).