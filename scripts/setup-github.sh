#!/usr/bin/env bash
# setup-github.sh — Cria repositório GitHub e faz push do skeleton AR/VR
# Uso: ./setup-github.sh <repo-name> [org-name]
# Exemplo: ./setup-github.sh arvr-skeleton minha-org

set -euo pipefail

REPO_NAME="${1:-arvr-skeleton}"
ORG="${2:-}"
GIT_USER="${GIT_USER:-AR/VR Team}"
GIT_EMAIL="${GIT_EMAIL:-team@arvr-skeleton.dev}"

echo "🚀 Setup do repositório: $REPO_NAME"

# 1. Configurar identidade git
git config user.name "$GIT_USER"
git config user.email "$GIT_EMAIL"
echo "✅ Identidade git configurada: $GIT_USER <$GIT_EMAIL>"

# 2. Renomear branch para main
git branch -m master main 2>/dev/null || true
echo "✅ Branch renomeada para 'main'"

# 3. Verificar gh CLI
if command -v gh &>/dev/null; then
    echo "🔑 Verificando autenticação gh..."
    if gh auth status &>/dev/null; then
        echo "✅ gh autenticado"
        
        # Criar repositório no GitHub
        if [ -n "$ORG" ]; then
            gh repo create "$ORG/$REPO_NAME" --public --source=. --remote=origin --push
        else
            gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
        fi
        echo "✅ Repositório criado e código enviado!"
    else
        echo "⚠️  gh não autenticado. Execute: gh auth login"
        echo "   Depois rode este script novamente."
        exit 1
    fi
else
    echo "⚠️  gh CLI não encontrada."
    echo ""
    echo "Para criar o repositório manualmente:"
    echo "  1. Crie um repositório vazio no GitHub:"
    echo "     https://github.com/new"
    echo ""
    echo "  2. Adicione o remote e faça push:"
    echo "     git remote add origin https://github.com/$ORG/$REPO_NAME.git"
    echo "     git push -u origin main"
    echo ""
    echo "Ou instale o gh CLI e autentique:"
    echo "  winget install GitHub.cli"
    echo "  gh auth login"
    exit 1
fi
