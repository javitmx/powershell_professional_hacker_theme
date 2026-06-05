#Requires -RunAsAdministrator

# ╔══════════════════════════════════════════════════════════╗
# ║   🟢 HACKER TERMINAL 2026 - INSTALADOR AUTOMÁTICO 🟢    ║
# ║         Instalación completa con un solo click           ║
# ╚══════════════════════════════════════════════════════════╝

$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'

# ───── BANNER ─────
function Show-Banner {
    Clear-Host
    Write-Host ""
    Write-Host "  ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ " -ForegroundColor Green
    Write-Host "  ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗" -ForegroundColor Green
    Write-Host "  ███████║███████║██║     █████╔╝ █████╗  ██████╔╝" -ForegroundColor Green
    Write-Host "  ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗" -ForegroundColor Green
    Write-Host "  ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║" -ForegroundColor Green
    Write-Host "  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝" -ForegroundColor Green
    Write-Host "          T E R M I N A L   2 0 2 6" -ForegroundColor Magenta
    Write-Host "        Instalador Automatico v1.0" -ForegroundColor DarkGreen
    Write-Host ""
}

function Write-Step {
    param([string]$Number, [string]$Text)
    Write-Host ""
    Write-Host "  [$Number] " -NoNewline -ForegroundColor Magenta
    Write-Host $Text -ForegroundColor Green
    Write-Host "  $('─' * 55)" -ForegroundColor DarkGreen
}

function Write-OK { param([string]$Text) Write-Host "      ✓ " -NoNewline -ForegroundColor Green; Write-Host $Text -ForegroundColor White }
function Write-Err { param([string]$Text) Write-Host "      ✗ " -NoNewline -ForegroundColor Red; Write-Host $Text -ForegroundColor Yellow }
function Write-Info { param([string]$Text) Write-Host "      → " -NoNewline -ForegroundColor Cyan; Write-Host $Text -ForegroundColor Gray }

Show-Banner

# Verificar admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "  ⚠️  Este script requiere permisos de ADMINISTRADOR" -ForegroundColor Red
    Write-Host "  Cierra y ejecuta como Administrador" -ForegroundColor Yellow
    pause
    exit
}

# ═══════════════════════════════════════════════════════════
# PASO 1: INSTALAR OH MY POSH (FUERZA BRUTA)
# ═══════════════════════════════════════════════════════════
Write-Step "1/6" "INSTALANDO OH MY POSH"

$installDir = "$env:LOCALAPPDATA\Programs\oh-my-posh\bin"
$themesDir = "$env:LOCALAPPDATA\Programs\oh-my-posh\themes"
$exePath = "$installDir\oh-my-posh.exe"

# Crear carpetas
New-Item -ItemType Directory -Path $installDir -Force | Out-Null
New-Item -ItemType Directory -Path $themesDir -Force | Out-Null
Write-OK "Carpetas creadas"

# Descargar exe directamente
Write-Info "Descargando oh-my-posh.exe..."
try {
    Invoke-WebRequest -Uri "https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-windows-amd64.exe" -OutFile $exePath -UseBasicParsing
    $size = [math]::Round((Get-Item $exePath).Length / 1MB, 2)
    Write-OK "Descargado: $size MB"
} catch {
    Write-Err "Error: $_"
    pause; exit
}

# Descargar temas
Write-Info "Descargando temas oficiales..."
try {
    $themesZip = "$env:TEMP\omp-themes.zip"
    Invoke-WebRequest -Uri "https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip" -OutFile $themesZip -UseBasicParsing
    Expand-Archive -Path $themesZip -DestinationPath $themesDir -Force
    Remove-Item $themesZip -Force
    Write-OK "Temas instalados"
} catch {
    Write-Err "No se pudieron descargar los temas (no crítico)"
}

# Añadir al PATH
Write-Info "Configurando PATH..."
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$installDir*") {
    $newPath = if ($userPath) { "$userPath;$installDir" } else { $installDir }
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-OK "PATH actualizado permanentemente"
} else {
    Write-OK "PATH ya configurado"
}
$env:Path = "$env:Path;$installDir"
[Environment]::SetEnvironmentVariable("POSH_THEMES_PATH", $themesDir, "User")
$env:POSH_THEMES_PATH = $themesDir

