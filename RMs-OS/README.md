# 🚀 RMs OS - Inicio Rápido

## ¿Qué es RMs OS?

**RMs OS** es tu sistema operativo personalizado basado en Ubuntu, con:
- ✅ Diseño 2D estilo Windows 98 (sin efectos 3D)
- ✅ Ultra ligero (~500MB RAM)
- ✅ Sin elementos innecesarios (sin salvapantallas, sin bloatware)
- ✅ Navegación web completa (YouTube, Netflix, etc.)
- ✅ Terminal de Ubuntu (todos los comandos funcionan)

---

## ⚡ Crear tu ISO (3 Métodos)

### Método 1: Cubic GUI (RECOMENDADO - Más fácil)

```bash
# 1. Instalar Cubic
sudo add-apt-repository ppa:cubic-wizard/release
sudo apt update
sudo apt install -y cubic

# 2. Descargar Ubuntu base
cd /workspace/RMs-OS/iso-build
wget https://releases.ubuntu.com/noble/ubuntu-24.04-live-server-amd64.iso

# 3. Abrir Cubic y seguir el asistente
sudo cubic
```

En Cubic, ejecuta estos comandos en la terminal personalizada:
```bash
apt-get update
apt-get install -y lubuntu-desktop lxqt-core firefox
apt-get remove -y xscreensaver* gnome-screensaver plymouth* snapd
apt-get autoremove -y
apt-get clean

# Configurar modo 2D
echo "export QT_GRAPHICSSYSTEM=native" >> /etc/profile
echo "export KWIN_COMPOSE=N" >> /etc/profile

# Crear usuario
useradd -m -s /bin/bash rms -G sudo
echo "rms:rms123" | chpasswd
```

Luego genera la ISO desde Cubic.

---

### Método 2: Script Automático

```bash
cd /workspace/RMs-OS
sudo chmod +x scripts/build-iso.sh
sudo ./scripts/build-iso.sh
```

⏱️ Tiempo estimado: 30-45 minutos (depende de tu internet)

---

### Método 3: Transformar Ubuntu Existente

Si ya tienes Ubuntu/Lubuntu instalado:

```bash
#!/bin/bash
# Ejecutar como root

apt-get update
apt-get install -y lubuntu-desktop lxqt-core firefox

# Eliminar innecesarios
apt-get remove -y xscreensaver* gnome-screensaver plymouth* snapd whoopsie apport
apt-get autoremove -y

# Forzar modo 2D
echo "export QT_GRAPHICSSYSTEM=native" >> /etc/profile
echo "export KWIN_COMPOSE=N" >> /etc/profile
gsettings set org.gnome.desktop.interface enable-animations false

# Crear usuario
useradd -m -s /bin/bash rms -G sudo
echo "rms:rms123" | chpasswd

echo "¡Listo! Cierra sesión y selecciona LXQt al entrar."
```

---

## 💿 Grabar ISO en USB

### Windows (Rufus):
1. Descarga Rufus: https://rufus.ie
2. Conecta USB (4GB mínimo)
3. Selecciona la ISO `RMs-OS-v1.0.iso`
4. Click "Empezar"

### Linux/Mac:
```bash
# Identificar USB (¡CUIDADO! Se borrará todo)
lsblk

# Grabar ISO (reemplaza sdX con tu USB)
sudo dd if=RMs-OS-v1.0.iso of=/dev/sdX bs=4M status=progress
sync
```

### Alternativa: BalenaEtcher
https://www.balena.io/etcher/ (multiplataforma)

---

## 🖥️ Instalar RMs OS

1. **Arrancar desde USB**
   - Reinicia tu PC
   - Presiona F12/F2/Del para boot menu
   - Selecciona tu USB

2. **Probar o Instalar**
   - "Try RMs OS" → Probar sin instalar
   - "Install RMs OS" → Instalar permanentemente

