#!/bin/bash
# 00_setup_lab.sh - Script para configurar el entorno Cron vulnerable
# Este script DEBE ejecutarse con sudo.

echo "--- Iniciando configuración del laboratorio Cron vulnerable ---"

# --- Paso 1: Crear el directorio con permisos de escritura laxos ---
VULN_DIR="/opt/insecure_cron_scripts"
echo "[1/4] Creando el directorio vulnerable para scripts de cron: $VULN_DIR"
sudo mkdir -p "$VULN_DIR"
sudo chmod 777 "$VULN_DIR" # Permisos de escritura para todos (PELIGROSO)
if [ $? -ne 0 ]; then
    echo "ERROR: Falló la creación del directorio o los permisos."
    exit 1
fi
echo "    Directorio creado con permisos 777. ¡Esta es la vulnerabilidad principal!"
ls -ld "$VULN_DIR" | grep "rwxrwxrwx"
if [ $? -ne 0 ]; then
    echo "ADVERTENCIA: Los permisos del directorio no son 777. Algo salió mal."
fi

# --- Paso 2: Crear el script que será ejecutado por cron ---
VULN_SCRIPT="$VULN_DIR/daily_report.sh"
echo "[2/4] Creando el script 'daily_report.sh' que root ejecutará:"
sudo tee "$VULN_SCRIPT" > /dev/null <<EOF
#!/bin/bash
echo "[CRON_ROOT]: Reporte diario ejecutado por root en \$(date)" >> /var/log/daily_report.log
/bin/echo "[CRON_ROOT]: Simulando tarea de reporte..."
EOF
sudo chmod +x "$VULN_SCRIPT"
echo "    Script 'daily_report.sh' creado y con permisos de ejecución."

# --- Paso 3: Añadir la tarea cron para root ---
echo "[3/4] Añadiendo la tarea cron para que root ejecute el script cada minuto..."
(sudo crontab -l 2>/dev/null; echo "* * * * * $VULN_SCRIPT") | sudo crontab -
if [ $? -ne 0 ]; then
    echo "ERROR: Falló la adición de la tarea cron."
    exit 1
fi
echo "    Tarea cron añadida. Se ejecutará cada minuto."

# --- Paso 4: Verificar la tarea cron ---
echo "[4/4] Verificando la tarea cron de root (deberías ver la línea del script):"
sudo crontab -l | grep "$VULN_SCRIPT"
if [ $? -eq 0 ]; then
    echo "    ¡Tarea cron configurada exitosamente!"
else
    echo "ERROR: La tarea cron no se agregó correctamente. Revisa los pasos."
    exit 1
fi

echo "--- Configuración del laboratorio Cron vulnerable completada. ---"
echo "Ahora, ejecuta './01_exploit.sh' como tu usuario normal para intentar la escalada."