# Verificar
$version = & $exePath --version 2>$null
Write-OK "Oh My Posh v$version instalado correctamente"

# ═══════════════════════════════════════════════════════════
# PASO 2: INSTALAR NERD FONT (CASKAYDIACOVE)
# ═══════════════════════════════════════════════════════════
Write-Step "2/6" "INSTALANDO CASKAYDIACOVE NERD FONT"

$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip"
$fontZip = "$env:TEMP\CascadiaCode.zip"
$fontDir = "$env:TEMP\CascadiaCode_fonts"

if (Test-Path $fontDir) { Remove-Item $fontDir -Recurse -Force }
if (Test-Path $fontZip) { Remove-Item $fontZip -Force }

Write-Info "Descargando fuente (puede tardar 1-2 minutos)..."
try {
    Invoke-WebRequest -Uri $fontUrl -OutFile $fontZip -UseBasicParsing
    $size = [math]::Round((Get-Item $fontZip).Length / 1MB, 2)
    Write-OK "Descargado: $size MB"
} catch {
    Write-Err "Error: $_"
    pause; exit
}

Write-Info "Descomprimiendo..."
Expand-Archive -Path $fontZip -DestinationPath $fontDir -Force
Write-OK "Descomprimido"

Write-Info "Instalando fuentes en el sistema..."
$installed = 0
$skipped = 0
Get-ChildItem -Path $fontDir -Filter "*.ttf" | ForEach-Object {
    $fontDest = "C:\Windows\Fonts\$($_.Name)"
    
    if (-not (Test-Path $fontDest)) {
        try {
            Copy-Item -Path $_.FullName -Destination $fontDest -Force
            $fontName = $_.BaseName
            New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" `
                             -Name "$fontName (TrueType)" `
                             -Value $_.Name `
                             -PropertyType String -Force -ErrorAction SilentlyContinue | Out-Null
            $installed++
        } catch { }
    } else {
        $skipped++
    }
}
Write-OK "$installed fuentes instaladas, $skipped ya existían"

# Limpiar
Remove-Item $fontZip -Force -ErrorAction SilentlyContinue
Remove-Item $fontDir -Recurse -Force -ErrorAction SilentlyContinue

# ═══════════════════════════════════════════════════════════
# PASO 3: INSTALAR MÓDULOS POWERSHELL
# ═══════════════════════════════════════════════════════════
Write-Step "3/6" "INSTALANDO MÓDULOS POWERSHELL"

