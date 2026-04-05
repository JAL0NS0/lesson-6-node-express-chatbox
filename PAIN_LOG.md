# PAIN_LOG (Registro de Dificultades)

Ruta de configuración auditada únicamente desde el README:
1. `npm install`
2. `npm install nodemon -g`
3. `nodemon server.js`

## Friction Points (Puntos de Fricción)

1. **[MISSING_DOC]** El README no incluye un paso de verificación tras ejecutar `nodemon server.js` (por ejemplo, "abrir http://localhost:3001"). Un nuevo ingeniero puede iniciar el proceso pero no tiene una confirmación de éxito documentada.
   * **Evidencia:** La sección de configuración termina en "Iniciando el servidor de desarrollo" y nunca indica dónde acceder a la aplicación.
   * **Gravedad:** MAYOR — el proceso de incorporación (*onboarding*) se estanca tras el arranque porque no hay una siguiente acción explícita.

2. **[MISSING_DOC]** El README no documenta la URL o el puerto de la aplicación en las instrucciones de configuración.
   * **Evidencia:** El puerto solo es detectable en el código (`server.js` escucha en el 3001) o leyendo los logs de ejecución, no en los documentos de bienvenida.
   * **Gravedad:** MAYOR — los nuevos ingenieros deben inspeccionar el código fuente o la salida de logs en lugar de seguir la documentación.

3. **[IMPLICIT_DEP]** El README requiere la instalación global de `nodemon`, pero esta no está declarada en los scripts de `package.json` ni en `devDependencies`.
   * **Evidencia:** El README exige `npm install nodemon -g`; el repositorio no tiene `devDependencies` ni un script `npm run dev`.
   * **Gravedad:** MAYOR — la configuración depende del estado global de la máquina y puede fallar en distintos entornos.

4. **[VERSION_HELL]** Se requiere una versión del entorno de ejecución de Node, pero no está fijada ni declarada.
   * **Evidencia:** El README dice "Este proyecto requiere nodejs para ejecutarse" pero no especifica versión; `package.json` no tiene el campo `engines`.
   * **Gravedad:** MAYOR — el comportamiento puede variar según la versión de Node y se debilita la reproducibilidad del *onboarding*.

5. **[VERSION_HELL]** Las dependencias están fijadas mediante rangos con circunflejo (`^` en `express` y `socket.io`), lo que permite discrepancias entre máquinas con el paso del tiempo.
   * **Evidencia:** `package.json` utiliza `"express": "^4.17.1"` y `"socket.io": "^2.2.0"`.
   * **Gravedad:** MEDIA — futuras instalaciones pueden producir un comportamiento en tiempo de ejecución distinto al de procesos de configuración previos.

6. **[BROKEN_CMD]** El comando estándar de pruebas del proyecto falla.
   * **Evidencia:** Ejecutar `npm test` devuelve `"Error: no test specified"` y finaliza con código de salida 1.
   * **Gravedad:** MAYOR — no hay una ruta de validación ejecutable para los ingenieros ni confianza en la Integración Continua (CI) durante el *onboarding*.

7. **[ENV_GAP]** La configuración de tiempo de ejecución está escrita directamente en el código (*hardcoded*) sin posibilidad de sobreescritura mediante variables de entorno documentadas.
   * **Evidencia:** El servidor se vincula directamente al puerto 3001 y el cliente se conecta a `http://localhost:3001`; no existe un archivo `.env.example` ni guía de configuración.
   * **Gravedad:** MEDIA — los ingenieros no pueden adaptar fácilmente los puertos locales o remotos sin editar el código.

8. **[SILENT_FAIL]** La instalación de dependencias finaliza con éxito (`exit 0`) a pesar de informar vulnerabilidades críticas, y el README no ofrece guía de solución.
   * **Evidencia:** `npm install` se completó como "actualizado" (*up to date*) pero reportó 16 vulnerabilidades (incluyendo críticas).
   * **Gravedad:** MEDIA — la configuración parece exitosa mientras se trabaja con riesgos conocidos sin pasos a seguir documentados.

## Severity Summary (Resumen de Gravedad)

* **Total de puntos de fricción encontrados:** 8
* **Primer bloqueador total alcanzado en:** Después de iniciar `nodemon server.js` (paso 3 de la configuración), porque el README no proporciona una URL de verificación ni una acción siguiente para confirmar que la aplicación funciona.
* **Tiempo estimado perdido para una nueva contratación:** ~10 minutos
    * 3-4 min para descubrir cómo verificar la aplicación en ejecución.
    * 2-3 min para resolver la ambigüedad de la herramienta global (`nodemon -g`).
    * 2-3 min para investigar el fallo en el comando de pruebas.
    * 1-2 min para conciliar suposiciones de versiones y configuración.
* **Tiempo con el Golden Path:** menos de 10 segundos (`make setup && make dev`)