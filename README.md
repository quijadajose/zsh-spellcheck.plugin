# Verificador de Ortografía en Línea de Comandos

Este proyecto proporciona un sistema de verificación ortográfica en tiempo real para el shell Zsh, utilizando la herramienta **aspell** para verificar palabras y sugerir correcciones en línea mientras se escribe un comando. El objetivo es ayudar a los usuarios a detectar errores tipográficos y corregirlos de manera sencilla mediante sugerencias automáticas.

> **Nota:** Este proyecto está en desarrollo y puede estar incompleto. Algunas características podrían no funcionar como se espera.

## Requisitos

Para que este script funcione, es necesario tener **aspell** instalado en tu sistema. Puedes instalarlo ejecutando el siguiente comando:

```bash
sudo apt install aspell
```

## Funcionalidades

- **Verificación de ortografía en tiempo real:** El script analiza cada palabra del comando y marca los errores ortográficos.
- **Sugerencias automáticas:** En caso de detectar un error, se muestran sugerencias de reemplazo basadas en el diccionario de **aspell**.
- **Navegación de sugerencias:** Permite desplazarse entre sugerencias con la tecla `Tab`.
- **Inserción de espacios y envío de comandos sin activar el corrector:** Opciones para continuar escribiendo sin que se active la verificación ortográfica.

## Uso de las Funciones

1. **Verificación de ortografía**: Al escribir, cada palabra se revisa y se muestra un mensaje si se detectan errores ortográficos. Los mensajes de error incluyen las sugerencias.
2. **Ciclo de sugerencias**: Usa la tecla `Tab` para navegar entre las sugerencias disponibles y elegir la mejor opción.
3. **Insertar espacio sin corrector**: Presiona `Ctrl + Espacio` para insertar un espacio sin activar la verificación.
4. **Enviar el comando sin verificación**: Usa `Ctrl + Enter` para enviar el comando sin revisar la ortografía.

## Atajos de Teclado

- `Espacio` - Activa el corrector ortográfico
- `Enter` - Activa el corrector ortográfico
- `Tab` - Navega por las sugerencias de corrección
- `Ctrl + Espacio` - Inserta un espacio sin activar el corrector
- `Ctrl + Enter` - Envía el comando sin activación del corrector

## Nota Importante

Este script es específico para el shell **Zsh** y puede no ser compatible con otros shells. Además, como el proyecto está en desarrollo, puede haber errores y limitaciones en la funcionalidad.

## Contribuciones

Si deseas contribuir al desarrollo de este proyecto, ¡eres bienvenido! Puedes enviar PRs o abrir issues para discutir nuevas ideas o reportar problemas.
