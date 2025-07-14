markdown
# 🧪 Linux Escalada de Privilegios - Laboratorios Prácticos

Este repositorio contiene dos laboratorios prácticos diseñados para demostrar técnicas comunes de escalada de privilegios en sistemas Linux. Cada laboratorio incluye scripts automatizados para configurar, explotar, verificar y revertir el entorno vulnerable.

---

## 📌 Requisitos Previos

Antes de ejecutar los laboratorios, asegúrate de tener lo siguiente:

- ✅ Ubuntu Server 24.04 LTS (WSL o VM)
- ✅ Usuario no-root (ej. `estudiante`)
- ✅ Git instalado
- ✅ Permisos para ejecutar scripts Bash

Opcionalmente, puedes instalar `openssh-server` para facilitar el acceso remoto:

```bash
sudo apt update
sudo apt install -y openssh-server
sudo ufw allow ssh
sudo ufw enable
📁 Estructura del Repositorio
bash
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
🧪 Laboratorio 1: Binario SUID con PATH Inseguro
Descripción
Este laboratorio simula un binario con permisos SUID que invoca comandos sin rutas absolutas. Esto permite al atacante manipular el PATH para ejecutar código arbitrario con privilegios elevados.

Archivos
00_setup_lab.sh: Crea el binario vulnerable.

01_exploit.sh: Ejecuta el exploit.

02_verify_exploit.sh: Verifica si se obtuvo root.

03_revert_fix.sh: Elimina el binario y aplica mitigaciones.

Ejecución
bash
cd lab1_suid_path
bash 00_setup_lab.sh
bash 01_exploit.sh
bash 02_verify_exploit.sh
bash 03_revert_fix.sh
⏰ Laboratorio 2: Tarea Cron Insegura
Descripción
Este laboratorio simula una tarea cron mal configurada que ejecuta scripts desde ubicaciones modificables por el usuario. El atacante puede inyectar código malicioso para obtener privilegios elevados.

Archivos
00_setup_lab.sh: Crea la tarea cron vulnerable.

01_exploit.sh: Inyecta el payload.

02_verify_exploit.sh: Verifica si se obtuvo root.

03_revert_fix.sh: Elimina la tarea y aplica mitigaciones.

Ejecución
bash
cd lab2_insecure_cron
bash 00_setup_lab.sh
bash 01_exploit.sh
bash 02_verify_exploit.sh
bash 03_revert_fix.sh
🛡️ Buenas Prácticas de Hardening
Usar rutas absolutas en scripts con privilegios.

Evitar tareas cron que ejecuten archivos en ubicaciones inseguras.

Auditar binarios con permisos especiales (SUID, SGID).

Aplicar controles de acceso estrictos y monitoreo.

📄 Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.

🤝 Contribuciones
¿Tienes ideas para nuevos laboratorios o mejoras? ¡Abre un issue o envía un pull request!

📥 Clonar el Repositorio
bash
git clone https://github.com/jgaragorry/linux-escalada-privilegios.git
cd linux-escalada-privilegios

¿Quieres que también te prepare el contenido para el archivo `LICENSE`, o que te ayude a crear una sección de evaluación para estudiantes?
