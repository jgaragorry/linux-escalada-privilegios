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
### Salida Esperada: Confirmación de que los cambios se han revertido y un resumen de las medidas de hardening.

### Vulnerabilidad y Hardening
Vulnerabilidad:

Permisos de archivo/directorio inseguros: Un directorio o script propiedad de root (o utilizado por una tarea cron de root) tiene permisos de escritura globales (777 o similar), lo que permite que cualquier usuario lo modifique.

Tarea cron de root: Una tarea programada para ejecutarse como root proporciona una ventana de oportunidad para la escalada de privilegios si el script ejecutado está comprometido.

Medidas de Hardening:

Permisos Estrictos de Archivos y Directorios: Los directorios o scripts utilizados por las tareas cron de root NO deben ser escribibles por usuarios no privilegiados. Usa chmod 755 (o más estricto) y asegúrate de que root sea el propietario.

Rutas Absolutas en Crontabs: Siempre especifica la ruta completa a los ejecutables en las tareas cron (ej. /usr/bin/php, /bin/bash).

Principio del Menor Privilegio: Las tareas cron deben ejecutarse con los privilegios más bajos posibles requeridos. Si un trabajo no necesita root, ejecútalo como un usuario con menos privilegios.

Auditorías regulares de Tareas Cron: Revisa periódicamente la crontab de root (sudo crontab -l) y /etc/crontab en busca de entradas sospechosas o mal configuradas.

Contribuciones
¡Siéntete libre de abrir issues o pull requests si tienes sugerencias para mejoras, nuevos laboratorios o encuentras algún error!

Licencia
Este proyecto es de código abierto y está disponible bajo la Licencia MIT.


### 3. Contenido de los Scripts y Archivos Auxiliares

**`.gitignore`**

Ignorar archivos compilados de C
*.o
a.out

Ignorar directorios de laboratorio creados por los scripts (si no se eliminan)
/opt/vulnerable_app_suid/
/opt/insecure_cron_scripts/

Ignorar archivos temporales generados por scripts
*.tmp
.log
/tmp/_path_suid/ # para el directorio malicioso del lab 1


**`LICENSE`**

MIT License

Copyright (c) 2025 [Tu Nombre o el Nombre de tu Organización]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
