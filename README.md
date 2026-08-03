# Skeleton AR/VR

Skeleton oficial para projetos AR/VR — bootstrap rápido com testes, CI e boas práticas.

## Stack

| Camada        | Tecnologia                          |
|---------------|-------------------------------------|
| Runtime       | Node.js 20+                         |
| Linguagem     | TypeScript 5 (strict mode)          |
| Testes Unit   | Vitest                              |
| Testes E2E    | Playwright (Chromium, Firefox, WebKit) |
| CI/CD         | GitHub Actions (4 jobs paralelos)   |
| Cobertura     | Vitest + `--coverage`               |

## Estrutura

```
arvr-skeleton/
├── src/                    # Código fonte
│   └── index.ts
├── tests/
│   ├── unit/               # Testes unitários (*.test.ts)
│   ├── integration/        # Testes de integração (*.test.ts)
│   └── e2e/                # Testes end-to-end (*.spec.ts)
├── .github/workflows/
│   └── ci.yml              # Pipeline CI completo
├── vitest.config.ts        # Config Vitest
├── playwright.config.ts    # Config Playwright (multi-browser)
├── tsconfig.json           # TypeScript strict
├── .env.example            # Variáveis de ambiente
└── package.json
```

## Comandos

```bash
# Instalar dependências
npm install

# Testes unitários
npm run test:unit

# Testes de integração
npm run test:integration

# Testes E2E (requer servidor rodando em http://localhost:3000)
npm run test:e2e

# Todos os testes
npm run test

# Type checking
npm run typecheck

# Cobertura
npm run test:coverage
```

## CI Pipeline

O GitHub Actions executa **4 jobs em paralelo**:

1. **Lint & TypeCheck** — `tsc --noEmit`
2. **Unit Tests** — Vitest + upload de coverage
3. **Integration Tests** — Vitest
4. **E2E Tests** — Playwright (instala browsers + executa)

Um job agregador (`all-tests-pass`) verifica se todos passaram.

## Como usar

1. Clone este repositório
2. `npm install`
3. Escreva seu código em `src/`
4. Adicione testes em `tests/unit/`, `tests/integration/` ou `tests/e2e/`
5. Rode `npm run test` para validar
6. Faça push — o CI valida automaticamente

## Variáveis de Ambiente

Copie `.env.example` para `.env` e ajuste:

```env
PORT=3000
BASE_URL=http://localhost:3000
```

## Licença

MIT
