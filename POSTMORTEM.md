# Postmortem: node-express-chatbox Onboarding

## Part A — Demo

### Terminal: `time make setup`

![time make setup](screenshots/time%20set%20up.png)

### Video: demo completo del Golden Path

[Ver DEMO_REFACTOR.mp4](screenshots/DEMO_REFACTOR.mp4)

---

## What Was Broken

El repositorio original requería tres pasos de configuración indocumentados o incorrectos: una dependencia global (`nodemon`) no declarada en `package.json`, ninguna versión de Node.js especificada, y un comando `npm test` que fallaba con código de salida 1 por diseño. La URL de la aplicación no aparecía en ningún documento de incorporación, y el puerto estaba escrito directamente en el código sin posibilidad de configuración. Un desarrollador nuevo seguía las instrucciones hasta el final y no sabía si la aplicación estaba funcionando.

## What We Built

| Artefacto | Qué elimina |
|---|---|
| `.nvmrc` | VERSION_HELL: versión de Node no especificada |
| `.env.example` | ENV_GAP: puerto y URL hardcodeados sin documentación |
| `Makefile` | BROKEN_CMD (`npm test`), IMPLICIT_DEP (`nodemon -g`), MISSING_DOC (URL), SILENT_FAIL (vulnerabilidades sin guía) |
| `GOLDEN_PATH.md` | Documenta el camino canónico completo y los errores del proceso |
| `package.json` (modificado) | VERSION_HELL (deps con `^`), IMPLICIT_DEP, BROKEN_CMD |
| `server.js` (modificado) | ENV_GAP: puerto hardcodeado, sin URL en el log de arranque |
| `public/js/chat.js` (modificado) | ENV_GAP: URL del servidor hardcodeada en el cliente |
| `README.md` (modificado) | MISSING_DOC: instrucciones de setup obsoletas e incorrectas |

## Cost of the Original State

Sin los artefactos del Golden Path, el proceso de setup manual tomaba ~10 minutos por ingeniero. Con `make setup && make dev` el mismo proceso se completa en menos de 10 segundos. Asumiendo 5 incorporaciones al mes y un costo de $75/hora:

| Variable | Sin Golden Path | Con Golden Path |
|---|---|---|
| Tiempo por ingeniero | ~10 min | < 10 segundos |
| Incorporaciones por mes | 5 | 5 |
| Horas perdidas por mes | ~0.83 hrs | ~0 hrs |
| Costo a $75/hr | **~$62/mes** | **~$0/mes** |
| Costo anual proyectado | **~$750/año** | **~$0/año** |

Esto sin contar el costo de fricción en la confianza del equipo, errores introducidos por diferencias de entorno entre máquinas, y tiempo de soporte de ingenieros senior resolviendo problemas de onboarding repetibles.

## What We Would Do Next

La mejora de mayor ROI pendiente es actualizar `socket.io` de la versión 2.2.0 a la 4.x. Las 19 vulnerabilidades reportadas por `npm audit` (incluyendo 3 críticas) provienen en su mayoría de dependencias transitivas de esta versión. El Makefile expone el problema con `make audit`, pero no lo resuelve: es el único punto de fricción que quedó como **MITIGADO** en lugar de **CORREGIDO**. La actualización requiere cambios de API (los eventos y la inicialización del cliente cambiaron entre versiones), pero eliminaría la deuda de seguridad completa y modernizaría el stack a una versión con soporte activo.
