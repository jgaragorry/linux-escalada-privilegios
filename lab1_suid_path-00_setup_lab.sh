#!/bin/bash
# 00_setup_lab.sh - Script para configurar el entorno SUID vulnerable
# Este script DEBE ejecutarse con sudo.

echo "--- Iniciando configuración del laboratorio SUID vulnerable ---"

# --- Paso 1: Instalar dependencias si es necesario ---
echo "[1/5] Actualizando el sistema e instalando build-essential (para gcc)..."
sudo apt update -y > /dev/null 2>&1
sudo apt install -y build-essential > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "ERROR: Falló la instalación de build-essential. ¿Estás conectado a internet?"
    exit 1
fi
echo "    Dependencias instaladas."

# --- Paso 2: Crear el directorio vulnerable ---
VULN_DIR="/opt/vulnerable_app_suid"
echo "[2/5] Creando el directorio vulnerable: $VULN_DIR"
sudo mkdir -p "$VULN_DIR"
sudo chown root:root "$VULN_DIR"
sudo chmod 755 "$VULN_DIR" # Permisos estándar para el directorio
echo "    Directorio creado y con permisos correctos."

# --- Paso 3: Crear el código fuente del programa SUID vulnerable ---
VULN_C_FILE="$VULN_DIR/vulnerable_program.c"
echo "[3/5] Creando el código fuente del programa vulnerable en $VULN_C_FILE"
sudo tee "$VULN_C_FILE" > /dev/null <<EOF
#include <stdio.h>
#include <stdlib.h> // Para system()
#include <unistd.h> // Para getuid()

int main() {
    printf("[PROGRAMA VULNERABLE]: ¡Hola desde el programa SUID!\n");
    printf("[PROGRAMA VULNERABLE]: Mi UID efectivo es: %d\n", geteuid());
    // La vulnerabilidad: llama a 'ls' sin ruta absoluta.
    // Esto permite que el atacante inyecte su propio 'ls'.
    printf("[PROGRAMA VULNERABLE]: Intentando ejecutar 'ls -la /root'...\n");
    system("ls -la /root"); 
    printf("[PROGRAMA VULNERABLE]: Ejecución de 'ls' terminada.\n");
    return 0;
}
EOF
echo "    Código fuente creado."

# --- Paso 4: Compilar el programa ---
VULN_BIN="$VULN_DIR/vulnerable_program"
echo "[4/5] Compilando el programa vulnerable en $VULN_BIN"
sudo gcc "$VULN_C_FILE" -o "$VULN_BIN"
if [ $? -ne 0 ]; then
    echo "ERROR: Falló la compilación del programa. Revisa el código fuente."
    exit 1
fi
echo "    Programa compilado exitosamente."

# --- Paso 5: Establecer la propiedad de root y el bit SUID ---
echo "[5/5] Estableciendo propietario root y el bit SUID para $VULN_BIN"
sudo chown root:root "$VULN_BIN"
sudo chmod 4755 "$VULN_BIN" # u=rws (usuario leer, escribir, setuid), go=rx (grupo/otros leer, ejecutar)
echo "    Permisos establecidos. Verificando..."
ls -la "$VULN_BIN" | grep "rws"
if [ $? -eq 0 ]; then
    echo "    ¡Configuración SUID exitosa! La 's' en 'rws' lo confirma."
else
    echo "ERROR: El bit SUID no se estableció correctamente. Revisa los pasos."
    exit 1
fi

echo "--- Configuración del laboratorio SUID vulnerable completada. ---"
echo "Ahora, ejecuta './01_exploit.sh' como tu usuario normal para intentar la escalada."
