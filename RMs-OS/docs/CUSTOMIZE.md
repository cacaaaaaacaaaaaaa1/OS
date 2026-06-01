# 🎨 Guía de Personalización de RMs OS

Personaliza tu RMs OS para hacerlo aún más único. Todas las modificaciones mantienen el estilo 2D plano.

---

## 🖼️ Cambiar Color de Fondo

El color predeterminado es teal (#008080), pero puedes cambiarlo:

### Opción 1: Desde la terminal
```bash
# Colores clásicos de Windows 98
# Teal: #008080 (predeterminado)
# Gris: #808080
# Azul oscuro: #000080
# Verde oliva: #808000

# Editar configuración
nano ~/.config/lxqt/desktop.conf

# Cambiar esta línea:
background=#008080  # Cambia el código hexadecimal
```

### Opción 2: Colores predefinidos
```bash
# Fondo gris clásico
echo "background=#808080" >> ~/.config/lxqt/desktop.conf

# Fondo negro
echo "background=#000000" >> ~/.config/lxqt/desktop.conf

# Fondo azul marino
echo "background=#000080" >> ~/.config/lxqt/desktop.conf
```

Luego cierra sesión y vuelve a entrar.

---

## 🔧 Personalizar Panel

### Cambiar posición del panel
```bash
nano ~/.config/lxqt/panel.conf

# Opciones de posición:
# position=Top       # Arriba
# position=Bottom    # Abajo (predeterminado)
# position=Left      # Izquierda
# position=Right     # Derecha
```

### Cambiar tamaño del panel
```ini
[Panel]
size=28    # Más delgado (predeterminado: 32)
size=40    # Más grueso
```

### Color del panel
Edita `~/.config/lxqt/panel.conf`:
```ini
[Panel]
backgroundColor=#c0c0c0    # Gris claro clásico
# o
backgroundColor=#000000    # Negro
# o
backgroundColor=#ffffff    # Blanco
```

---

## 🎨 Temas Visuales

### Instalar tema Windows 98 auténtico
```bash
# Descargar tema qtcurve con estilo Win98
sudo apt install qt5-style-plugins

# Aplicar tema
mkdir -p ~/.config/qt5ct
cat > ~/.config/qt5ct/qt5ct.conf << 'EOF'
[Appearance]
style=qtcurve
color_scheme=normal
icon_theme=oxygen
EOF
```

### Tema minimalista plano
El tema incluido `RMs-98` ya está configurado para ser completamente plano 2D.

Para activarlo:
```bash
# Copiar tema al directorio del sistema
sudo mkdir -p /usr/share/lxqt/themes/RMs-98
sudo cp /workspace/RMs-OS/config/theme.qss /usr/share/lxqt/themes/RMs-98/

# Configurar LXQt para usar el tema
echo "stylesheet=RMs-98/style.qss" >> ~/.config/lxqt/lxqt.conf
```

---

## 🔊 Sonidos Clásicos

### Agregar sonidos de Windows 98
```bash
# Instalar paquete de sonidos
sudo apt install kde-config-sddm

# Descargar sonidos retro (opcional)
cd /tmp
wget https://github.com/SomeGitHubUser/win98-sounds/archive/main.zip
unzip main.zip
sudo cp win98-sounds-main/*.wav /usr/share/sounds/freedesktop/stereo/

# Configurar en LXQt
# Panel → Preferencias → Configuración de sonido
```

### Desactivar todos los sonidos (más rápido)
```bash
# Silenciar sonidos del sistema
pactl set-sink-mute 0 1 2>/dev/null || true
```

---

## 🖥️ Iconos

### Cambiar conjunto de iconos
```bash
# Iconos clásicos simples
sudo apt install gnome-icon-theme

# Iconos minimalistas
sudo apt install papirus-icon-theme

# Configurar
echo "icon_theme=Papirus-Light" >> ~/.config/lxqt/desktop.conf
```

### Iconos cuadrados estilo Win98
```bash
# Descargar iconos retro
cd /tmp
git clone https://github.com/B00merang-Artwork/Windows-95.git
mkdir -p ~/.icons/Win98
cp -r Windows-95/* ~/.icons/Win98/

# Activar
echo "icon_theme=Win98" >> ~/.config/lxqt/desktop.conf
```

---

## ⌨️ Fuentes

### Fuentes clásicas
```bash
# Instalar fuentes tipo Windows
sudo apt install ttf-mscorefonts-installer

# Configurar fuente del sistema
cat >> ~/.config/lxqt/desktop.conf << 'EOF'
font=Tahoma,9,-1,5,50,0,0,0,0,0
EOF
```

### Fuentes modernas legibles
```bash
# Fuente Noto (moderna y clara)
sudo apt install fonts-noto

# Configurar
echo "font=Noto Sans,9,-1,5,50,0,0,0,0,0" >> ~/.config/lxqt/desktop.conf
```

---

## 🚀 Optimizaciones Adicionales

### Desactivar índice de búsqueda (ahorra RAM)
```bash
sudo systemctl disable baloo_file
```

### Limitar aplicaciones de inicio
```bash
# Ver aplicaciones que inician automáticamente
lxqt-config-session

# Deshabilitar las innecesarias
# Mantener solo: panel, desktop, notificationd
```

### Aumentar rendimiento de red
```bash
# Optimizar TCP
cat >> /etc/sysctl.conf << 'EOF'
net.ipv4.tcp_fastopen=3
net.core.rmem_max=16777216
net.core.wmem_max=16777216
EOF

sudo sysctl -p
```

---

## 📱 Agregar Aplicaciones Útiles

### Esenciales
```bash
# Reproductor de video ligero
sudo apt install mpv

# Editor de texto avanzado
sudo apt install geany

# Gestor de archivos dual-pane
sudo apt install doublecmd-gtk

# Terminal mejorada
sudo apt install terminator
```

### Entretenimiento
```bash
# Emulador de juegos retro
sudo apt install retroarch

# Juegos ligeros incluidos
sudo apt install gnome-chess gnome-sudoku
```

### Productividad
```bash
# Suite ofimática completa
sudo apt install libreoffice-writer libreoffice-calc libreoffice-impress

# Cliente de correo ligero
sudo apt install thunderbird

# Navegador alternativo (Chrome)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f -y
```

---

## 🎯 Crear Tu Propia Versión

Si quieres crear tu propia versión modificada de RMs OS:

### Paso 1: Modificar scripts
Edita `/workspace/RMs-OS/scripts/build-iso.sh` y cambia:
- Nombre del sistema
- Usuario predeterminado
- Contraseña
- Paquetes instalados
- Configuraciones

### Paso 2: Reconstruir ISO
```bash
cd /workspace/RMs-OS
sudo ./scripts/build-iso.sh
```

### Paso 3: Probar en VirtualBox
```bash
sudo apt install virtualbox
# Crear nueva máquina virtual
# Asignar 2GB RAM, 20GB disco
# Montar ISO creada
# Probar antes de instalar en físico
```

---

## 📸 Capturas de Pantalla

Para tomar capturas:
```bash
# Instalar herramienta
sudo apt install flameshot

# Usar
flameshot gui
```

---

## 🔄 Restaurar Configuración Original

Si algo sale mal, restaura valores predeterminados:
```bash
# Respaldar configuración actual
mv ~/.config/lxqt ~/.config/lxqt.backup

# Copiar configuración original
cp /workspace/RMs-OS/config/* ~/.config/lxqt/

# Reiniciar sesión
```

---

## 💡 Consejos Finales

1. **Mantén todo en 2D**: No instales compositors como picom o kwin_effects
2. **Menos es más**: Cada aplicación adicional consume recursos
3. **Actualiza regularmente**: `sudo apt update && sudo apt upgrade -y`
4. **Respaldos**: Usa `rsync` o `timeshift` para respaldos
5. **Diviértete**: ¡Es TU sistema operativo personalizado!

---

**Creado por Ricardo Melendes Silva para RMs OS**
¡Hazlo tuyo! 🚀
