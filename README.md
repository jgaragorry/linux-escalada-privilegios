markdown
# 🛡️ Laboratorios de Escalada de Privilegios en Linux

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Tux.svg/1200px-Tux.svg.png" alt="Logo de Linux" width="120"/>
</p>

Este repositorio contiene laboratorios prácticos para aprender y practicar técnicas de escalada de privilegios en sistemas Linux. Ideal para estudiantes de ciberseguridad, pentesters y entusiastas del hardening.

---

## 📁 Estructura del Repositorio

```bash
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
📚 Tabla de Contenidos
🔧 Prerrequisitos

🧪 Laboratorio 1: Binario SUID con PATH inseguro

⏰ Laboratorio 2: Tarea Cron insegura

🤝 Contribuciones

📄 Licencia

1. 🔧 Prerrequisitos
🖥️ Entorno Recomendado
Ubuntu Server 24.04 LTS

Usuario no-root (ej. estudiante)

Opcional: openssh-server para facilitar el acceso remoto

🛠️ Instalación rápida en WSL
bash
sudo apt update
sudo apt install -y openssh-server
sudo ufw allow ssh
sudo ufw enable
📥 Clonar el Repositorio
bash
git clone https://github.com/jgaragorry/linux-escalada-privilegios.git
cd linux-escalada-privilegios
2. 🧪 Laboratorio 1: Binario SUID con PATH inseguro
🐞 Descripción
Explota un binario con permisos SUID que invoca comandos sin rutas absolutas, permitiendo manipular el PATH.

📂 Archivos
00_setup_lab.sh: Configura el entorno vulnerable

01_exploit.sh: Ejecuta el exploit

02_verify_exploit.sh: Verifica la escalada

03_revert_fix.sh: Limpia y aplica mitigaciones

🚀 Ejecución
bash
cd lab1_suid_path
bash 00_setup_lab.sh
bash 01_exploit.sh
bash 02_verify_exploit.sh
bash 03_revert_fix.sh
🛡️ Mitigación
Usar rutas absolutas

Evitar SUID innecesario

Auditar binarios con permisos especiales

3. ⏰ Laboratorio 2: Tarea Cron insegura
🐞 Descripción
Demuestra cómo una tarea cron mal configurada puede ser explotada para ejecutar código malicioso con privilegios elevados.

📂 Archivos
00_setup_lab.sh: Crea la tarea vulnerable

01_exploit.sh: Inyecta el payload

02_verify_exploit.sh: Verifica la escalada

03_revert_fix.sh: Elimina la tarea y aplica mitigaciones

🚀 Ejecución
bash
cd lab2_insecure_cron
bash 00_setup_lab.sh
bash 01_exploit.sh
bash 02_verify_exploit.sh
bash 03_revert_fix.sh
🛡️ Mitigación
Evitar cron jobs que ejecuten archivos en ubicaciones modificables

Usar rutas seguras y permisos restrictivos

Auditar tareas programadas regularmente

4. 🤝 Contribuciones
¿Tienes ideas para nuevos laboratorios o mejoras? ¡Abre un issue o envía un pull request!

5. 📄 Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.


¿Quieres que te ayude a crear una versión en inglés, agregar una sección de preguntas frecuentes o generar una guía PDF para distribución académica? También puedo ayudarte a automatizar la ejecución de los laboratorios con un script maestro.
la ideas es qeu yo puedoca copiarlo desd eel canva pero no creoq eue steen forato markdown
¡Perfecto, Jose! Si lo que necesitas es poder copiar el contenido directamente desde aquí y pegarlo en tu archivo README.md dentro de GitHub o tu editor de texto, entonces aquí te lo presento en formato Markdown puro, sin ningún formato visual externo como Canva, y listo para que lo copies y lo pegues tal cual.

✅ Versión Markdown lista para copiar
markdown
# 🛡️ Laboratorios de Escalada de Privilegios en Linux

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Tux.svg/1200px-Tux.svg.png" alt="Logo de Linux" width="120"/>
</p>

Este repositorio contiene laboratorios prácticos para aprender y practicar técnicas de escalada de privilegios en sistemas Linux. Ideal para estudiantes de ciberseguridad, pentesters y entusiastas del hardening.

---

## 📁 Estructura del Repositorio

```bash
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
📚 Tabla de Contenidos
🔧 Prerrequisitos

🧪 Laboratorio 1: Binario SUID con PATH inseguro

⏰ Laboratorio 2: Tarea Cron insegura

🤝 Contribuciones

📄 Licencia

1. 🔧 Prerrequisitos
🖥️ Entorno Recomendado
Ubuntu Server 24.04 LTS

Usuario no-root (ej. estudiante)

Opcional: openssh-server para facilitar el acceso remoto

🛠️ Instalación rápida en WSL
bash
sudo apt update
sudo apt install -y openssh-server
sudo ufw allow ssh
sudo ufw enable
📥 Clonar el Repositorio
bash
git clone https://github.com/jgaragorry/linux-escalada-privilegios.git
cd linux-escalada-privilegios
2. 🧪 Laboratorio 1: Binario SUID con PATH inseguro
🐞 Descripción
Explota un binario con permisos SUID que invoca comandos sin rutas absolutas, permitiendo manipular el PATH.

📂 Archivos
00_setup_lab.sh: Configura el entorno vulnerable

01_exploit.sh: Ejecuta el exploit

02_verify_exploit.sh: Verifica la escalada

03_revert_fix.sh: Limpia y aplica mitigaciones

🚀 Ejecución
bash
cd lab1_suid_path
bash 00_setup_lab.sh
bash 01_exploit.sh
bash 02_verify_exploit.sh
bash 03_revert_fix.sh
🛡️ Mitigación
Usar rutas absolutas

Evitar SUID innecesario

Auditar binarios con permisos especiales

3. ⏰ Laboratorio 2: Tarea Cron insegura
🐞 Descripción
Demuestra cómo una tarea cron mal configurada puede ser explotada para ejecutar código malicioso con privilegios elevados.

📂 Archivos
00_setup_lab.sh: Crea la tarea vulnerable

01_exploit.sh: Inyecta el payload

02_verify_exploit.sh: Verifica la escalada

03_revert_fix.sh: Elimina la tarea y aplica mitigaciones

🚀 Ejecución
bash
cd lab2_insecure_cron
bash 00_setup_lab.sh
bash 01_exploit.sh
bash 02_verify_exploit.sh
bash 03_revert_fix.sh
🛡️ Mitigación
Evitar cron jobs que ejecuten archivos en ubicaciones modificables

Usar rutas seguras y permisos restrictivos

Auditar tareas programadas regularmente

4. 🤝 Contribuciones
¿Tienes ideas para nuevos laboratorios o mejoras? ¡Abre un issue o envía un pull request!

5. 📄 Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.


Este texto está en formato Markdown puro, compatible con GitHub. Puedes copiarlo directamente desde aquí y pegarlo en tu archivo `README.md` sin preocuparte por estilos externos. ¿Quieres que te ayude a crear una versión en inglés o agregar una sección de preguntas frecuentes (FAQ)?
