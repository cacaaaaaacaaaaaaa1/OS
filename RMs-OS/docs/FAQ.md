# RMs OS - Preguntas Frecuentes (FAQ)

## 📌 Sobre la ISO

### ¿Me diste una ISO ya hecha?
**No.** Te di los **scripts y herramientas** para crear TU propia ISO personalizada. Esto es mejor porque:
- Puedes elegir qué versión de Ubuntu usar
- Puedes modificar paquetes antes de crear la ISO
- Es más transparente (ves exactamente qué incluye)
- Puedes crear múltiples versiones

### ¿Cómo obtengo la ISO?
Tienes 3 opciones:

**Opción A - Cubic (Más fácil, recomendado):**
```bash
sudo add-apt-repository ppa:cubic-wizard/release
sudo apt update
sudo apt install cubic
sudo cubic
```
Luego sigue el asistente gráfico.

**Opción B - Script automático:**
```bash
cd /workspace/RMs-OS
sudo chmod +x scripts/build-iso.sh
sudo ./scripts/build-iso.sh
```

**Opción C - Transformar Ubuntu existente:**
Si ya tienes Ubuntu instalado, solo ejecuta los comandos de personalización en `docs/INSTALL.md` (Método 3).

### ¿Cuánto tarda en crearse la ISO?
- Descarga de Ubuntu: 10-30 minutos (depende de tu internet)
- Personalización: 5-15 minutos
- Total: 15-45 minutos aproximadamente

### ¿Qué tamaño tiene la ISO?
Aproximadamente **2.5 - 3.5 GB**, dependiendo de los paquetes incluidos.

---

## 🖥️ Sobre el Diseño 2D

### ¿Por qué todo es 2D?
- **Rendimiento**: Los efectos 3D consumen GPU y RAM innecesariamente
- **Velocidad**: Sin composición, las ventanas se dibujan instantáneamente
- **Estilo retro**: Windows 98 era completamente 2D
- **Compatibilidad**: Funciona en hardware muy antiguo sin aceleración 3D

### ¿Qué se eliminó específicamente?
- ❌ KWin Compositing (efectos de escritorio)
- ❌ Animaciones de ventanas
- ❌ Transparencias
- ❌ Sombras en ventanas
- ❌ Efectos de minimizar/maximizar
- ❌ Salvapantallas animados
- ❌ Plymouth (animación de arranque)

### ¿Se ve "feo" por ser 2D?
¡No! El diseño 2D plano es:
- Limpio y profesional
- Estilo retro auténtico
- Fácil de leer
- Nostálgico pero funcional

---

## ⚡ Sobre el Rendimiento

### ¿Qué tan rápido es comparado con Ubuntu normal?

| Métrica | Ubuntu Standard | RMs OS |
|---------|----------------|--------|
| RAM en reposo | ~1.2 GB | ~500 MB |
| Tiempo de arranque | 45-60 seg | 15-30 seg |
| Espacio en disco | ~8-10 GB | ~4-5 GB |
| Aplicaciones al inicio | 15+ | 5 |

### ¿Funciona en mi PC vieja?
Probablemente sí. Requisitos mínimos:
- Procesador: 1 GHz (cualquier dual-core de 2008+)
- RAM: 1 GB mínimo (2 GB recomendado)
- Disco: 8 GB libres
- Sin necesidad de tarjeta gráfica dedicada

### ¿Puedo usarlo como mi sistema principal diario?
¡Sí! Miles de personas usan Lubuntu/LXQt como sistema principal. Es perfecto para:
- Navegación web
- Ofimática (LibreOffice)
- Reproducción de video/música
- Programación
- Uso general

---

## 🌐 Sobre Internet y Navegación

### ¿Puedo ver YouTube?
**Sí, perfectamente.** Firefox incluido soporta:
- YouTube (hasta 4K si tu hardware lo permite)
- Netflix (con DRM habilitado)
- Twitch
- Vimeo
- Todas las redes sociales

### ¿Y videollamadas?
Sí, funciona con:
- Google Meet
- Zoom (versión web o app nativa)
- Microsoft Teams
- Skype
- Jitsi

