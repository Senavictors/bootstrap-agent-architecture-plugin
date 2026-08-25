# bootstrap-agent-architecture (v2.3.0 — Fases 1 a 4 + documentação viva)

Plugin do Claude Code com oito skills:

| Skill | Comando | O que faz | Fase |
|---|---|---|---|
| `bootstrap-init` | `/bootstrap-agent-architecture:bootstrap-init` | Inicializa a arquitetura completa num projeto novo (roteadores, `.agents/`, adaptadores, docs). | 1 |
| `bootstrap-add-role` | `/bootstrap-agent-architecture:bootstrap-add-role` | Adiciona um papel especializado, replicado nos três adaptadores; pergunta sobre MCP para papéis de risco. | 1 + 4 |
| `bootstrap-audit` | `/bootstrap-agent-architecture:bootstrap-audit` | Auditoria local: teste de sanidade, compliance de formato, guardrail anti-vazamento (na sessão), índice de ADRs. | 1 |
| `bootstrap-plan` | `/bootstrap-agent-architecture:bootstrap-plan` | Ingestão (GitHub Projects ou texto colado) → 3 opções de solução → ADR → tasks em `backlog/` → snapshot opcional. | 2 |
| `bootstrap-handoff` | `/bootstrap-agent-architecture:bootstrap-handoff` | Pausa manual da task ativa: registra estado, `git diff`, próximos passos e "não refazer". | 2 |
| `bootstrap-complete` | `/bootstrap-agent-architecture:bootstrap-complete` | Checa o DoD (código → doc → testes com evidência) antes de mover a task para `completed/`. | 2 |
| `bootstrap-quarantine` | `/bootstrap-agent-architecture:bootstrap-quarantine` | Analisa uma skill externa contra a Constituição/ADRs e gera `relatorio-aderencia.md`; nunca ativa sem aprovação. | 4 |
| `bootstrap-install-hook` | `/bootstrap-agent-architecture:bootstrap-install-hook` | Instala (opt-in) um hook de `pre-commit` real com o guardrail anti-vazamento, testado nesta entrega. | 4 |

## O que esta versão entrega

**Fase 1** — plugin, sub-skills, Constituição + teste de sanidade, índice de ADRs, guardrail anti-vazamento (sessão), compliance de formato, `model`/`memory`/`skills` nativos, estrutura de `.agents/quarantine/`.

**Fase 2** — ciclo de vida completo da task: `bootstrap-plan`, `bootstrap-handoff`, `bootstrap-complete`.

**Fase 4** — `bootstrap-add-role` agora pergunta sobre MCP para papéis de risco (banco/infra), com fallback automático para `Bash` + veto-list quando não há MCP disponível; `bootstrap-quarantine` automatiza a geração do relatório de aderência de skills externas (a ativação continua exigindo aprovação humana, por design); `bootstrap-install-hook` instala o guardrail anti-vazamento como hook de `pre-commit` real — **testado de ponta a ponta nesta sessão** num repositório git descartável: bloqueou uma chave AWS e um `STRIPE_SECRET_KEY` colado por engano, deixou passar um commit limpo (incluindo código que só menciona as palavras "secret"/"token" sem atribuir valor, para confirmar que não há falso positivo óbvio), e confirmou que `--no-verify` continua pulando o hook (comportamento esperado do Git, documentado para o usuário).

**Fase 3** foi absorvida pela Fase 1 (roteamento de modelo/`memory`/`skills` já estava em `bootstrap-add-role` desde o início) — não sobrou item específico para implementar à parte.

**v2.3.0 — documentação viva.** A pasta `docs/` deixou de ser um retrato do dia 1 e passou a ser mantida pelo ciclo de vida das tasks:

- **Frontmatter de estado em todo doc** (`estado: planejado | real | divergente`, `fonte`, `ultima-revisao`) — legitima documentar projetos ainda sem código (greenfield, `planejado`) e formaliza divergências (`divergente`) em vez de correções silenciosas.
- **`bootstrap-init` preenche o núcleo inteiro de `docs/`** (não só `architecture/`): visão geral real em cada subpasta (`domain/`, `modules/`, `api/`, `data/`, `integrations/`, `diagrams/`); arquivos por módulo/endpoint nascem sob demanda, não no bootstrap.
- **Extensões opcionais detectadas e sugeridas** (`ai/`, `product/`, `ui/`, `quality/`, `security/`, `roadmap/`) — criadas só com confirmação do usuário e sempre declaradas no mapa do `docs/README.md`.
- **`bootstrap-complete` fecha o ciclo**: o DoD passou a exigir que a doc da área tocada pela task seja atualizada (carimbo de `ultima-revisao`, flip `planejado → real`, ou marcação `divergente`).
- **`bootstrap-audit` vigia a defasagem**: checa o frontmatter, lista os `divergente` pendentes e sinaliza docs `real` cuja `fonte` mudou no Git depois da última revisão.
- **Governança de `docs/`**: tabela de fontes primárias (nunca duplicar doc externa existente), nenhum arquivo solto na raiz de `docs/`, e diagramas com `status`/`fonte` declarados + índice obrigatório em catálogos grandes.

## Limitações que continuam valendo (documentadas nas próprias skills)

- `bootstrap-install-hook` só ativa em `.git/hooks/` — não é versionado pelo Git; cada dev que clonar o repositório precisa rodar a skill uma vez na própria máquina, mesmo que o script de lógica esteja commitado.
- O guardrail (sessão ou hook) é baseado em padrões `grep` conhecidos — reduz risco, não elimina.
- `bootstrap-quarantine` gera o relatório automaticamente, mas a ativação da skill importada continua exigindo aprovação humana — nunca é automática.
- MCP para papéis de risco depende de existir um servidor MCP configurado para o recurso específico — `bootstrap-add-role` pergunta e cai para `Bash` com veto-list se não houver.

## Instalação local

```bash
/plugin marketplace add /caminho/absoluto/para/bootstrap-agent-architecture-plugin
/plugin install bootstrap-agent-architecture@victor-bootstrap
```

Se já tinha uma versão anterior instalada, depois de atualizar os arquivos:

```bash
/plugin marketplace update victor-bootstrap
/plugin update bootstrap-agent-architecture@victor-bootstrap
```

Depois de instalar/atualizar, os comandos aparecem como `/bootstrap-agent-architecture:<skill>`. Rode `/reload-plugins` se não aparecerem de imediato.

Para testar sem instalar (desenvolvimento):

```bash
claude --plugin-dir /caminho/absoluto/para/bootstrap-agent-architecture-plugin/plugin
```
