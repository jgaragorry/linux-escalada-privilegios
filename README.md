# 🛡️ Laboratorios de Escalada de Privilegios en Linux

![Logo de Linux](https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Tux.svg/1200px-Tux.svg.png)

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
