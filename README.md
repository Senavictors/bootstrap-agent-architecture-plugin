# Marketplace local — bootstrap-agent-architecture

Este diretório contém um plugin universal de skills para Claude Code e Codex: `bootstrap-agent-architecture` (v2.2.0, roadmap de evolução completo — Fases 1 a 4).

```text
bootstrap-agent-architecture-plugin/
├── .claude-plugin/
│   └── marketplace.json        # catálogo do marketplace, aponta para ./plugin
├── README.md                    # este arquivo
└── plugin/
    ├── .claude-plugin/
    │   ├── plugin.json          # manifesto do plugin para Claude Code
    ├── .codex-plugin/
    │   └── plugin.json          # manifesto do plugin para Codex/ChatGPT
    ├── README.md                 # detalhe de instalação + o que está/não está nesta versão
    └── skills/
        ├── bootstrap-init/
        │   ├── SKILL.md
        │   └── assets/templates/  # os templates herdados do v1 + os novos (test-onboarding, quarantine, índice de ADRs)
        ├── bootstrap-add-role/
        │   └── SKILL.md
        ├── bootstrap-audit/
        │   └── SKILL.md
        ├── bootstrap-plan/            # Fase 2
        │   ├── SKILL.md
        │   └── assets/templates/snapshot-contexto.md
        ├── bootstrap-handoff/         # Fase 2
        │   └── SKILL.md
        ├── bootstrap-complete/        # Fase 2
        │   └── SKILL.md
        ├── bootstrap-quarantine/      # Fase 4
        │   └── SKILL.md
        └── bootstrap-install-hook/    # Fase 4
            ├── SKILL.md
            └── assets/pre-commit-guardrail.sh   # testado em repo git descartável antes da entrega
```

## Instalar

Copie esta pasta inteira para a sua máquina (ex.: `C:\Users\SEU_USUARIO\.claude\plugins-locais\bootstrap-agent-architecture-plugin`), depois, dentro de uma sessão do Claude Code, **use o caminho absoluto** (um caminho relativo tipo `.` não é aceito pelo comando):

```bash
/plugin marketplace add C:\Users\SEU_USUARIO\.claude\plugins-locais\bootstrap-agent-architecture-plugin
/plugin install bootstrap-agent-architecture@victor-bootstrap
```

Ou, se o marketplace estiver hospedado num repositório Git (GitHub, por exemplo), use a referência `owner/repo` ou a URL do repositório em vez de um caminho local.

Depois de instalar, rode `/reload-plugins` se os comandos não aparecerem de imediato.

### Codex

O mesmo pacote também contém o manifesto universal do Codex em `plugin/.codex-plugin/plugin.json`.
As oito skills são compartilhadas; não há uma segunda cópia do conteúdo. O marketplace existente
em `.claude-plugin/marketplace.json` também pode ser usado pelo Codex como marketplace local
compatível. A partir da raiz deste repositório:

```bash
codex plugin marketplace add C:\caminho\absoluto\para\bootstrap-agent-architecture-plugin
codex plugin add bootstrap-agent-architecture@victor-bootstrap
```

No Codex desktop, também é possível instalar pela aba de plugins; no Codex CLI, abra o navegador
com `/plugins`. Depois da instalação, inicie uma nova sessão para carregar as skills.

O Codex no aplicativo desktop e o Codex CLI oferecem suporte a plugins; a extensão de IDE não
oferece suporte a plugins neste momento.

Este fluxo (`claude plugin marketplace add` + `claude plugin install`, equivalentes de linha de comando dos comandos `/plugin` acima) foi testado de ponta a ponta nesta sessão, num ambiente isolado, antes de cada entrega — `claude plugin validate` passou sem avisos para o plugin e para o marketplace, e `claude plugin list`/`claude plugin details` confirmaram todas as skills instaladas e habilitadas:

```text
Fase 1   (v2.0.0): Skills (3)  bootstrap-add-role, bootstrap-audit, bootstrap-init
                    Custo sempre ativo: ~738 tokens/sessão

Fase 2   (v2.1.0): Skills (6)  + bootstrap-plan, bootstrap-handoff, bootstrap-complete
                    Custo sempre ativo: ~1.353 tokens/sessão

Fase 1-4 (v2.2.0): Skills (8)  + bootstrap-quarantine, bootstrap-install-hook
                    Custo sempre ativo: ~1.850 tokens/sessão (as 8 somadas)
```

Além da instalação, `bootstrap-install-hook` foi testado de verdade nesta sessão: script de guardrail rodado num repositório git descartável, bloqueando uma chave AWS e um `STRIPE_SECRET_KEY` colado por engano, sem bloquear um commit limpo (incluindo código que só menciona as palavras "secret"/"token" sem atribuir valor, para descartar falso positivo óbvio) — ver `plugin/README.md` para o detalhe dos 4 cenários testados.

## Atualizar depois

Edite os arquivos dentro de `plugin/`, suba a versão nos dois manifestos (`plugin/.claude-plugin/plugin.json`
e `plugin/.codex-plugin/plugin.json`) e atualize o marketplace correspondente antes de reinstalar.

## Escopo desta entrega

Esta versão (v2.2.0) entrega o roadmap **completo, Fases 1 a 4** (ver `Bootstrap-Agent-Architecture-v2-Final.md/pdf` para a especificação completa). O `plugin/README.md` lista exatamente o que está incluído em cada fase.
