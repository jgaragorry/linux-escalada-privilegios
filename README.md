markdown
# 🛡️ Laboratorios de Escalada de Privilegios en Linux

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Tux.svg/1200px-Tux.svg.png" alt="Logo de Linux" width="120"/>
</p>

Una colección práctica de laboratorios diseñada para enseñar técnicas fundamentales de escalada de privilegios local en Linux. Estos ejercicios están pensados para estudiantes de ciberseguridad, aspirantes a pentesters y entusiastas de la seguridad que buscan fortalecer sus habilidades en entornos reales.

---

## 📦 ¿Qué Incluye Este Repositorio?

Cada laboratorio contiene:

- ✅ Una **descripción clara** de la vulnerabilidad.
- 🧰 **Prerrequisitos** para configurar tu entorno de laboratorio.
- ⚙️ **Scripts de configuración automática** para crear el escenario vulnerable.
- 💣 **Scripts de explotación** para demostrar cómo funciona el ataque.
- 🔍 **Scripts de verificación** para confirmar el éxito de la escalada de privilegios.
- 🧹 **Scripts de reversión y hardening** para limpiar el laboratorio y aprender estrategias de mitigación.

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
🔧 Prerrequisitos y Configuración del Laboratorio

🧪 Laboratorio 1: Binario SUID con Inyección de PATH

⏰ Laboratorio 2: Tarea Cron Insegura

🤝 Contribuciones

📄 Licencia

🙌 Créditos

1. 🔧 Prerrequisitos y Configuración del Laboratorio
Para ejecutar estos laboratorios con éxito, necesitarás un entorno Linux aislado.

🖥️ Entorno Recomendado: Ubuntu Server 24.04 LTS
Opción 1: WSL (Windows Subsystem for Linux)
Abre la Microsoft Store y busca Ubuntu 24.04 LTS.

Instálalo y crea un usuario no-root (ej. estudiante).

Opción 2: Máquina Virtual
Descarga la ISO de Ubuntu Server 24.04 LTS.

Crea una VM con al menos 2GB RAM y 20GB de disco.

Instala Ubuntu y crea un usuario no-root (estudiante).

(Opcional) Instala openssh-server para facilitar el acceso remoto:

bash
sudo apt update
sudo apt install -y openssh-server
sudo ufw allow ssh
sudo ufw enable
📥 Clonar el Repositorio
bash
git clone https://github.com/tu-nombre-de-usuario/linux-escalada-privilegios.git
cd linux-escalada-privilegios
🔁 Reemplaza tu-nombre-de-usuario con tu nombre real de GitHub.

2. 🧪 Laboratorio 1: Binario SUID con Inyección de PATH
🐞 Descripción de la Vulnerabilidad
Este laboratorio explora cómo un binario con permisos SUID puede ser explotado si invoca comandos sin rutas absolutas, permitiendo al atacante manipular el PATH.

📂 Archivos del Laboratorio
00_setup_lab.sh: Configura el entorno vulnerable.

01_exploit.sh: Realiza la explotación.

02_verify_exploit.sh: Verifica si se obtuvo privilegios elevados.

03_revert_fix.sh: Limpia y aplica mitigaciones.

🚀 Ejecución Paso a Paso
bash
cd lab1_suid_path
bash 00_setup_lab.sh
bash 01_exploit.sh
bash 02_verify_exploit.sh
bash 03_revert_fix.sh
🛡️ Hardening
Usar rutas absolutas en scripts.

Evitar el uso de SUID innecesario.

Auditar binarios con permisos especiales.

3. ⏰ Laboratorio 2: Tarea Cron Insegura
🐞 Descripción de la Vulnerabilidad
Este laboratorio demuestra cómo una tarea cron mal configurada puede ser manipulada para ejecutar código malicioso con privilegios elevados.

📂 Archivos del Laboratorio
00_setup_lab.sh: Crea la tarea cron vulnerable.

01_exploit.sh: Inyecta el payload.

02_verify_exploit.sh: Verifica la escalada.

03_revert_fix.sh: Elimina la tarea y aplica mitigaciones.

🚀 Ejecución Paso a Paso
bash
cd lab2_insecure_cron
bash 00_setup_lab.sh
bash 01_exploit.sh
bash 02_verify_exploit.sh
bash 03_revert_fix.sh
🛡️ Hardening
Evitar tareas cron que ejecuten archivos en ubicaciones modificables por usuarios.

Usar rutas seguras y permisos restrictivos.

Auditar tareas programadas regularmente.

4. 🤝 Contribuciones
¡Las contribuciones son bienvenidas! Si tienes ideas para nuevos laboratorios o mejoras, abre un issue o envía un pull request.

5. 📄 Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.

6. 🙌 Créditos
Desarrollado con pasión por la seguridad en Linux. Inspirado por prácticas reales de pentesting y hardening.