3. **Seguir instalador**
   - Elige idioma
   - Conecta WiFi (opcional)
   - Elige tipo de instalación:
     - **Borrar disco**: Instala solo RMs OS (borra todo)
     - **Instalar junto a**: Dual-boot con Windows/otro SO
     - **Algo más**: Particionamiento manual

4. **Esperar instalación** (~10-20 minutos)

5. **Reiniciar y retirar USB**

---

## 👤 Primer Acceso

- **Usuario:** `rms`
- **Contraseña:** `rms123`

⚠️ **CAMBIA LA CONTRASEÑA INMEDIATAMENTE:**
```bash
passwd
```

---

## 📝 Primeros Pasos

### 1. Actualizar sistema
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Instalar codecs multimedia
```bash
sudo apt install ubuntu-restricted-extras
```

### 3. Aplicaciones recomendadas
```bash
# Video
sudo apt install vlc

# Ofimática
sudo apt install libreoffice

# Edición de imagen
sudo apt install gimp

# Navegador alternativo
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f -y
```

### 4. Personalizar
Ver `docs/CUSTOMIZE.md` para cambiar colores, temas, iconos, etc.

---

## 🎨 Características Visuales

### Diseño 2D Plano (Sin 3D)
- Fondo sólido teal (#008080)
- Panel inferior clásico
- Ventanas con bordes rectos
- Sin transparencias ni sombras
- Sin animaciones

### Configuración predeterminada:
```ini
Escritorio: Color teal, sin wallpaper
Panel: Inferior, 32px, gris clásico
Ventanas: Bordes rectos 1px, sin redondeo
```

---

## 🗑️ Elementos Eliminados

Para máximo rendimiento, se removieron:
- ❌ Salvapantallas (xscreensaver, gnome-screensaver)
- ❌ Animaciones del sistema
- ❌ Efectos 3D y composición
- ❌ Plymouth (animación de arranque)
- ❌ Snapd (paquetes snap pesados)
- ❌ Apport (reporte de errores)
- ❌ Whoopsie (telemetría)
- ❌ Bloatware preinstalado

**Resultado:** Sistema ~40% más ligero que Ubuntu estándar

---

## 🆘 Problemas Comunes

### Pantalla rara después de instalar
```bash
sudo nano /etc/default/grub
# Cambiar: GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"
sudo update-grub
sudo reboot
```

### No hay sonido
```bash
alsamixer  # Subir volumen
pulseaudio -k && pulseaudio --start
```

### WiFi no conecta
```bash
sudo systemctl restart NetworkManager
```

---

## 📚 Documentación Completa

- `docs/INSTALL.md` → Guía detallada de instalación
- `docs/FAQ.md` → Preguntas frecuentes
- `docs/CUSTOMIZE.md` → Personalización avanzada
- `config/` → Archivos de configuración

---

## ⚙️ Especificaciones Técnicas

| Componente | Detalle |
|------------|---------|
| Base | Ubuntu 24.04 LTS |
| Entorno gráfico | LXQt (2D, sin efectos) |
| Navegador | Firefox |
| Kernel | Linux 6.8+ |
| Soporte | Hasta abril 2029 |
| RAM mínima | 1 GB (500 MB en reposo) |
| Disco mínimo | 8 GB (~5 GB instalados) |

---

## 🎯 ¿Por qué RMs OS?

✅ **Rápido:** Arranca en 15-30 segundos
✅ **Ligero:** Funciona con 1GB RAM
✅ **Clásico:** Estilo Windows 98 auténtico
✅ **Moderno:** Navegación web actual
✅ **Compatible:** Todos los programas de Ubuntu
✅ **Seguro:** Actualizaciones por 5 años
✅ **Tuyo:** Personalizable al 100%

---

## 📞 Soporte

- Lee la documentación en `docs/`
- Comunidades: ubuntuforums.org, askubuntu.com
- Reddit: r/lubuntu, r/linuxquestions

---

**Creado por Ricardo Melendes Silva** ❤️

**¡Disfruta RMs OS - Clásico por fuera, moderno por dentro!** 🚀
