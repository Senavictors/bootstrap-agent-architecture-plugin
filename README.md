# bootstrap-agent-architecture

<p align="center">
  <a href="#-português">🇧🇷 Português</a> ·
  <a href="#-english">🇺🇸 English</a>
</p>

---

## 🇧🇷 Português

Marketplace pessoal do Claude Code contendo um único plugin: **`bootstrap-agent-architecture`** (v2.2.0 — roadmap de evolução completo, Fases 1 a 4).

O plugin ajuda a bootstrapar e manter uma arquitetura de agentes de IA (Claude Code, Cursor, Codex) em qualquer projeto: inicialização, papéis especializados, ciclo de vida de tasks, auditoria local e um guardrail anti-vazamento de segredos.

### 📦 O que tem aqui

```text
bootstrap-agent-architecture-plugin/
├── .claude-plugin/
│   └── marketplace.json        # catálogo do marketplace, aponta para ./plugin
├── README.md                    # este arquivo
└── plugin/
    ├── .claude-plugin/
    │   └── plugin.json          # manifesto do plugin
    ├── README.md                 # detalhe de instalação + o que está/não está nesta versão
    └── skills/
        ├── bootstrap-init/          # Fase 1
        ├── bootstrap-add-role/      # Fase 1 + 4
        ├── bootstrap-audit/         # Fase 1
        ├── bootstrap-plan/          # Fase 2
        ├── bootstrap-handoff/       # Fase 2
        ├── bootstrap-complete/      # Fase 2
        ├── bootstrap-quarantine/    # Fase 4
        └── bootstrap-install-hook/  # Fase 4
```

### 🚀 Instalação (recomendado — pela interface do Claude Desktop)

A forma mais simples de instalar é direto pela interface gráfica, sem terminal:

1. Abra o **Claude Desktop**.
2. Vá em **Configurações** (Settings).
3. Acesse **Plugins**.
4. Clique em **Navegar** (Browse) → **Adicionar marketplace** (Add marketplace).
5. Cole o link deste repositório:
   ```text
   https://github.com/Senavictors/bootstrap-agent-architecture-plugin
   ```
6. Confirme a adição do marketplace e instale o plugin **`bootstrap-agent-architecture`** na lista que aparecer.

Pronto — os comandos ficam disponíveis como `/bootstrap-agent-architecture:<skill>` na próxima sessão.

### ⌨️ Instalação alternativa (via terminal / Claude Code CLI)

Se preferir usar comandos dentro de uma sessão do Claude Code:

```bash
/plugin marketplace add Senavictors/bootstrap-agent-architecture-plugin
/plugin install bootstrap-agent-architecture@victor-bootstrap
```

Ou, se preferir usar uma cópia local do repositório, use o **caminho absoluto** da pasta (um caminho relativo tipo `.` não é aceito):

```bash
/plugin marketplace add /caminho/absoluto/para/bootstrap-agent-architecture-plugin
/plugin install bootstrap-agent-architecture@victor-bootstrap
```

Depois de instalar, rode `/reload-plugins` se os comandos não aparecerem de imediato.

### 🛠️ Skills incluídas

| Skill | Comando | O que faz | Fase |
|---|---|---|---|
| `bootstrap-init` | `/bootstrap-agent-architecture:bootstrap-init` | Inicializa a arquitetura completa num projeto novo (roteadores, `.agents/`, adaptadores, docs). | 1 |
| `bootstrap-add-role` | `/bootstrap-agent-architecture:bootstrap-add-role` | Adiciona um papel especializado, replicado nos três adaptadores; pergunta sobre MCP para papéis de risco. | 1 + 4 |
| `bootstrap-audit` | `/bootstrap-agent-architecture:bootstrap-audit` | Auditoria local: teste de sanidade, compliance de formato, guardrail anti-vazamento (na sessão), índice de ADRs. | 1 |
| `bootstrap-plan` | `/bootstrap-agent-architecture:bootstrap-plan` | Ingestão (GitHub Projects ou texto colado) → 3 opções de solução → ADR → tasks em `backlog/` → snapshot opcional. | 2 |
| `bootstrap-handoff` | `/bootstrap-agent-architecture:bootstrap-handoff` | Pausa manual da task ativa: registra estado, `git diff`, próximos passos e "não refazer". | 2 |
| `bootstrap-complete` | `/bootstrap-agent-architecture:bootstrap-complete` | Checa o DoD (código → doc → testes com evidência) antes de mover a task para `completed/`. | 2 |
| `bootstrap-quarantine` | `/bootstrap-agent-architecture:bootstrap-quarantine` | Analisa uma skill externa contra a Constituição/ADRs e gera `relatorio-aderencia.md`; nunca ativa sem aprovação. | 4 |
| `bootstrap-install-hook` | `/bootstrap-agent-architecture:bootstrap-install-hook` | Instala (opt-in) um hook de `pre-commit` real com o guardrail anti-vazamento. | 4 |

Veja `plugin/README.md` para o detalhe completo de cada fase e as limitações conhecidas.

### 🔄 Atualizar depois

Pela interface: volte em **Configurações → Plugins**, atualize o marketplace e reinstale/atualize o plugin quando uma nova versão for publicada.

Pelo terminal:

