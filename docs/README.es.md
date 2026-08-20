<p align="right">
🌐 <a href="../README.md">日本語</a> | <a href="README.en.md">English</a> | <a href="README.zh.md">中文</a> | <a href="README.ko.md">한국어</a> | <b>Español</b> | <a href="README.fr.md">Français</a>
</p>

# 🌐 Suiramu Search (S.S.)

**Un entorno de acceso al aprendizaje para estudiantes, centrado por completo en "buscar" y "ver videos"**

Suiramu Search ejecuta un navegador Chromium real en GitHub Codespaces, y accedes a internet a través de él. No se instala nada en tu propio ordenador: todo funciona dentro del navegador.

![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-active-brightgreen)

---

## 🎯 ¿Qué es esto?

Suiramu Search (**S.S.** para abreviar) tiene **dos modos**. Elige el que se ajuste a lo que necesitas hacer.

| Modo | Úsalo para | Optimizado para |
|---|---|---|
| 🔍 **Modo búsqueda** | Investigar, redactar informes, leer | Texto nítido, ligero |
| 🎬 **Modo video** | Ver YouTube y sitios similares | Video fluido, con audio |

En lugar de intentar hacerlo todo en una sola pantalla, Suiramu cambia de modo para que cada uno sea realmente cómodo de usar.

---

## 🚀 Cómo usarlo (3 pasos)

### Paso 1: Abre un Codespace

Haz clic en el botón verde **"Code"** de esta página → pestaña **"Codespaces"** → **"Create codespace on main"**

La primera vez, la configuración se ejecuta automáticamente (unos 3-5 minutos).

### Paso 2: Inicia un modo

En la terminal de la parte inferior de la pantalla, escribe uno de los siguientes comandos y presiona Enter.

**Para investigar y leer:**
```bash
npm run search
```

**Para ver videos:**
```bash
npm run video
```

### Paso 3: Abre la pantalla

- Haz clic en la pestaña **"Ports"** cerca de la parte inferior de la pantalla
- Haz clic en el icono del globo (🌐) en la fila `6080`
- Se abrirá una nueva pestaña mostrando Suiramu automáticamente (sin pantalla de configuración de conexión)

**El modo video necesita un paso adicional:**
- Presiona el botón de reproducir del **🔊 reproductor de audio** cerca de la parte inferior de la pantalla, una vez
- (Los navegadores bloquean la reproducción automática de audio, así que este clic manual es necesario la primera vez)

---

## 🔁 Si cierras accidentalmente la pestaña de Suiramu

No necesitas volver a la terminal y escribir de nuevo. Haz clic derecho en cualquier zona vacía del fondo y aparecerá un menú para volver a abrir Suiramu.

```
Clic derecho → Suiramu → 🔍 Abrir Suiramu (Búsqueda)
Clic derecho → Suiramu → 🎬 Abrir Suiramu (Video)
```

Al hacer clic, la pantalla de Suiramu se abre de nuevo al instante. Los servicios en segundo plano (como el guardado de datos) siguen funcionando, así que vuelves justo a donde lo dejaste.

---

## 🔄 Cambiar de modo

Presiona `Ctrl + C` en la terminal para detener el modo actual, luego ejecuta el otro comando.

```bash
# Ejemplo: cambiar del modo búsqueda al modo video
Ctrl + C            ← detener el modo actual
npm run video        ← iniciar el modo video
```

---

## 🔍 Funciones del modo búsqueda

- Busca o escribe directamente una URL en la barra de búsqueda del centro de la pantalla
- Elige tu motor de búsqueda entre **Google / Bing / DuckDuckGo / Wikipedia** (menú desplegable sobre la barra de búsqueda)
- Guarda los sitios que usas con frecuencia como iconos (añade con el botón ＋, elimina con clic derecho)
- Las pestañas múltiples y el historial de navegación funcionan exactamente como en un navegador Chromium real
  - `Ctrl + T`: nueva pestaña　`Ctrl + H`: historial　`Ctrl + Shift + T`: reabrir una pestaña cerrada

---

## 🎬 Funciones del modo video

- Desde el principio hay iconos de acceso directo para YouTube / Twitch / Niconico / Vimeo
- La configuración de transmisión de pantalla está ajustada para una reproducción de video fluida
- El audio se transmite por una vía dedicada (un altavoz virtual dentro del Codespace → un flujo de audio)
- También puedes buscar videos desde la barra de búsqueda (te lleva a la búsqueda de YouTube)

### Una nota honesta sobre el audio

Como el audio se transmite por la red, no puede ser **perfectamente continuo ni de latencia cero**. Espera un retraso de unos cientos de milisegundos a un segundo aproximadamente, y cortes ocasionales según tu conexión. Aun así, está ajustado para ser utilizable en la práctica.

Si el video o el audio se entrecortan:
- Mejorar las especificaciones de la máquina de tu Codespace puede ayudar (`Settings → Codespaces → Machine type`)
- Bajar la configuración de calidad de video en el propio sitio también suele ayudar

---

## 💾 Sobre el almacenamiento de datos (integración con cuenta de GitHub)

Los sitios guardados (marcadores) se almacenan automáticamente en **un repositorio privado exclusivo para ti**, `<tu-usuario>/suiramu-data`.

- Este repositorio se crea automáticamente la primera vez que lo ejecutas (Private)
- Los nuevos sitios que añadas se guardan allí automáticamente en unos segundos
- Al crear un nuevo Codespace, se cargarán automáticamente los mismos datos
- Nunca se introduce ni almacena ninguna dirección de correo ni contraseña (simplemente reutiliza la autenticación de GitHub que ya existe en tu Codespace)

---

