# 🚀 RMs OS - Guía de Construcción en Windows (MSYS2)

**Creado para:** Ricardo Melendes Silva  
**Estilo:** Windows 2.0 / Consola Gráfica Ultra-Ligera  
**Peso Objetivo:** ~450-550 MB

---

## 📋 ¿Qué necesitas?

1.  **Windows 10/11** (cualquier versión)
2.  **Espacio en disco:** Al menos 2 GB libres
3.  **Conexión a Internet** (para descargar componentes)
4.  **Una memoria USB** de 2GB o más (para probar la ISO después)

---

## 🔧 PASO 1: Instalar MSYS2

### 1.1 Descargar MSYS2
Ve a: https://www.msys2.org/  
Descarga el instalador: `msys2-x86_64-latest.exe`

### 1.2 Instalar MSYS2
- Ejecuta el instalador
- Elige la ruta por defecto: `C:\msys64`
- Marca todas las opciones
- Finaliza la instalación

### 1.3 Actualizar MSYS2
Abre **MSYS2 MSYS** desde el menú inicio y ejecuta:

```bash
pacman -Syu
```

Si te pide cerrar y volver a abrir, hazlo. Luego ejecuta de nuevo:

```bash
pacman -Su
```

---

## 🔧 PASO 2: Instalar Herramientas Necesarias

Abre **MSYS2 MINGW64** (importante: usa MINGW64, no MSYS) y ejecuta:

```bash
pacman -S --needed base-devel mingw-w64-x86_64-toolchain wget xorriso git
```

Presiona `Y` cuando te pregunte si quieres continuar.

Esto instalará:
- `wget` - Para descargar archivos
- `xorriso` - Para crear la ISO
- `git` - Para clonar/configurar el proyecto
- Compiladores necesarios

---

## 🔧 PASO 3: Obtener el Script RMs OS

### Opción A: Copiar desde este repositorio
Si ya tienes los archivos en tu computadora:

```bash
cd /c/workspace/RMs-OS/scripts
```

(Ajusta la ruta según donde tengas guardados los archivos)

### Opción B: Descargar directamente
```bash
cd ~
mkdir rmos-build
cd rmos-build
wget https://raw.githubusercontent.com/tu-usuario/rms-os/main/scripts/build-iso-msys2.sh
chmod +x build-iso-msys2.sh
```

---

## 🔧 PASO 4: Ejecutar el Script

Desde la terminal MINGW64, ejecuta:

```bash
./build-iso-msys2.sh
```

### ¿Qué hará el script?

1.  ✅ Verificará que tienes las herramientas necesarias
2.  ✅ Creará un directorio temporal de trabajo
3.  ✅ Descargará la base de Debian Netinst (~600MB)
4.  ✅ Extraerá la ISO base
5.  ✅ Inyectará la configuración personalizada de RMs OS:
    - Configuración de instalación automática
    - Tema visual estilo Windows 2.0 (JWM)
    - Scripts de limpieza post-instalación
6.  ✅ Reconstruirá la ISO final (~450-550MB)

**Tiempo estimado:** 15-30 minutos (depende de tu internet)

---

## 🎨 ¿Qué incluye RMs OS?

