
# Hacker Terminal 2026

Transforma tu PowerShell en una terminal hacker profesional con un solo click

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

```
### Metodo 2: Click Derecho 
1. Descarga Install-HackerTerminal.ps1
2. Click derecho → **"Ejecutar con PowerShell"**
3. Acepta los permisos de Administrador
4. Espera 2-3 minutos
5. Cierra y abre Windows Terminal

### Metodo 3: Una sola linea (desde Github)
```
iex (irm "https://raw.githubusercontent.com/tu-usuario/hacker-terminal-2026/main/Install-HackerTerminal.ps1")
```
