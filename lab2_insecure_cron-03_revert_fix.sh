#!/bin/bash
# 03_revert_fix.sh - Script para revertir la explotación y aplicar hardening para Cron
# Este script DEBE ejecutarse con sudo.

echo "--- Iniciando reversión y aplicación de hardening para Cron Inseguro ---"

# --- Paso 1: Restaurar los permisos de /bin/bash (si fueron modificados) ---
echo "[1/4] Restaurando los permisos originales de /bin/bash..."
sudo chmod 755 /bin/bash # Permisos estándar para /bin/bash
if [ $? -eq 0 ]; then
    echo "    Permisos de /bin/bash restaurados."
else
    echo "ADVERTENCIA: No se pudieron restaurar los permisos de /bin/bash. Puede que no se hayan cambiado."
fi
ls -la /bin/bash | grep "rws" # Debería no mostrar 'rws'
if [ $? -ne 0 ]; then
    echo "    Verificación: /bin/bash ya no tiene el bit SUID."
else
    echo "ERROR: /bin/bash aún tiene el bit SUID. Falló la reversión."
fi

# --- Paso 2: Eliminar la tarea cron de root ---
VULN_SCRIPT="/opt/insecure_cron_scripts/daily_report.sh"
echo "[2/4] Eliminando la tarea cron de root que ejecutaba el script vulnerable..."
# Exporta la crontab actual, filtra la línea vulnerable, y la vuelve a instalar
sudo crontab -l | grep -v "$VULN_SCRIPT" | sudo crontab -
if [ $? -eq 0 ]; then
    echo "    Tarea cron eliminada."
else
    echo "ADVERTENCIA: No se pudo eliminar la tarea cron. Puede que no existiera."
fi

# --- Paso 3: Eliminar el directorio vulnerable y aplicar hardening real ---
VULN_DIR="/opt/insecure_cron_scripts"
echo "[3/4] Eliminando el directorio vulnerable y aplicando hardening (cambio de permisos)..."
sudo rm -rf "$VULN_DIR" # Eliminar el directorio completamente
if [ $? -eq 0 ]; then
    echo "    Directorio vulnerable '$VULN_DIR' eliminado."
else
    echo "ADVERTENCIA: No se pudo eliminar el directorio vulnerable. Puede que ya no exista."
fi

echo "    **Medidas de Hardening clave aplicadas (conceptos):**"
echo "    - **Permisos de Directorio Estrictos:** NUNCA directorios con scripts de cron de root deben ser escribibles por usuarios no privilegiados. (Lo eliminamos, pero en un caso real se cambiarían a 755)."
echo "    - **Rutas Absolutas en Crontabs:** Siempre especificar la ruta completa a los ejecutables en cron (ej. /usr/bin/php, /bin/bash)."
echo "    - **Principio del Menor Privilegio:** Si una tarea puede ejecutarse con un usuario con menos privilegios, hazlo así."
echo "    - **Monitoreo de Crontabs:** Revisa regularmente 'crontab -l' para root y '/etc/crontab' para cambios."

# --- Paso 4: Notificación final ---
echo "[4/4] Verificando que el script vulnerable ya no existe y el sistema está limpio:"
ls -la "$VULN_SCRIPT" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "    El script vulnerable ha sido removido exitosamente."
    echo ""
    echo "████████████████████████████████████████████████"
    echo "█  ¡RESTABLECIMIENTO EXITOSO! El sistema está  █"
    echo "█     de nuevo en un estado seguro (para este lab). █"
    echo "████████████████████████████████████████████████"
    echo ""
    echo "El laboratorio para la vulnerabilidad de Cron Inseguro ha sido limpiado y revertido."
else
    echo "ERROR: El script vulnerable aún existe. Falló la reversión."
fi

echo "--- Reversión y hardening completados. ---"