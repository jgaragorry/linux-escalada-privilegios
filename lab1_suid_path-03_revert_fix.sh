
#!/bin/bash
# 03_revert_fix.sh - Script para revertir la explotación y aplicar hardening
# Este script DEBE ejecutarse con sudo.

echo "--- Iniciando reversión y aplicación de hardening para SUID+PATH ---"

# --- Paso 1: Eliminar el binario SUID vulnerable y su directorio ---
VULN_DIR="/opt/vulnerable_app_suid"
VULN_BIN="$VULN_DIR/vulnerable_program"
echo "[1/4] Eliminando el directorio y el programa vulnerable: $VULN_DIR"
sudo rm -rf "$VULN_DIR"
if [ $? -eq 0 ]; then
    echo "    Directorio vulnerable eliminado."
else
    echo "ADVERTENCIA: No se pudo eliminar el directorio vulnerable. Puede que no exista o haya problemas de permisos."
fi

# --- Paso 2: Limpiar el PATH del usuario (si fue modificado manualmente) ---
# Esto es más relevante si el usuario lo añadió al .bashrc, pero limpiamos el actual.
echo "[2/4] Restaurando la variable PATH del entorno actual..."
# Elimina el directorio malicioso del PATH si todavía está ahí
export PATH=$(echo $PATH | sed 's#/tmp/pwned_path_suid:##')
echo "    PATH restaurado a su valor pre-ataque (temporalmente en esta sesión)."
MALICIOUS_DIR="/tmp/pwned_path_suid"
if [ -d "$MALICIOUS_DIR" ]; then
    sudo rm -rf "$MALICIOUS_DIR"
    echo "    Directorio del 'ls' malicioso eliminado."
else
    echo "    El directorio malicioso '$MALICIOUS_DIR' no existe o ya fue eliminado."
fi


# --- Paso 3: Aplicar medidas de hardening (conceptos) ---
echo "[3/4] Aplicando conceptos de hardening (simulados):"
echo "    - **Principio del Menor Privilegio:** Reevaluar la necesidad del SUID. Si un programa no lo necesita, no lo tenga."
echo "    - **Rutas Absolutas:** Cualquier programa SUID debe usar SIEMPRE rutas absolutas para comandos externos (ej. /bin/ls)."
echo "    - **Limpieza de Entorno:** Los programas SUID deben limpiar variables de entorno (PATH, LD_PRELOAD) para evitar inyección."
echo "    - **Auditoría SUID:** Realizar 'sudo find / -type f -perm /4000 2>/dev/null' regularmente."
echo "    - **No SUID en Binarios Genéricos:** NUNCA aplicar SUID a comandos como 'ls', 'cat', 'cp', etc."
echo "    Conclusión: El programa vulnerable ha sido eliminado y las lecciones aprendidas."

# --- Paso 4: Notificación final ---
echo "[4/4] Verificando que el programa vulnerable ya no existe:"
ls -la "$VULN_BIN" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "    El programa SUID vulnerable ha sido removido exitosamente."
    echo ""
    echo "████████████████████████████████████████████████"
    echo "█  ¡RESTABLECIMIENTO EXITOSO! El sistema está  █"
    echo "█     de nuevo en un estado seguro (para este lab). █"
    echo "████████████████████████████████████████████████"
    echo ""
    echo "El laboratorio para la vulnerabilidad SUID+PATH ha sido limpiado y revertido."
else
    echo "ERROR: El programa SUID vulnerable todavía existe. Revisa el script."
fi

echo "--- Reversión y hardening completados. ---"
