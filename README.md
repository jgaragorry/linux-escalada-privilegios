# Laboratorios de Escalada de Privilegios en Linux

![Linux Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Tux.svg/1200px-Tux.svg.png)

Colección práctica de laboratorios para enseñar técnicas fundamentales de escalada de privilegios local en Linux. Perfecto para estudiantes de ciberseguridad, pentesters y profesionales que buscan profundizar en seguridad y hardening de Linux.

## Características Principales

✅ Escenarios realistas de vulnerabilidades comunes  
✅ Configuración automatizada con scripts  
✅ Explicaciones detalladas de cada vulnerabilidad  
✅ Guías paso a paso para explotación y hardening  
✅ Verificación automática de resultados  
✅ Limpieza segura del entorno  

## Tabla de Contenidos

1. [Prerrequisitos](#prerrequisitos)
2. [Laboratorio 1: Explotación de Binario SUID](#laboratorio-1-explotación-de-binario-suid)
   - [Descripción](#descripción)
   - [Ejecución](#ejecución)
   - [Hardening](#hardening)
3. [Laboratorio 2: Explotación de Tarea Cron](#laboratorio-2-explotación-de-tarea-cron)
   - [Descripción](#descripción-1)
   - [Ejecución](#ejecución-1)
   - [Hardening](#hardening-1)
4. [Estructura del Repositorio](#estructura-del-repositorio)

---

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