### Entorno Gráfico (JWM - Joe's Window Manager)
- **Estilo:** Windows 2.0 / Consola clásica
- **Colores:** Azul clásico (#0000AA), gris (#C0C0C0)
- **Menú:** Simple, tipo texto, muy rápido
- **Ventanas:** Bordes rectos, sin efectos 3D
- **Fondo:** Sólido, sin imágenes pesadas

### Aplicaciones Incluidas
| Aplicación | Descripción |
|------------|-------------|
| **JWM** | Gestor de ventanas ultra-ligero |
| **Xterm** | Terminal clásica (consola gráfica) |
| **Firefox ESR** | Navegador moderno pero ligero |
| **Wget/Curl** | Descarga de archivos |
| **Git** | Control de versiones |
| **Firmware** | Soporte para Wi-Fi y hardware |

### Lo que NO incluye (para mantenerlo ligero)
- ❌ Salvapantallas
- ❌ Animaciones o efectos 3D
- ❌ Oficina pesada (LibreOffice completo)
- ❌ Multimedia pesado (VLC, etc.)
- ❌ Juegos preinstalados
- ❌ Telemetría o servicios en segundo plano

---

## 💾 PASO 5: Grabar la ISO en USB

Una vez creada la ISO (`RMs_OS_UltraLight_v1.iso`):

### Usando Rufus (Recomendado)
1.  Descarga Rufus: https://rufus.ie/
2.  Conecta tu USB
3.  Abre Rufus
4.  Selecciona tu USB
5.  Haz clic en "SELECCIONAR" y busca tu ISO
6.  Esquema de partición: **MBR** (para BIOS/UEFI compatible)
7.  Haz clic en "EMPEZAR"

### Usando BalenaEtcher
1.  Descarga Etcher: https://www.balena.io/etcher/
2.  Abre Etcher
3.  "Flash from file" → selecciona tu ISO
4.  "Select target" → elige tu USB
5.  "Flash!"

---

## 🧪 PASO 6: Probar en VirtualBox (Opcional pero recomendado)

Antes de instalar en tu PC real, prueba en una máquina virtual:

### Instalar VirtualBox
1.  Descarga: https://www.virtualbox.org/
2.  Instálalo
3.  Crea una nueva máquina virtual:
    - Nombre: `RMs OS`
    - Tipo: `Linux`
    - Versión: `Debian (64-bit)`
    - RAM: `512 MB` mínimo (1024 MB recomendado)
    - Disco: `8 GB` mínimo

### Configurar la VM
1.  Ve a Configuración → Almacenamiento
2.  En "Controlador: IDE", haz clic en el icono de disco
3.  Selecciona "Seleccionar un archivo de disco..."
4.  Busca tu ISO de RMs OS
5.  Acepta y inicia la máquina virtual

---

## 🖥️ Primer Arranque

Al iniciar RMs OS verás:

1.  **Pantalla de inicio minimalista** (texto blanco sobre fondo negro)
2.  **Instalador automático** (si elegiste esa opción)
3.  **Escritorio azul clásico** con:
    - Barra inferior simple
    - Menú "RMs" en la esquina
    - Terminal lista para usar
    - Navegador Firefox disponible

### Comandos útiles después de instalar

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar aplicaciones adicionales
sudo apt install nombre-del-programa -y

# Ejemplos:
sudo apt install vlc -y              # Reproductor de video
sudo apt install gimp -y             # Editor de imágenes
sudo apt install libreoffice -y      # Suite ofimática completa
sudo apt install thunderbird -y      # Cliente de correo
```

---

## 🎛️ Personalización Básica

### Cambiar el color de fondo
Edita `/etc/jwm/tray` o tu `~/.jwmrc`:

```xml
<Background type="solid">#008080</Background>  <!-- Verde azulado -->
<Background type="solid">#000000</Background>  <!-- Negro -->
<Background type="solid">#800000</Background>  <!-- Rojo oscuro -->
```

### Cambiar la resolución de pantalla
```bash
xrandr --output VGA-1 --mode 1920x1080
```

(Ajusta `VGA-1` según tu monitor, usa `xrandr` solo para ver las opciones)

### Agregar programas al menú
Edita `/etc/jwm/jwmrc` o `~/.jwmrc` y agrega:

```xml
<Program label="Firefox" icon="firefox">firefox</Program>
<Program label="Terminal" icon="terminal">xterm</Program>
```

---

## ❓ Preguntas Frecuentes

### ¿Necesito licencia?
No, RMs OS es completamente gratuito y de código abierto (basado en Debian).

### ¿Funciona mi Wi-Fi?
Sí, incluye firmware no-libre para la mayoría de tarjetas Wi-Fi.

### ¿Puedo usar Netflix/YouTube?
Sí, Firefox ESR incluido soporta ambos sitios perfectamente.

### ¿Es seguro?
Sí, recibe actualizaciones de seguridad de Debian directamente.

### ¿Cuánto RAM usa?
En reposo: ~200-300 MB (¡ultra ligero!)

### ¿Puedo jugar juegos?
Juegos ligeros sí (emuladores retro, juegos indie). No está diseñado para gaming pesado.

### ¿Se puede actualizar a Ubuntu después?
Sí, pero recomendamos mantenerlo como Debian para estabilidad.

---

## 🆘 Solución de Problemas

### Error: "wget no encontrado"
```bash
pacman -S wget
```

### Error: "xorriso no encontrado"
```bash
pacman -S libisoburn
```

### La ISO no arranca
- Verifica que la grabaste correctamente en el USB
- Prueba con otro puerto USB (usa USB 2.0 si hay problemas)
- En VirtualBox, asegúrate de habilitar EFI si es necesario

### No hay sonido
```bash
sudo apt install pulseaudio alsa-utils
sudo alsamixer  # Sube el volumen
```

### No hay internet después de instalar
```bash
# Verifica tu conexión
ip a

# Si usas Wi-Fi
sudo apt install network-manager
sudo nmcli device wifi connect "TU_RED" password "TU_CONTRASEÑA"
```

---

## 📞 Contacto y Soporte

Este sistema fue creado especialmente para **Ricardo Melendes Silva**.

Para personalización adicional o soporte, consulta los archivos:
- `CUSTOMIZE.md` - Guía avanzada de personalización
- `FAQ.md` - Preguntas frecuentes extendida

---

## 🎉 ¡Disfruta tu RMs OS!

Tienes un sistema operativo:
- ✅ Ultra ligero (~450-550 MB)
- ✅ Rápido (arranca en segundos)
- ✅ Personalizable
- ✅ Estilo retro Windows 2.0
- ✅ Moderno por dentro (navegación, seguridad, actualizaciones)
- ✅ 100% tuyo

**¡A programar, navegar y disfrutar!** 🚀
