# setup-github.ps1 — Cria repositório GitHub e faz push do skeleton AR/VR
# Uso: .\setup-github.ps1 -RepoName "arvr-skeleton" -Org "minha-org"

param(
    [string]$RepoName = "arvr-skeleton",
    [string]$Org = "",
    [string]$GitUser = "AR/VR Team",
    [string]$GitEmail = "team@arvr-skeleton.dev"
)

Write-Host "🚀 Setup do repositório: $RepoName" -ForegroundColor Cyan

# 1. Configurar identidade git
git config user.name $GitUser
git config user.email $GitEmail
Write-Host "✅ Identidade git configurada: $GitUser <$GitEmail>" -ForegroundColor Green

# 2. Renomear branch para main
git branch -m master main 2>$null
Write-Host "✅ Branch renomeada para 'main'" -ForegroundColor Green

# 3. Verificar gh CLI
$ghPath = Get-Command "gh" -ErrorAction SilentlyContinue
if ($ghPath) {
    Write-Host "🔑 Verificando autenticação gh..." -ForegroundColor Yellow
    $authStatus = gh auth status 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ gh autenticado" -ForegroundColor Green
        
        # Criar repositório no GitHub
        if ($Org) {
            gh repo create "$Org/$RepoName" --public --source=. --remote=origin --push
        } else {
            gh repo create "$RepoName" --public --source=. --remote=origin --push
        }
        Write-Host "✅ Repositório criado e código enviado!" -ForegroundColor Green
    } else {
        Write-Host "⚠️  gh não autenticado. Execute: gh auth login" -ForegroundColor Yellow
        Write-Host "   Depois rode este script novamente."
        exit 1
    }
} else {
    Write-Host "⚠️  gh CLI não encontrada." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Para criar o repositório manualmente:" -ForegroundColor Cyan
    Write-Host "  1. Crie um repositório vazio no GitHub:"
    Write-Host "     https://github.com/new"
    Write-Host ""
    Write-Host "  2. Adicione o remote e faça push:"
    if ($Org) {
        Write-Host "     git remote add origin https://github.com/$Org/$RepoName.git"
    } else {
        Write-Host "     git remote add origin https://github.com/SEU_USUARIO/$RepoName.git"
    }
    Write-Host "     git push -u origin main"
    Write-Host ""
    Write-Host "Ou instale o gh CLI e autentique:"
    Write-Host "  winget install GitHub.cli"
    Write-Host "  gh auth login"
    exit 1
}
