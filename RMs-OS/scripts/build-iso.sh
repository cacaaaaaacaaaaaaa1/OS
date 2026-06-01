#!/bin/bash
# RMs OS - Build Script para crear ISO personalizada
# Basado en Ubuntu Server + LXQt (2D, sin efectos, ultra ligero)
# Creado por Ricardo Melendes Silva

set -e

echo "=========================================="
echo "  RMs OS - Creador de ISO Personalizada"
echo "  Por Ricardo Melendes Silva"
echo "=========================================="

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then 
    echo "Error: Este script debe ejecutarse como root (sudo)"
    exit 1
fi

# Verificar espacio en disco
REQUIRED_SPACE=8G
AVAILABLE_SPACE=$(df / | tail -1 | awk '{print $4}')
if [ "$AVAILABLE_SPACE" -lt 8388608 ]; then
    echo "Error: Se necesitan al menos 8GB libres en disco"
    exit 1
fi

echo ""
echo "[1/8] Instalando herramientas necesarias..."
apt-get update
apt-get install -y cubic live-build debootstrap squashfs-tools xorriso isolinux syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools dosfstools

echo ""
echo "[2/8] Descargando Ubuntu Server 24.04 LTS (base mínima)..."
cd /workspace/RMs-OS/iso-build

# Crear estructura de directorios para la ISO
mkdir -p iso-root/{boot,casper,pool,isolinux}
mkdir -p work

# Descargar imagen base de Ubuntu Server
UBUNTU_URL="https://releases.ubuntu.com/noble/ubuntu-24.04-live-server-amd64.iso"
if [ ! -f ubuntu-base.iso ]; then
    wget -O ubuntu-base.iso "$UBUNTU_URL" || {
        echo "Error al descargar Ubuntu. Usando método alternativo con Cubic..."
        cubic --cli << 'CUBIC_SCRIPT'
# Configuración automática de Cubic
source /etc/cubic.conf
set_release noble
set_architecture amd64
prepare
customize bash << 'CUSTOMIZE'
#!/bin/bash
# Personalización del sistema RMs OS
echo "Configurando RMs OS..."

# Actualizar repositorios
apt-get update

# Instalar entorno gráfico LXQt (2D, sin efectos 3D)
apt-get install -y lubuntu-desktop lxqt-core plasma-browser-integration firefox

# Eliminar componentes innecesarios (ahorro de espacio y recursos)
apt-get remove -y xscreensaver xscreensaver-data* gnome-screensaver
apt-get remove -y kde-config-fcitx kde-style-breeze-qt5 kde-config-plymouth
apt-get remove -y plymouth* snapd whoopsie apport apport-gtk
apt-get autoremove -y
apt-get clean

# Configurar tema Windows 98 (2D plano)
mkdir -p /root/.config/lxqt
cat > /root/.config/lxqt/desktop.conf << 'EOF'
[Desktop]
background=#008080
wallpaperMode=solidColor
showIcons=false
EOF

# Configurar panel estilo Windows 98
cat > /root/.config/lxqt/panel.conf << 'EOF'
[Panel]
size=32
position=Bottom
alignment=Left
length=100
font=Sans Serif,9,-1,5,50,0,0,0,0,0
iconSize=24
autohide=false
visibleMargin=false
animation=0
reserveSpace=true
hidable=false
EOF

# Desactivar efectos 3D y animaciones
gsettings set org.gnome.desktop.interface enable-animations false 2>/dev/null || true
echo "export QT_GRAPHICSSYSTEM=native" >> /etc/profile

# Configurar Firefox para sitios modernos
mkdir -p /etc/firefox/policies
cat > /etc/firefox/policies/policies.json << 'EOF'
{
  "policies": {
    "Homepage": {
      "URL": "https://www.google.com",
      "Locked": false
    },
    "DisableTelemetry": true,
    "DisablePocket": true
  }
}
EOF

# Crear usuario por defecto (se cambia en primera instalación)
echo "Usuario por defecto: rms (contraseña: rms123)"
useradd -m -s /bin/bash rms -G sudo
echo "rms:rms123" | chpasswd

# Mensaje de bienvenida
cat > /etc/motd << 'EOF'
╔════════════════════════════════════════════╗
║     Bienvenido a RMs OS                    ║
║     Sistema Operativo por                  ║
║     Ricardo Melendes Silva                 ║
║                                            ║
║     Estilo clásico, velocidad moderna      ║
╚════════════════════════════════════════════╝
EOF

# Optimizaciones de rendimiento
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf

echo "RMs OS configurado exitosamente!"
CUSTOMIZE
build_iso
exit
CUBIC_SCRIPT
        exit 0
    }
fi

echo ""
echo "[3/8] Extrayendo imagen base..."
# Montar ISO original
mount -o loop ubuntu-base.iso /mnt
cp -r /mnt/* iso-root/
cp /mnt/boot/vmlinuz iso-root/casper/ 2>/dev/null || cp /mnt/casper/vmlinuz iso-root/casper/
umount /mnt

echo ""
echo "[4/8] Preparando sistema personalizado..."
cd iso-root

# Modificar cmdline para arranque automático
sed -i 's/quiet splash/quiet splash nomodeset i915.modeset=0/' boot/grub/grub.cfg 2>/dev/null || true

echo ""
echo "[5/8] Creando archivo de personalización..."
# Script que se ejecutará en primera instalación
cat > custom-setup.sh << 'SCRIPT'
#!/bin/bash
# Script de configuración post-instalación para RMs OS

echo "Configurando RMs OS por primera vez..."

# Eliminar elementos innecesarios
apt-get remove -y xscreensaver* gnome-screensaver plymouth* 2>/dev/null || true
apt-get autoremove -y
apt-get clean

# Forzar modo 2D
echo "export QT_GRAPHICSSYSTEM=native" >> /etc/profile
echo "export KWIN_COMPOSE=N" >> /etc/profile

# Configurar tema visual Windows 98
apt-get install -y qt5-style-plugins
echo "* { font: 9pt 'Sans Serif'; }" > /usr/share/lxqt/themes/RMs-98/style.qss

echo "¡RMs OS está listo!"
SCRIPT

chmod +x custom-setup.sh

echo ""
echo "[6/8] Generando nueva ISO..."
cd /workspace/RMs-OS/iso-build

# Crear ISO booteable
xorriso -as mkisofs \
    -V "RMs_OS_v1" \
    -o ../RMs-OS-v1.0.iso \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -J \
    -R \
    iso-root

if [ -f ../RMs-OS-v1.0.iso ]; then
    SIZE=$(du -h ../RMs-OS-v1.0.iso | cut -f1)
    echo ""
    echo "=========================================="
    echo "  ¡ISO creada exitosamente!"
    echo "  Archivo: /workspace/RMs-OS/RMs-OS-v1.0.iso"
    echo "  Tamaño: $SIZE"
    echo "=========================================="
    echo ""
    echo "Para instalar:"
    echo "1. Graba esta ISO en una USB con Rufus o BalenaEtcher"
    echo "2. Arranca tu PC desde la USB"
    echo "3. Sigue el instalador de Ubuntu"
    echo "4. ¡Disfruta RMs OS!"
    echo ""
else
    echo "Error: No se pudo crear la ISO"
    exit 1
fi

echo ""
echo "Nota: Para una personalización más avanzada, usa Cubic GUI:"
echo "  sudo cubic"