# Configurar PSGallery como confiable
if ((Get-PSRepository PSGallery).InstallationPolicy -ne 'Trusted') {
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

$modules = @('PSReadLine', 'Terminal-Icons', 'posh-git', 'z')
foreach ($mod in $modules) {
    if (-not (Get-Module -ListAvailable -Name $mod)) {
        Write-Info "Instalando $mod..."
        try {
            Install-Module $mod -Force -SkipPublisherCheck -Scope CurrentUser -AllowClobber -ErrorAction Stop
            Write-OK "$mod instalado"
        } catch {
            Write-Err "$mod falló: $_"
        }
    } else {
        Write-OK "$mod ya instalado"
    }
}

# ═══════════════════════════════════════════════════════════
# PASO 4: CREAR TEMA OH MY POSH HACKER GREEN
# ═══════════════════════════════════════════════════════════
Write-Step "4/6" "CREANDO TEMA HACKER GREEN"

$themePath = "$themesDir\cyberpunk-hacker.omp.json"

$themeJson = @'
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "version": 2,
  "final_space": true,
  "console_title_template": "⚡ {{ .Folder }} | HACKER",
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "newline": true,
      "segments": [
        {
          "type": "text",
          "style": "plain",
          "foreground": "#00FF41",
          "template": "╭─"
        },
        {
          "type": "os",
          "style": "diamond",
          "leading_diamond": "",
          "trailing_diamond": "\ue0b0",
          "foreground": "#000000",
          "background": "#39FF14",
          "template": " {{ if .WSL }}WSL {{ end }}{{.Icon}} "
        },
        {
          "type": "time",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "foreground": "#000000",
          "background": "#00FF41",
          "properties": { "time_format": "15:04:05" },
          "template": "  {{ .CurrentDate | date .Format }} "
        },
        {
          "type": "session",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "foreground": "#000000",
          "background": "#00D12A",
          "template": "  {{ .UserName }} "
        },
        {
          "type": "text",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "foreground": "#000000",
          "background": "#00B321",
          "template": " 󰟀 {{ .HostName }} "
        },
        {
          "type": "path",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "foreground": "#FFFFFF",
          "background": "#3B0066",
          "properties": {
            "style": "agnoster_short",
            "max_depth": 3,
            "folder_icon": "\uf07b",
            "home_icon": "\uf015"
          },
          "template": "  {{ .Path }} "
        },
        {
          "type": "git",
          "style": "powerline",
          "powerline_symbol": "\ue0b0",
          "foreground": "#000000",
          "background": "#00FF41",
          "background_templates": [
            "{{ if or (.Working.Changed) (.Staging.Changed) }}#9D00FF{{ end }}",
            "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#FFFFFF{{ end }}",
            "{{ if gt .Ahead 0 }}#39FF14{{ end }}",
            "{{ if gt .Behind 0 }}#00B321{{ end }}"
          ],
          "properties": {
            "fetch_status": true,
            "fetch_stash_count": true,
            "fetch_upstream_icon": true,
            "branch_icon": "\ue725 "
          },
          "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} \uf046 {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }} \uf692 {{ .StashCount }}{{ end }} "
        }
      ]
    },
    {
      "type": "prompt",
      "alignment": "right",
      "segments": [
        {
          "type": "executiontime",
          "style": "powerline",
          "powerline_symbol": "\ue0b2",
          "invert_powerline": true,
          "foreground": "#000000",
          "background": "#00B321",
          "properties": { "threshold": 500, "style": "austin" },
          "template": " 󱎫 {{ .FormattedMs }} "
        },
        {
          "type": "battery",
          "style": "powerline",
          "powerline_symbol": "\ue0b2",
          "invert_powerline": true,
          "foreground": "#000000",
          "background": "#00FF41",
          "background_templates": [
            "{{ if eq \"Charging\" .State.String }}#39FF14{{ end }}",
            "{{ if eq \"Discharging\" .State.String }}#00FF41{{ end }}",
            "{{ if eq \"Full\" .State.String }}#39FF14{{ end }}",
            "{{ if le .Percentage 30 }}#9D00FF{{ end }}"
          ],
          "properties": {
            "charging_icon": "\uf0e7 ",
            "charged_icon": "\uf240 ",
            "discharging_icon": "\uf242 "
          },
          "template": " {{ if not .Error }}{{ .Icon }}{{ .Percentage }}{{ end }}% "
        },
        {
          "type": "sysinfo",
          "style": "powerline",
          "powerline_symbol": "\ue0b2",
          "invert_powerline": true,
          "foreground": "#000000",
          "background": "#00D12A",
          "template": "  RAM {{ round .PhysicalPercentUsed .Precision }}% "
        }
      ]
    },
    {
      "type": "prompt",
      "alignment": "left",
      "newline": true,
      "segments": [
        {
          "type": "text",
          "style": "plain",
          "foreground": "#00FF41",
          "template": "╰─"
        },
        {
          "type": "status",
          "style": "plain",
          "foreground": "#39FF14",
          "foreground_templates": [
            "{{ if gt .Code 0 }}#9D00FF{{ end }}"
          ],
          "properties": { "always_enabled": true },
          "template": "{{ if gt .Code 0 }} \uf071 {{ .Code }}{{ end }} \ue285 "
        }
      ]
    }
  ],
  "secondary_prompt": {
    "foreground": "#00FF41",
    "background": "transparent",
    "template": "\u279c\u279c "
  },
  "transient_prompt": {
    "foreground": "#00FF41",
    "background": "transparent",
    "template": "\ue285 "
  }
}
'@

Set-Content -Path $themePath -Value $themeJson -Encoding UTF8
Write-OK "Tema creado: $themePath"

