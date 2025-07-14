Repositorio Final para GitHub
A continuación, te presento el README.md principal y luego el contenido de cada script, ya listo para copiar y pegar en los archivos correspondientes dentro de tu estructura de carpetas.

1. Estructura de Carpetas y Archivos
Para organizar tu repositorio, sigue esta estructura:

linux-escalada-privilegios/
├── .gitignore
├── LICENSE
├── README.md
├── lab1_suid_path/
│   ├── 00_setup_lab.sh
│   ├── 01_exploit.sh
│   ├── 02_verify_exploit.sh
│   └── 03_revert_fix.sh
└── lab2_insecure_cron/
    ├── 00_setup_lab.sh
    ├── 01_exploit.sh
    ├── 02_verify_exploit.sh
    └── 03_revert_fix.sh

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
