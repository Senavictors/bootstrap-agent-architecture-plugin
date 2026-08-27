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
#
# POSIX sh puro — sem dependência de GNU coreutils. Testado com o grep BSD do
# macOS e com o GNU grep do Linux; os padrões usam só ERE POSIX ({n}, {n,},
# [[:space:]]), suportados pelos dois.

set -eu

# AWS access key / private key headers / atribuição de algo com "secret", "token",
# "password" ou "api key" no nome da variável (permite prefixos/sufixos compostos,
# ex.: STRIPE_SECRET_KEY, DB_PASSWORD, API_TOKEN_PROD).
PATTERN='AKIA[0-9A-Z]{16}|-----BEGIN[A-Z ]*PRIVATE KEY-----|[A-Za-z0-9_]*(api[_-]?key|secret|token|password)[A-Za-z0-9_]*[[:space:]]*[:=][[:space:]]*.{8,}'

# `core.quotePath=false` para o Git não devolver nomes com acento escapados
# ("configura\303\247\303\243o.yml"), e `while IFS= read -r` em vez de
# `for f in $STAGED` para não quebrar nomes com espaço ("Minhas Notas.md").
# Ambos são a regra, não a exceção, em projetos feitos no macOS e em pt-BR.
OFFENDERS=$(
  git -c core.quotePath=false diff --cached --name-only --diff-filter=ACM |
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    [ -f "$f" ] || continue
    if git diff --cached -- "$f" | grep -qEi "$PATTERN"; then
      printf '%s\n' "$f"
    fi
  done
)

if [ -n "$OFFENDERS" ]; then
  printf '%s\n' "$OFFENDERS" | while IFS= read -r f; do
    printf "guardrail anti-vazamento: possível segredo em '%s'\n" "$f" >&2
  done
  echo "" >&2
  echo "Commit bloqueado pelo guardrail anti-vazamento (bootstrap-agent-architecture)." >&2
  echo "Remova/rotacione o segredo antes de commitar. Para pular esta checagem em um caso" >&2
  echo "excepcional (ex.: falso positivo confirmado): git commit --no-verify" >&2
  exit 1
fi

exit 0