# ═══════════════════════════════════════════════════════════
# PASO 5: CREAR PERFIL POWERSHELL
# ═══════════════════════════════════════════════════════════
Write-Step "5/6" "CONFIGURANDO PERFIL POWERSHELL"

# Detectar perfil de PowerShell 7 y 5
$profiles = @(
    "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1",
    "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
)

$profileContent = @'
# ╔══════════════════════════════════════════════════════════╗
# ║       🟢 HACKER GREEN TERMINAL 2026 🟢                   ║
# ╚══════════════════════════════════════════════════════════╝

# Path para Oh My Posh
$env:Path += ";$env:LOCALAPPDATA\Programs\oh-my-posh\bin"
$env:POSH_THEMES_PATH = "$env:LOCALAPPDATA\Programs\oh-my-posh\themes"

# ───── IMPORTAR MÓDULOS ─────
Import-Module PSReadLine -ErrorAction SilentlyContinue

if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Import-Module Terminal-Icons -ErrorAction SilentlyContinue
}

if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git -ErrorAction SilentlyContinue
}

if (Get-Module -ListAvailable -Name z) {
    Import-Module z -ErrorAction SilentlyContinue
}

# ───── OH MY POSH ─────
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    $themePath = "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\cyberpunk-hacker.omp.json"
    if (Test-Path $themePath) {
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
    } else {
        oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression
    }
}

# ───── PSReadLine CONFIG VERDE HACKER ─────
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -HistoryNoDuplicates

Set-PSReadLineOption -Colors @{
    Command            = '#00FF41'
    Parameter          = '#39FF14'
    Operator           = '#9D00FF'
    Variable           = '#00D12A'
    String             = '#7FFF00'
    Number             = '#00FF7F'
    Type               = '#00B321'
    Comment            = '#005F00'
    Keyword            = '#9D00FF'
    Error              = '#9D00FF'
    InlinePrediction   = '#003B00'
    ListPrediction     = '#39FF14'
    Selection          = "`e[48;2;0;59;0m"
}

# ───── ATAJOS DE TECLADO ─────
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteChar
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord

# ═══════════════════════════════════════════════════════════
#                    ALIAS ESTILO LINUX
# ═══════════════════════════════════════════════════════════
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String
Set-Alias -Name touch -Value New-Item
Set-Alias -Name vim -Value notepad
Set-Alias -Name open -Value Invoke-Item

function la { Get-ChildItem -Force }
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }
function which($cmd) { (Get-Command $cmd -ErrorAction SilentlyContinue).Source }
function mkcd($dir) { New-Item -ItemType Directory -Path $dir -Force | Out-Null; Set-Location $dir }
function reload { . $PROFILE; Write-Host "Perfil recargado" -ForegroundColor Green }
function edit-profile { notepad $PROFILE }

# Git shortcuts
function gs { git status }
function ga { git add . }
function gc($msg) { git commit -m $msg }
function gp { git push }
function gl { git log --oneline --graph --decorate --all }
function gco($branch) { git checkout $branch }

# ═══════════════════════════════════════════════════════════
#                    FUNCIONES BRUTALES
# ═══════════════════════════════════════════════════════════

function matrix {
    param([int]$Duration = 10)
    $chars = @('0','1','ﾊ','ﾐ','ﾋ','ｰ','ｳ','ｼ','ﾅ','ﾓ','ﾆ','ｻ','ﾜ','ﾂ','ｵ','ﾘ','ｱ','ﾎ','ﾃ','ﾏ')
    $width = $Host.UI.RawUI.WindowSize.Width
    $height = $Host.UI.RawUI.WindowSize.Height
    $endTime = (Get-Date).AddSeconds($Duration)
    Clear-Host
    [Console]::CursorVisible = $false
    try {
        while ((Get-Date) -lt $endTime) {
            $col = Get-Random -Maximum $width
            $row = Get-Random -Maximum $height
            $char = $chars | Get-Random
            [Console]::SetCursorPosition($col, $row)
            $colors = @('DarkGreen','Green','Green','Green')
            Write-Host $char -NoNewline -ForegroundColor ($colors | Get-Random)
            Start-Sleep -Milliseconds 8
        }
    } finally {
        [Console]::CursorVisible = $true
        Clear-Host
    }
}

