markdown
# Laboratorios de Escalada de Privilegios en Linux

![Linux Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Tux.svg/1200px-Tux.svg.png)

Colección práctica de laboratorios para enseñar técnicas fundamentales de escalada de privilegios local en Linux. Perfecto para estudiantes de ciberseguridad, pentesters y profesionales que buscan profundizar en seguridad y hardening de Linux.

## Tabla de Contenidos
1. [Características Principales](#características-principales)
2. [Prerrequisitos](#prerrequisitos)
3. [Laboratorios](#laboratorios)
   - [Laboratorio 1: Explotación de Binario SUID](#laboratorio-1-explotación-de-binario-suid)
   - [Laboratorio 2: Explotación de Tarea Cron](#laboratorio-2-explotación-de-tarea-cron)
4. [Estructura del Repositorio](#estructura-del-repositorio)
5. [Licencia](#licencia)

## Características Principales
✅ Escenarios realistas de vulnerabilidades comunes  
✅ Configuración automatizada con scripts  
✅ Explicaciones detalladas de cada vulnerabilidad  
✅ Guías paso a paso para explotación y hardening  
✅ Verificación automática de resultados  
✅ Limpieza segura del entorno  

## Prerrequisitos
### Entorno Recomendado
- **Ubuntu Server 24.04 LTS** (WSL o máquina virtual)
- Usuario no-root (ej. `estudiante`)
- 2GB RAM mínimo
- 20GB espacio en disco

### Configuración Inicial
```bash
# Instalar dependencias básicas
sudo apt update && sudo apt install -y build-essential openssh-server

# Clonar repositorio (reemplazar con tu URL)
git clone https://github.com/tu-usuario/linux-escalada-privilegios.git
cd linux-escalada-privilegios
Laboratorios
Laboratorio 1: Explotación de Binario SUID
Descripción
Vulnerabilidad: Binario SUID mal configurado que llama a comandos externos sin rutas absolutas, permitiendo inyección de PATH.

Impacto: Escalada a privilegios root mediante manipulación de variables de entorno.

Ejecución
bash
cd lab1_suid_path

# Configurar entorno vulnerable
sudo ./00_setup_lab.sh

# Ejecutar explotación
./01_exploit.sh

# Verificar éxito (desde shell root obtenida)
./02_verify_exploit.sh

# Revertir cambios
sudo ./03_revert_fix.sh
Hardening
Usar rutas absolutas en programas SUID

Limpiar variables de entorno críticas (PATH, LD_PRELOAD)

Auditoría regular: sudo find / -type f -perm /4000 2>/dev/null

Principio de menor privilegio

Laboratorio 2: Explotación de Tarea Cron
Descripción
Vulnerabilidad: Tarea cron de root que ejecuta scripts con permisos de escritura globales.

Impacto: Modificación de scripts para ejecución de código como root.

Ejecución
bash
cd lab2_insecure_cron

# Configurar entorno vulnerable
sudo ./00_setup_lab.sh

# Ejecutar explotación
./01_exploit.sh
# Esperar 60 segundos para ejecución de cron

# Verificar éxito
./02_verify_exploit.sh

# Revertir cambios
sudo ./03_revert_fix.sh
Hardening
Permisos estrictos (755 máximo) en directorios/scripts de cron

Propiedad root en scripts críticos

Monitoreo de crontabs: sudo crontab -l y /etc/crontab

Logging de ejecuciones cron

Estructura del Repositorio
text
linux-escalada-privilegios/
├── .gitignore
├── LICENSE
├── README.md
├── lab1_suid_path/
│   ├── 00_setup_lab.sh    # Configura entorno vulnerable
│   ├── 01_exploit.sh      # Demuestra la explotación
│   ├── 02_verify_exploit.sh # Verifica escalada exitosa
│   └── 03_revert_fix.sh   # Revierte y aplica hardening
└── lab2_insecure_cron/
    ├── 00_setup_lab.sh
    ├── 01_exploit.sh
    ├── 02_verify_exploit.sh
    └── 03_revert_fix.sh
Licencia
MIT License - Ver LICENSE para detalles.

Nota de Seguridad: Estos laboratorios deben ejecutarse solo en entornos controlados y con permiso explícito. No utilizar en sistemas de producción o sin autorización.

Mejoras Implementadas:
Organización jerárquica: Estructura clara con tabla de contenidos

Consistencia visual: Formato uniforme para todos los laboratorios

Sintaxis Markdown mejorada:

Bloques de código con resaltado de lenguaje

Listas ordenadas y no ordenadas

Énfasis con negritas para términos clave

Navegación interna: Enlaces entre secciones

Responsive: Legible tanto en GitHub como en editores Markdown

Información técnica destacada: Comandos claramente diferenciados

Advertencias de seguridad: Visible y destacada

text