### ¿Necesito instalar codecs de video?
Recomendado sí:
```bash
sudo apt install ubuntu-restricted-extras
```
Esto agrega soporte para MP3, DVD, Flash, etc.

### ¿El WiFi funciona automáticamente?
En el 95% de los casos, sí. Ubuntu tiene drivers para la mayoría de tarjetas WiFi.

Si tu WiFi no funciona:
```bash
# Verificar si se detecta la tarjeta
lspci | grep -i network

# Instalar drivers adicionales
sudo apt install firmware-linux-nonfree
```

---

## 🔧 Sobre la Terminal

### ¿Es la misma terminal de Ubuntu?
**Exactamente.** Todos los comandos de Ubuntu funcionan:
- `apt` para instalar programas
- `systemctl` para servicios
- `grep`, `awk`, `sed` para procesamiento de texto
- Scripts de bash compatibles 100%

### ¿Puedo instalar programas de Ubuntu?
**Sí, todos.** Tienes acceso completo a:
- Repositorios oficiales de Ubuntu
- PPAs (Personal Package Archives)
- Paquetes .deb descargados
- Snap (aunque lo removimos para ahorrar espacio, puedes reinstalarlo)
- Flatpak (si lo instalas)

### Ejemplos de instalación:
```bash
# Desde repositorios
sudo apt install vlc gimp inkscape

# Desde PPA
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt install obs-studio

# Desde .deb
wget https://example.com/paquete.deb
sudo dpkg -i paquete.deb
```

---

## 👤 Usuario y Seguridad

### ¿Cuál es la contraseña por defecto?
- Usuario: `rms`
- Contraseña: `rms123`

**⚠️ CAMBIALA INMEDIATAMENTE DESPUÉS DE INSTALAR!**
```bash
passwd
```

### ¿Es seguro?
Sí, tan seguro como Ubuntu porque:
- Mismas actualizaciones de seguridad
- Mismo kernel
- Mismos mecanismos de protección
- Firewall disponible (ufw)

### ¿Debo usar antivirus?
En Linux generalmente no es necesario, pero si quieres:
```bash
sudo apt install clamav clamtk
```

### ¿Cómo activo el firewall?
```bash
sudo ufw enable
sudo ufw status
```

---

## 💾 Instalación

### ¿Puedo probarlo antes de instalar?
**Sí!** Dos opciones:

**1. Modo Live USB:**
Al arrancar desde el USB, selecciona "Try RMs OS" para probar sin instalar.

**2. VirtualBox:**
```bash
sudo apt install virtualbox
# Crear VM, montar ISO, probar
```

### ¿Borra mis archivos al instalar?
Depende de lo que elijas:
- **Instalar junto a...** → No borra nada, crea partición nueva
- **Borrar disco e instalar** → Borra TODO el disco
- **Algo más** → Tú decides qué particiones formatear

**⚠️ Siempre respalda tus archivos importantes antes de instalar cualquier SO!**

### ¿Puedo tener Windows y RMs OS juntos?
**Sí, dual-boot:**
1. Instala primero Windows
2. Luego instala RMs OS
3. El instalador detectará Windows y ofrecerá dual-boot
4. Al arrancar, eliges cuál usar

### ¿Cuánto espacio necesito?
- Mínimo: 8 GB
- Recomendado: 20+ GB
- Cómodo: 40+ GB

---

## 🎮 Juegos

### ¿Puedo jugar?
**Juegos ligeros SÍ:**
- Emuladores retro (NES, SNES, GBA, PS1)
- Juegos 2D indie (Stardew Valley, Celeste, Hollow Knight)
- Juegos de navegador
- Minecraft (versión Java, settings bajos)

**Juegos modernos NO realmente:**
- AAA recientes requieren mucho más poder
- Anti-cheat de juegos online no funciona en Linux

### ¿Cómo instalo emuladores?
```bash
# RetroArch (todo-en-uno)
sudo apt install retroarch

# Emuladores individuales
sudo apt install snes9x-gtk mednafen mupen64plus
```

### ¿Steam funciona?
**Sí!** Steam tiene versión nativa para Linux:
```bash
sudo apt install steam
```
Muchos juegos de Steam funcionan en Linux (busca el logo de Steam Play/Proton).

---

## 🔄 Actualizaciones