function myip {
    try {
        $ip = (Invoke-RestMethod -Uri "https://api.ipify.org?format=json").ip
        $geo = Invoke-RestMethod -Uri "http://ip-api.com/json/$ip"
        Write-Host "`nIP Publica: " -NoNewline -ForegroundColor Green
        Write-Host $ip -ForegroundColor White
        Write-Host "Ubicacion: " -NoNewline -ForegroundColor Green
        Write-Host "$($geo.city), $($geo.country)" -ForegroundColor White
        Write-Host "ISP: " -NoNewline -ForegroundColor Green
        Write-Host $geo.isp -ForegroundColor White
    } catch {
        Write-Host "Sin conexion" -ForegroundColor Magenta
    }
}

function weather($city = "") {
    try {
        $url = if ($city) { "wttr.in/$city" } else { "wttr.in" }
        Invoke-RestMethod -Uri $url
    } catch {
        Write-Host "Error al obtener clima" -ForegroundColor Magenta
    }
}

function sysinfo {
    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor
    $ram = [math]::Round($os.TotalVisibleMemorySize/1MB, 2)
    $ramFree = [math]::Round($os.FreePhysicalMemory/1MB, 2)
    $ramUsed = $ram - $ramFree
    $disk = Get-PSDrive C
    Write-Host ""
    Write-Host "  $env:USERNAME@$env:COMPUTERNAME" -ForegroundColor Green
    Write-Host "  ────────────────────" -ForegroundColor DarkGreen
    Write-Host "  OS:     " -NoNewline -ForegroundColor Green; Write-Host $os.Caption -ForegroundColor White
    Write-Host "  CPU:    " -NoNewline -ForegroundColor Green; Write-Host $cpu.Name -ForegroundColor White
    Write-Host "  RAM:    " -NoNewline -ForegroundColor Green; Write-Host "$ramUsed GB / $ram GB" -ForegroundColor White
    Write-Host "  Disco:  " -NoNewline -ForegroundColor Green; Write-Host "$([math]::Round($disk.Used/1GB,2)) GB / $([math]::Round(($disk.Used+$disk.Free)/1GB,2)) GB" -ForegroundColor White
    Write-Host "  Uptime: " -NoNewline -ForegroundColor Green
    $uptime = (Get-Date) - $os.LastBootUpTime
    Write-Host "$($uptime.Days)d $($uptime.Hours)h $($uptime.Minutes)m" -ForegroundColor White
    Write-Host ""
}

function ff($name) {
    Get-ChildItem -Recurse -Filter "*$name*" -ErrorAction SilentlyContinue | Select-Object FullName, Length, LastWriteTime
}

function top {
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 15 |
        Format-Table -AutoSize Name, Id, @{N='CPU(s)';E={[math]::Round($_.CPU,2)}}, @{N='RAM(MB)';E={[math]::Round($_.WS/1MB,2)}}
}

function genpass($length = 20) {
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*'.ToCharArray()
    -join (1..$length | ForEach-Object { $chars | Get-Random })
}

function clean-temp {
    Write-Host "Limpiando temporales..." -ForegroundColor Green
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Listo" -ForegroundColor Green
}

# ───── BANNER DE BIENVENIDA ─────
function Show-WelcomeBanner {
    $hour = (Get-Date).Hour
    $greeting = if ($hour -lt 12) { "Buenos dias" } elseif ($hour -lt 19) { "Buenas tardes" } else { "Buenas noches" }
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "  ║          HACKER TERMINAL 2026                        ║" -ForegroundColor Green
    Write-Host "  ╚══════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host "  > $greeting, " -NoNewline -ForegroundColor Green
    Write-Host "$env:USERNAME" -ForegroundColor White
    Write-Host "  > $(Get-Date -Format 'dddd, dd MMMM yyyy - HH:mm')" -ForegroundColor DarkGreen
    Write-Host ""
    Write-Host "  [+] Comandos: " -NoNewline -ForegroundColor Magenta
    Write-Host "matrix sysinfo weather myip top genpass reload" -ForegroundColor Green
    Write-Host ""
}

