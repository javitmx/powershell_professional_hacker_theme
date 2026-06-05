# powershell_professional_hacker_theme
<div align="center">

# 🟢 HACKER TERMINAL 2026

### *Transforma tu PowerShell en una terminal hacker profesional con un solo click*

![PowerShell](https://img.shields.io/badge/PowerShell-7.0%2B-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-00FF41?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0-9D00FF?style=for-the-badge)

![Banner](https://via.placeholder.com/800x200/000000/00FF41?text=HACKER+TERMINAL+2026)

[Instalación](#-instalación) •
[Características](#-características) •
[Comandos](#-comandos-personalizados) •
[Troubleshooting](#-troubleshooting) •
[Arquitectura](#-arquitectura)

</div>

---

## 📖 Tabla de Contenidos

- [✨ Descripción](#-descripción)
- [🎯 Características](#-características)
- [📋 Requisitos](#-requisitos)
- [🚀 Instalación](#-instalación)
- [🎨 Personalización](#-personalización)
- [⌨️ Comandos Personalizados](#-comandos-personalizados)
- [🛠️ Atajos de Teclado](#-atajos-de-teclado)
- [📁 Estructura del Proyecto](#-estructura-del-proyecto)
- [🏗️ Arquitectura](#-arquitectura)
- [🐛 Troubleshooting](#-troubleshooting)
- [🤝 Contribuir](#-contribuir)
- [📄 Licencia](#-licencia)

---

## ✨ Descripción

**Hacker Terminal 2026** es un script automatizado de PowerShell que transforma tu terminal en una experiencia profesional estilo hacker con:

- 🟢 Tema verde matrix con acentos morados
- 🎨 Powerline prompt con iconos Nerd Fonts
- ⚡ Autocompletado predictivo inteligente
- 🌿 Integración con Git
- 📊 Información del sistema en tiempo real
- 🌧️ Animación Matrix incluida
- 🚀 Comandos útiles preconfigurados

---

## 🎯 Características

### 🎨 Visuales
| Característica | Descripción |
|---|---|
| **Powerline Prompt** | Prompt de 2 líneas con segmentos coloridos |
| **Nerd Fonts** | CaskaydiaCove con iconos vectoriales |
| **Tema Hacker Green** | Paleta verde matrix + morado |
| **Colores PSReadLine** | Sintaxis coloreada en tiempo real |
| **Fondo negro puro** | Sin transparencia, máxima legibilidad |

### ⚙️ Funcionalidades
| Característica | Descripción |
|---|---|
| **Predicción de comandos** | Sugerencias basadas en historial |
| **Git status integrado** | Branch, cambios, ahead/behind |
| **Tiempo de ejecución** | Si el comando tarda >500ms |
| **Indicador de batería** | Con cambios de color según nivel |
| **Monitor RAM** | Porcentaje de uso en prompt derecho |

### 🛠️ Comandos
| Característica | Descripción |
|---|---|
| **Alias estilo Linux** | `ll`, `grep`, `touch`, `which` |
| **Git shortcuts** | `gs`, `ga`, `gc`, `gp`, `gl` |
| **Funciones útiles** | `matrix`, `sysinfo`, `weather`, `myip` |
| **Navegación rápida** | `..`, `...`, `mkcd` |

---

## 📋 Requisitos

### Mínimos
- **Sistema Operativo**: Windows 10 (build 19041+) o Windows 11
- **PowerShell**: 5.1 o superior (recomendado 7.0+)
- **Windows Terminal**: 1.15 o superior
- **Permisos**: Administrador (para instalar fuentes)
- **Internet**: Para descargar dependencias

### Espacio en disco
- **Oh My Posh**: ~15 MB
- **Nerd Fonts**: ~50 MB
- **Módulos PowerShell**: ~10 MB
- **Total**: ~75 MB

---

## 🚀 Instalación

### Método 1: Instalación Automática (Recomendado)

```powershell
# 1. Clona o descarga el repositorio
git clone https://github.com/tu-usuario/hacker-terminal-2026.git
cd hacker-terminal-2026

# 2. Permite la ejecución del script (solo esta sesión)
Set-ExecutionPolicy Bypass -Scope Process -Force

# 3. Ejecuta como Administrador
.\Install-HackerTerminal.ps1

