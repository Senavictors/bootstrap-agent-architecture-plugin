#!/usr/bin/env sh
# bootstrap-agent-architecture — guardrail anti-vazamento (pre-commit real)
#
# Instalado por bootstrap-install-hook. NÃO edite .git/hooks/pre-commit
# diretamente — edite este arquivo (ele pode ser versionado; o shim em
# .git/hooks/pre-commit nunca é, porque o Git não clona hooks).
#
# Escaneia o DIFF STAGED (git diff --cached) por padrões comuns de segredo.
# Mesma lógica da Checagem 3 de bootstrap-audit, aplicada aqui a qualquer
# commit feito manualmente pelo usuário, não só a ações da sessão de IA.

set -eu

STAGED=$(git diff --cached --name-only --diff-filter=ACM || true)
if [ -z "$STAGED" ]; then
  exit 0
fi

# AWS access key / private key headers / atribuição de algo com "secret", "token",
# "password" ou "api key" no nome da variável (permite prefixos/sufixos compostos,
# ex.: STRIPE_SECRET_KEY, DB_PASSWORD, API_TOKEN_PROD).
PATTERN='AKIA[0-9A-Z]{16}|-----BEGIN[A-Z ]*PRIVATE KEY-----|[A-Za-z0-9_]*(api[_-]?key|secret|token|password)[A-Za-z0-9_]*[[:space:]]*[:=][[:space:]]*.{8,}'

FOUND=0
for f in $STAGED; do
  if [ -f "$f" ]; then
    if git diff --cached -- "$f" | grep -qEi "$PATTERN"; then
      echo "guardrail anti-vazamento: possível segredo em '$f'" >&2
      FOUND=1
    fi
  fi
done

if [ "$FOUND" -eq 1 ]; then
  echo "" >&2
  echo "Commit bloqueado pelo guardrail anti-vazamento (bootstrap-agent-architecture)." >&2
  echo "Remova/rotacione o segredo antes de commitar. Para pular esta checagem em um caso" >&2
  echo "excepcional (ex.: falso positivo confirmado): git commit --no-verify" >&2
  exit 1
fi

exit 0