Show-WelcomeBanner
'@

foreach ($profilePath in $profiles) {
    $profileFolder = Split-Path $profilePath -Parent
    if (-not (Test-Path $profileFolder)) {
        New-Item -ItemType Directory -Path $profileFolder -Force | Out-Null
    }
    
    # Backup si existe
    if (Test-Path $profilePath) {
        $backup = "$profilePath.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        Copy-Item $profilePath $backup -Force
        Write-Info "Backup creado: $backup"
    }
    
    Set-Content -Path $profilePath -Value $profileContent -Encoding UTF8
    Write-OK "Perfil guardado: $profilePath"
}

# ═══════════════════════════════════════════════════════════
# PASO 6: CONFIGURAR WINDOWS TERMINAL
# ═══════════════════════════════════════════════════════════
Write-Step "6/6" "CONFIGURANDO WINDOWS TERMINAL"

$wtSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (-not (Test-Path $wtSettingsPath)) {
    Write-Err "Windows Terminal no instalado o no detectado"
    Write-Info "Instala Windows Terminal desde Microsoft Store"
} else {
    # Backup
    $backup = "$wtSettingsPath.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Copy-Item $wtSettingsPath $backup -Force
    Write-Info "Backup creado: $backup"
    
    # Detectar GUID del PowerShell Core
    $currentSettings = Get-Content $wtSettingsPath -Raw | ConvertFrom-Json
    $pwshGuid = "{574e775e-4f2a-5b96-ac1e-a2962a402336}"
    
    foreach ($p in $currentSettings.profiles.list) {
        if ($p.source -eq "Windows.Terminal.PowershellCore") {
            $pwshGuid = $p.guid
            break
        }
    }
    
    Write-Info "GUID PowerShell detectado: $pwshGuid"
    
    $wtConfig = @"
{
    "`$help": "https://aka.ms/terminal-documentation",
    "`$schema": "https://aka.ms/terminal-profiles-schema",
    "actions": [],
    "copyFormatting": "none",
    "copyOnSelect": false,
    "defaultProfile": "$pwshGuid",
    "initialCols": 140,
    "initialRows": 35,
    "showTabsInTitlebar": true,
    "showTerminalTitleInTitlebar": true,
    "useAcrylicInTabRow": false,
    "theme": "Hacker Pure",
    "keybindings": 
    [
        { "id": "Terminal.CopyToClipboard", "keys": "ctrl+c" },
        { "id": "Terminal.PasteFromClipboard", "keys": "ctrl+v" },
        { "id": "Terminal.DuplicatePaneAuto", "keys": "alt+shift+d" },
        { "command": "find", "keys": "ctrl+f" },
        { "command": { "action": "splitPane", "split": "right" }, "keys": "alt+shift+plus" },
        { "command": { "action": "splitPane", "split": "down" }, "keys": "alt+shift+-" },
        { "command": "closePane", "keys": "ctrl+shift+w" }
    ],
    "newTabMenu": [ { "type": "remainingProfiles" } ],
    "profiles": 
    {
        "defaults": 
        {
            "font": 
            {
                "face": "CaskaydiaCove Nerd Font",
                "size": 11,
                "weight": "normal"
            },
            "colorScheme": "Hacker Pure",
            "opacity": 100,
            "useAcrylic": false,
            "cursorShape": "filledBox",
            "cursorColor": "#00FF41",
            "antialiasingMode": "cleartype",
            "padding": "14, 14, 14, 14",
            "intenseTextStyle": "bright",
            "scrollbarState": "hidden",
            "snapOnInput": true,
            "altGrAliasing": true,
            "historySize": 10000,
            "experimental.retroTerminalEffect": false
        },
        "list": 
        [
            {
                "commandline": "%SystemRoot%\\\\System32\\\\WindowsPowerShell\\\\v1.0\\\\powershell.exe",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell",
                "icon": "🐚",
                "tabTitle": "PS 5"
            },
            {
                "commandline": "%SystemRoot%\\\\System32\\\\cmd.exe",
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "name": "Símbolo del sistema",
                "icon": "⚫",
                "tabTitle": "CMD"
            },
            {
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
                "hidden": false,
                "name": "Azure Cloud Shell",
                "source": "Windows.Terminal.Azure",
                "icon": "☁️"
            },
            {
                "guid": "$pwshGuid",
                "hidden": false,
                "name": "PowerShell",
                "source": "Windows.Terminal.PowershellCore",
                "icon": "⚡",
                "tabTitle": "HACKER",
                "startingDirectory": "%USERPROFILE%",
                "colorScheme": "Hacker Pure",
                "font": 
                {
                    "face": "CaskaydiaCove Nerd Font",
                    "size": 11,
                    "weight": "normal"
                },
                "opacity": 100,
                "useAcrylic": false,
                "cursorShape": "filledBox",
                "cursorColor": "#00FF41",
                "padding": "14, 14, 14, 14",
                "antialiasingMode": "cleartype",
                "intenseTextStyle": "bright",
                "experimental.retroTerminalEffect": false,
                "bellStyle": "none"
            }
        ]
    },
    "schemes": 
    [
        {
            "name": "Hacker Pure",
            "background": "#000000",
            "foreground": "#00FF41",
            "cursorColor": "#00FF41",
            "selectionBackground": "#003B00",
            "black": "#000000",
            "red": "#9D00FF",
            "green": "#00FF41",
            "yellow": "#39FF14",
            "blue": "#00B321",
            "purple": "#9D00FF",
            "cyan": "#00D12A",
            "white": "#D0FFD0",
            "brightBlack": "#003B00",
            "brightRed": "#C77DFF",
            "brightGreen": "#39FF14",
            "brightYellow": "#7FFF00",
            "brightBlue": "#00FF7F",
            "brightPurple": "#B266FF",
            "brightCyan": "#00FF41",
            "brightWhite": "#FFFFFF"
        }
    ],
    "themes": 
    [
        {
            "name": "Hacker Pure",
            "tab": 
            {
                "background": "#000000FF",
                "showCloseButton": "always",
                "unfocusedBackground": "#000000FF"
            },
            "tabRow": 
            {
                "background": "#000000FF",
                "unfocusedBackground": "#000000FF"
            },
            "window": 
            {
                "applicationTheme": "dark",
                "useMica": false
            }
        }
    ]
}
"@

    # Cerrar Windows Terminal antes de escribir
    Get-Process WindowsTerminal -ErrorAction SilentlyContinue | Stop-Process -Force
    Start-Sleep -Seconds 2
    
    Set-Content -Path $wtSettingsPath -Value $wtConfig -Encoding UTF8
    Write-OK "settings.json actualizado"
}