## 🌍 Idiomas admitidos

Usa el menú desplegable de la esquina superior derecha para cambiar el idioma de la pantalla:

🇯🇵 日本語 / 🇺🇸 English / 🇨🇳 中文 / 🇰🇷 한국어 / 🇪🇸 Español / 🇫🇷 Français

Para traducir un sitio externo que estés visitando, la función de traducción integrada de Chromium funciona como siempre (clic derecho en la página → "Traducir").

### Escribir en japonés, chino, coreano y más

Por defecto, solo se puede escribir en alfanumérico. Si quieres escribir en un idioma que necesita un método de entrada (como japonés o chino), ejecuta **el comando de tu idioma** una vez en la terminal del Codespace. El propio framework de entrada (fcitx5) ya está instalado; solo añades el motor específico del idioma.

| Idioma | Comando a ejecutar en la terminal |
|---|---|
| 🇯🇵 Japonés | `sudo apt-get install -y fcitx5-mozc` |
| 🇨🇳 Chino (simplificado) | `sudo apt-get install -y fcitx5-pinyin` |
| 🇹🇼 Chino (tradicional) | `sudo apt-get install -y fcitx5-chewing` |
| 🇰🇷 Coreano | `sudo apt-get install -y fcitx5-hangul` |
| 🇻🇳 Vietnamita | `sudo apt-get install -y fcitx5-unikey` |
| 🇹🇭 Tailandés | `sudo apt-get install -y fcitx5-libthai` |

Después de instalarlo, ejecuta `npm run search` (o `video`) de nuevo para empezar a usarlo.

**Uso (igual para todos los idiomas):**
- Haz clic en un campo de entrada y escribe; aparecerán candidatos de conversión automáticamente
- Alterna el método de entrada con la tecla de ancho medio/completo, o con `Ctrl + Space`

Para idiomas que no aparecen en la lista, a menudo también hay un paquete `fcitx5-` disponible. Puedes buscarlo en la terminal:

```bash
apt-cache search fcitx5
```

---

## ✉️ Contacto / Sugerencias

Usa "Contacto / Sugerencias" en el menú lateral para enviar un mensaje mediante un formulario sencillo. Al enviarlo se abre una pantalla de creación de Issue de GitHub (se requiere una cuenta de GitHub).

Para publicar directamente, ve [aquí](https://github.com/godrenkon/suiramu-search/issues/new/choose).

---

## 🔒 Sobre la privacidad

- El icono de "Cuenta" es solo un perfil sencillo con un nombre para mostrar, almacenado únicamente dentro del navegador de tu Codespace
- Los datos de los sitios guardados se almacenan en un repositorio privado bajo tu propia cuenta de GitHub, y nunca se envían a ningún servidor gestionado por el proyecto Suiramu
- Nunca se solicita ninguna dirección de correo ni contraseña

---

## 🛠️ Detalles técnicos (para los curiosos)

| Tecnología | Función |
|---|---|
| GitHub Codespaces | El entorno de ejecución (tu propio PC desechable) |
| Xvfb | Pantalla virtual |
| Chromium | El navegador real que se ejecuta |
| x11vnc + noVNC | Transmite la pantalla a tu navegador web |
| PulseAudio + ffmpeg | Transmisión de audio en el modo video |
| GitHub CLI (`gh`) | Persiste los marcadores (usando tu propio repositorio privado) |

El modo búsqueda y el modo video usan configuraciones de compresión distintas en noVNC/x11vnc (equilibrando calidad de imagen y framerate) para optimizar cada caso de uso.

---

## ⚠️ Preguntas frecuentes

**P. Al abrir el puerto 6080 aparece un escritorio en blanco en vez de Chromium**
R. Hay dos causas comunes.

1. **Se abrió el puerto antes de ejecutar `npm run search` o `npm run video`** — La pantalla de Suiramu solo aparece después de ejecutar el comando. Ejecuta primero el comando en la terminal y luego abre la pestaña de puertos.
2. **El navegador no pudo iniciarse** — ejecuta esto en la terminal para comprobar si hay errores:
   ```bash
   cat /tmp/suiramu-chrome.log
   ```
   Si está vacío o muestra un error, intenta volver a ejecutar la configuración:
   ```bash
   npm run setup
   ```

**P. Aparece "No se encontró autenticación de GitHub"**
R. Esto aparece cuando no se encuentra la autenticación necesaria para el guardado automático de marcadores (en tu repositorio privado). Todo lo demás sigue funcionando bien; los marcadores simplemente se guardan de forma temporal dentro del Codespace. Para habilitar la persistencia, prueba esto en la terminal:
   ```bash
   gh auth login
   ```
   Luego ejecuta `npm run search` (o `video`) de nuevo.

**P. Quiero usar el modo búsqueda y el modo video al mismo tiempo**
R. Actualmente, cada Codespace solo puede ejecutar un modo a la vez. Si quieres usar ambos, abre un segundo Codespace en tu navegador e inicia el otro modo allí (ten en cuenta los límites del plan gratuito de GitHub).

**P. ¿Hay un límite de tiempo de uso de Codespace?**
R. Esto depende del tipo de cuenta de GitHub que tengas. Consulta la página de configuración de GitHub para más detalles.

**P. ¿Puedo usar sitios que requieren inicio de sesión (como el portal de mi escuela)?**
R. Sí. Como se ejecuta un navegador Chromium real, puedes iniciar sesión y usarlo con normalidad.

---

## 📞 Soporte

- 🐛 Informes de errores / sugerencias: [Issues](https://github.com/godrenkon/suiramu-search/issues/new/choose)

---

*Hecho para estudiantes que solo quieren buscar y ver videos, sin complicaciones.*
