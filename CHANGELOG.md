# Changelog

Todas as versões deste plugin. O número que o Claude Code usa para decidir se há
atualização é o campo `version` de `plugin/.claude-plugin/plugin.json` — e só ele
(a entrada do marketplace deliberadamente **não** declara `version`, para os dois
nunca divergirem).

O formato segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e o
versionamento segue [SemVer](https://semver.org/lang/pt-BR/).

## [2.3.1] — 2026-08-27

### Corrigido

- **Guardrail anti-vazamento deixava passar segredo em arquivo com espaço ou
  acento no nome.** O loop usava `for f in $STAGED`, que quebra o nome em
  pedaços no espaço ("Minhas Notas.md" → "Minhas" + "Notas.md"), e o Git
  devolve nomes não-ASCII escapados por padrão
  (`"configura\303\247\303\243o.yml"`). Nos dois casos `[ -f "$f" ]` falhava
  e o arquivo era **silenciosamente ignorado** — o hook dizia OK e o commit
  passava com o segredo. Agora usa `git -c core.quotePath=false` e
  `while IFS= read -r`. Testado com nome com espaço, com acento, e pasta com
  espaço no caminho.
- **`bootstrap-audit`: regex sugerido não funcionava no macOS.** A Checagem 3
  propunha `\s` para espaço em branco, que é extensão do GNU grep — o grep BSD
  do macOS trata como `s` literal, e o padrão parava de casar
  `token = "valor"` (com espaços em volta do `=`), falhando em silêncio.
  Trocado por `[[:space:]]`, que é POSIX e funciona nos dois greps.

## [2.3.0] — 2026-08-25

### Adicionado

- **Documentação viva.** Todo documento de `docs/` nasce com um frontmatter de
  estado (`estado: planejado | real | divergente`, `fonte`, `ultima-revisao`).
- `bootstrap-init` passo 7: preenche o núcleo inteiro de `docs/`, com modo
  greenfield e extensões opcionais detectadas e sugeridas (`ai/`, `product/`,
  `ui/`, `quality/`, `security/`, `roadmap/`).
- `docs/README.md`: tabela de fontes primárias, regra anti-arquivo-solto e mapa
  de extensões.
- `docs/diagrams/README.md`: status e fonte por diagrama, índice obrigatório em
  catálogos grandes, nota sobre geradores.

### Alterado

- `bootstrap-complete`: o Definition of Done agora exige a atualização do
  documento afetado — carimbar `ultima-revisao`, virar `planejado → real` quando
  a task implementou o que estava só especificado, e marcar `divergente` quando
  doc e código discordam.
- `bootstrap-audit`: checa o frontmatter dos docs, lista os `divergente` e
  sinaliza docs `real` defasados comparando com o `git log` da fonte declarada.

## [2.2.0] — 2026-08-25

### Adicionado

- Marketplace `victor-bootstrap` e plugin empacotado com as oito skills das
  Fases 1 a 4: `bootstrap-init`, `bootstrap-add-role`, `bootstrap-audit`,
  `bootstrap-plan`, `bootstrap-handoff`, `bootstrap-complete`,
  `bootstrap-quarantine`, `bootstrap-install-hook`.
- Licença MIT.
- README bilíngue (PT/EN) com instalação pela interface do Claude Desktop.

[2.3.1]: https://github.com/Senavictors/bootstrap-agent-architecture-plugin/releases/tag/v2.3.1
[2.3.0]: https://github.com/Senavictors/bootstrap-agent-architecture-plugin/releases/tag/v2.3.0
[2.2.0]: https://github.com/Senavictors/bootstrap-agent-architecture-plugin/releases/tag/v2.2.0