# ═══════════════════════════════════════════════════════════
# FINALIZACIÓN
# ═══════════════════════════════════════════════════════════
Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "  ║" -NoNewline -ForegroundColor Green
Write-Host "       ✓ INSTALACIÓN COMPLETADA CON ÉXITO ✓          " -NoNewline -ForegroundColor White
Write-Host "║" -ForegroundColor Green
Write-Host "  ╚══════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "  🟢 Oh My Posh instalado" -ForegroundColor Green
Write-Host "  🟢 CaskaydiaCove Nerd Font instalada" -ForegroundColor Green
Write-Host "  🟢 Módulos PowerShell instalados" -ForegroundColor Green
Write-Host "  🟢 Tema Hacker Green creado" -ForegroundColor Green
Write-Host "  🟢 Perfil PowerShell configurado" -ForegroundColor Green
Write-Host "  🟢 Windows Terminal configurado" -ForegroundColor Green
Write-Host ""
Write-Host "  ⚠️  PASO FINAL:" -ForegroundColor Yellow
Write-Host "     Cierra TODAS las ventanas de PowerShell y" -ForegroundColor White
Write-Host "     abre Windows Terminal de nuevo." -ForegroundColor White
Write-Host ""
Write-Host "  🎮 Comandos disponibles:" -ForegroundColor Magenta
Write-Host "     matrix, sysinfo, weather, myip, top, genpass" -ForegroundColor Green
Write-Host ""

Read-Host "Presiona ENTER para salir"