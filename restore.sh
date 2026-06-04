#!/usr/bin/env bash
# Restore silentsddm izuna config
# Run as root: sudo bash restore.sh

set -e

BACKUP_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_DIR="/usr/share/sddm/themes/silent"

echo "Restoring silentsddm config..."

cp "$BACKUP_DIR/sddm-system/sddm.conf" /etc/sddm.conf
echo "  /etc/sddm.conf restored"

cp "$BACKUP_DIR/metadata.desktop" "$THEME_DIR/metadata.desktop"
echo "  metadata.desktop restored"

cp "$BACKUP_DIR/configs/izuna-nin.conf" "$THEME_DIR/configs/izuna-nin.conf"
echo "  configs/izuna-nin.conf restored"

if [ -f "$BACKUP_DIR/backgrounds/kuda_izuna_wp.jpg" ]; then
    cp "$BACKUP_DIR/backgrounds/kuda_izuna_wp.jpg" "$THEME_DIR/backgrounds/kuda_izuna_wp.jpg"
    echo "  backgrounds/kuda_izuna_wp.jpg restored"
fi

FONT_DEST="/usr/local/share/fonts/silentsddm"
if [ -d "$BACKUP_DIR/fonts" ] && [ "$(ls -A "$BACKUP_DIR/fonts" 2>/dev/null)" ]; then
    mkdir -p "$FONT_DEST"
    cp "$BACKUP_DIR/fonts/"* "$FONT_DEST/"
    fc-cache -f "$FONT_DEST"
    echo "  fonts restored and cache refreshed"
else
    echo "  fonts/ is empty -- install Bahnschrift and Futura PT manually"
fi

echo "Done. Restart sddm: sudo systemctl restart sddm"
