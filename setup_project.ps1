# Script PowerShell para criar a estrutura do projeto, .gitignore e inicializar o Git
$ProjectName = "meu_app_python"

Write-Host "====== Criando a estrutura de pastas e arquivos para: $ProjectName ======" -ForegroundColor Cyan

# 1. Criar Diretórios
$Directories = @(
    "$ProjectName/apps/client/src/ui",
    "$ProjectName/apps/client/src/services",
    "$ProjectName/apps/server/src/api",
    "$ProjectName/apps/server/src/core",
    "$ProjectName/apps/server/src/models",
    "$ProjectName/apps/server/src/repositories",
    "$ProjectName/apps/server/src/services",
    "$ProjectName/apps/server/tests",
    "$ProjectName/data/postgres"
)

foreach ($dir in $Directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "Diretório criado: $dir" -ForegroundColor Green
    }
}

# 2. Criar Arquivos Vazios base e dunder init
$Files = @(
    "$ProjectName/README.md",
    "$ProjectName/docker-compose.yml",
    "$ProjectName/apps/client/requirements.txt",
    "$ProjectName/apps/client/pyproject.toml",
    "$ProjectName/apps/client/src/__init__.py",
    "$ProjectName/apps/client/src/main.py",
    "$ProjectName/apps/client/src/services/__init__.py",
    "$ProjectName/apps/server/Dockerfile",
    "$ProjectName/apps/server/requirements.txt",
    "$ProjectName/apps/server/src/__init__.py",
    "$ProjectName/apps/server/src/main.py",
    "$ProjectName/apps/server/src/api/__init__.py",
    "$ProjectName/apps/server/src/core/__init__.py",
    "$ProjectName/apps/server/src/database.py",
    "$ProjectName/apps/server/src/models/__init__.py",
    "$ProjectName/apps/server/src/repositories/__init__.py",
    "$ProjectName/apps/server/src/services/__init__.py",
    "$ProjectName/apps/server/tests/__init__.py",
    "$ProjectName/data/postgres/.gitkeep"
)

foreach ($file in $Files) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Path $file -Force | Out-Null
        Write-Host "Arquivo criado: $file" -ForegroundColor Green
    }
}

# 3. Criar e preencher o .gitignore
$GitIgnorePath = "$ProjectName/.gitignore"
$GitIgnoreContent = @"
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.toml
.cache
.pytest_cache/

# Environments and Virtual Envs
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Database files (Local SQLite or persistent folders)
*.db
*.sqlite3
data/postgres/*
!data/postgres/.gitkeep

# IDEs and Editors
.vscode/
.idea/
*.swp
*.swo

# OS files
.DS_Store
Thumbs.db
"@

Set-Content -Path $GitIgnorePath -Value $GitIgnoreContent -Encoding utf8
Write-Host "Arquivo .gitignore criado com sucesso!" -ForegroundColor Yellow

# 4. Inicializar o Git e fazer o primeiro Commit
Set-Location -Path $ProjectName

if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Host "Inicializando repositório Git..." -ForegroundColor Cyan
    git init
    git add .
    git commit -m "Initial commit: Estrutura de pastas Clean Architecture com suporte a Docker"
    Write-Host "====== Sucesso! Projeto criado e adicionado ao Git com sucesso ======" -ForegroundColor Main
} else {
    Write-Host "Aviso: Git não está instalado ou não foi encontrado no PATH. Estrutura criada, mas o commit não foi gerado." -ForegroundColor Red
}