```bash
/plugin marketplace update victor-bootstrap
/plugin update bootstrap-agent-architecture@victor-bootstrap
```

### ✅ Escopo desta entrega

Esta versão (v2.2.0) entrega o roadmap **completo, Fases 1 a 4** (ver `Bootstrap-Agent-Architecture-v2-Final.md/pdf` para a especificação completa). O `plugin/README.md` lista exatamente o que está incluído em cada fase, o que foi testado e as limitações que continuam valendo.

---

## 🇺🇸 English

Personal Claude Code marketplace containing a single plugin: **`bootstrap-agent-architecture`** (v2.2.0 — full roadmap, Phases 1 through 4).

The plugin helps you bootstrap and maintain an AI agent architecture (Claude Code, Cursor, Codex) in any project: project initialization, specialized roles, task lifecycle, local auditing, and a secrets anti-leak guardrail.

### 📦 What's in here

```text
bootstrap-agent-architecture-plugin/
├── .claude-plugin/
│   └── marketplace.json        # marketplace catalog, points to ./plugin
├── README.md                    # this file
└── plugin/
    ├── .claude-plugin/
    │   └── plugin.json          # plugin manifest
    ├── README.md                 # install details + what is/isn't in this version
    └── skills/
        ├── bootstrap-init/          # Phase 1
        ├── bootstrap-add-role/      # Phase 1 + 4
        ├── bootstrap-audit/         # Phase 1
        ├── bootstrap-plan/          # Phase 2
        ├── bootstrap-handoff/       # Phase 2
        ├── bootstrap-complete/      # Phase 2
        ├── bootstrap-quarantine/    # Phase 4
        └── bootstrap-install-hook/  # Phase 4
```

### 🚀 Installation (recommended — through the Claude Desktop UI)

The easiest way to install is straight from the graphical interface, no terminal needed:

1. Open **Claude Desktop**.
2. Go to **Settings**.
3. Open **Plugins**.
4. Click **Browse** → **Add marketplace**.
5. Paste this repository's link:
   ```text
   https://github.com/Senavictors/bootstrap-agent-architecture-plugin
   ```
6. Confirm adding the marketplace, then install the **`bootstrap-agent-architecture`** plugin from the list that shows up.

Done — the commands become available as `/bootstrap-agent-architecture:<skill>` in your next session.

### ⌨️ Alternative installation (via terminal / Claude Code CLI)

If you'd rather use commands inside a Claude Code session:

```bash
/plugin marketplace add Senavictors/bootstrap-agent-architecture-plugin
/plugin install bootstrap-agent-architecture@victor-bootstrap
```

Or, if you prefer a local copy of the repository, use the folder's **absolute path** (a relative path like `.` is not accepted):

```bash
/plugin marketplace add /absolute/path/to/bootstrap-agent-architecture-plugin
/plugin install bootstrap-agent-architecture@victor-bootstrap
```

After installing, run `/reload-plugins` if the commands don't show up right away.

### 🛠️ Included skills

| Skill | Command | What it does | Phase |
|---|---|---|---|
| `bootstrap-init` | `/bootstrap-agent-architecture:bootstrap-init` | Initializes the full architecture in a new project (routers, `.agents/`, adapters, docs). | 1 |
| `bootstrap-add-role` | `/bootstrap-agent-architecture:bootstrap-add-role` | Adds a specialized role, replicated across the three adapters; asks about MCP for risky roles. | 1 + 4 |
| `bootstrap-audit` | `/bootstrap-agent-architecture:bootstrap-audit` | Local audit: sanity test, format compliance, anti-leak guardrail (in-session), ADR index. | 1 |
| `bootstrap-plan` | `/bootstrap-agent-architecture:bootstrap-plan` | Intake (GitHub Projects or pasted text) → 3 solution options → ADR → tasks in `backlog/` → optional snapshot. | 2 |
| `bootstrap-handoff` | `/bootstrap-agent-architecture:bootstrap-handoff` | Manual pause of the active task: records state, `git diff`, next steps and "don't redo". | 2 |
| `bootstrap-complete` | `/bootstrap-agent-architecture:bootstrap-complete` | Checks the DoD (code → docs → tests with evidence) before moving the task to `completed/`. | 2 |
| `bootstrap-quarantine` | `/bootstrap-agent-architecture:bootstrap-quarantine` | Analyzes an external skill against the Constitution/ADRs and generates `relatorio-aderencia.md`; never activates without approval. | 4 |
| `bootstrap-install-hook` | `/bootstrap-agent-architecture:bootstrap-install-hook` | Installs (opt-in) a real `pre-commit` hook with the anti-leak guardrail. | 4 |

See `plugin/README.md` for the full breakdown of each phase and known limitations.

### 🔄 Updating later

Through the UI: go back to **Settings → Plugins**, update the marketplace, and reinstall/update the plugin whenever a new version is published.

Through the terminal:

```bash
/plugin marketplace update victor-bootstrap
/plugin update bootstrap-agent-architecture@victor-bootstrap
```

### ✅ Scope of this release

This version (v2.2.0) delivers the **complete roadmap, Phases 1 through 4** (see `Bootstrap-Agent-Architecture-v2-Final.md/pdf` for the full spec). `plugin/README.md` lists exactly what's included in each phase, what was tested, and the limitations that still apply.