### ¿Cómo actualizo?
```bash
sudo apt update
sudo apt upgrade
```

### ¿Cada cuánto debo actualizar?
- **Seguridad**: Inmediatamente cuando haya actualizaciones críticas
- **Normal**: Una vez por semana está bien
- **Importante**: No actualices justo antes de trabajo importante

### ¿Las actualizaciones rompen algo?
Raramente en Ubuntu LTS. Las versiones LTS son muy estables. Si algo sale mal:
```bash
# Ver logs de errores
cat /var/log/apt/term.log

# Revertir última actualización (si es necesario)
sudo apt install --reinstall <paquete-problemático>
```

### ¿Hasta cuándo recibe actualizaciones?
**5 años** desde abril 2024 → **Abril 2029**

Después puedes:
- Actualizar a versión nueva de RMs OS
- Seguir usando (ya no habrá actualizaciones de seguridad)

---

## 🛠️ Solución de Problemas

### La pantalla se ve rara después de instalar
```bash
# Forzar modo de video básico
# Editar GRUB
sudo nano /etc/default/grub

# Cambiar esta línea:
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"

# Actualizar GRUB
sudo update-grub
sudo reboot
```

### No hay sonido
```bash
# Verificar volumen
alsamixer

# Reiniciar servicio de audio
pulseaudio -k
pulseaudio --start

# Verificar salida de audio
pactl list short sinks
```

### El WiFi no conecta
```bash
# Reiniciar network manager
sudo systemctl restart NetworkManager

# Verificar estado
nmcli device status

# Olvidar red y reconectar
nmcli connection delete "nombre-red"
# Luego conectar desde el applet de red
```

### Se cuelga frecuentemente
```bash
# Verificar logs
dmesg | tail -50
journalctl -xb | tail -50

# Verificar temperatura
sensors

# Verificar uso de RAM
free -h
htop
```

---

## 📞 Soporte

### ¿Dónde puedo obtener ayuda?

1. **Documentación incluida**: Lee `INSTALL.md` y `CUSTOMIZE.md`
2. **Comunidad Ubuntu**: https://ubuntuforums.org
3. **Comunidad Lubuntu**: https://lubuntu.me
4. **Ask Ubuntu**: https://askubuntu.com
5. **Reddit**: r/lubuntu, r/linuxquestions

### ¿Ricardo da soporte?
Este es un proyecto personal creado por Ricardo Melendes Silva. El soporte principal viene de la comunidad Ubuntu/Lubuntu.

---

## 🎯 Misceláneo

### ¿Puedo cambiarle el nombre a MI versión?
¡Sí! Es tu sistema. Modifica:
- Nombre en el script de construcción
- Logo/wallpaper
- Mensajes de bienvenida
- Usuario predeterminado

### ¿Es legal?
**Sí.** Ubuntu es software libre (GPL). Puedes:
- Modificarlo
- Distribuirlo
- Venderlo (con ciertas condiciones)

Solo debes:
- Mantener la licencia GPL
- Dar crédito a Ubuntu
- Hacer disponible el código fuente si distribuyes

### ¿Por qué se llama RMs?
Por las iniciales de **R**icardo **M**elendes **S**ilva.

### ¿Puedo ponerle otro nombre?
¡Claro! Algunos ejemplos:
- RMS OS (más formal)
- SilvaOS
- Melendes Linux
- TuNombre OS

Solo edita los scripts y documentación.

---

## 📊 Comparativa Rápida

| Característica | Windows 98 | Windows 10/11 | RMs OS |
|---------------|------------|---------------|--------|
| RAM mínima | 16 MB | 4 GB | 500 MB |
| Espacio disco | 500 MB | 64 GB | 5 GB |
| Interfaz | 2D clásica | 3D moderna | 2D clásica |
| Navegación web | Limitada | Completa | Completa |
| Seguridad | Obsoleto | Buena | Excelente |
| Costo | Era gratis | $139 USD | Gratis |
| Actualizaciones | No hay | Sí | Sí (hasta 2029) |

---

**¿Tienes más preguntas?** Únete a foros de Ubuntu o consulta la documentación oficial.

**Creado por Ricardo Melendes Silva** ❤️
