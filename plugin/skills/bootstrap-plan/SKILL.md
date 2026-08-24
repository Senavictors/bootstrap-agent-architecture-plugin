---
name: bootstrap-plan
description: Ingesta um problema/feature (via GitHub Projects, se configurado, ou texto colado), propõe 3 opções de solução com trade-offs, gera um ADR a partir da opção escolhida e quebra a implementação em tasks em .agents/tasks/backlog/. Use quando o usuário disser "quero implementar X", "planeja essa feature", "vamos resolver essa issue", ou colar o texto de um problema/issue para começar um trabalho novo. Não use para tasks triviais de 1 passo óbvio — aí só crie a task diretamente, sem o ritual de 3 opções.
---

# bootstrap-plan — ingestão, decisão de arquitetura e geração de tasks

Esta skill cobre o início do ciclo de vida de uma feature/problema: da entrada crua até tasks prontas em `.agents/tasks/backlog/`, com a decisão de arquitetura registrada como ADR. Não decide sozinha — toda escolha de opção é do usuário.

## Passo 1 — Ingestão

**Fonte primária (opcional): GitHub Projects.** Se o usuário pedir para puxar de lá e o ambiente tiver `gh` autenticado (`gh auth status`) ou um MCP do GitHub conectado, use-o para trazer o texto do item (título, descrição, comentários relevantes). Se `gh` não estiver disponível ou não autenticado, **não trave o fluxo** — diga isso ao usuário e peça o texto colado diretamente.

**Fonte de fallback (sempre disponível): texto colado manualmente.** É a entrada padrão quando não há GitHub Projects configurado — trate como cidadã de primeira classe, não como modo degradado.

Releia `.agents/context/CONTEXT.md` e `.agents/test-onboarding.md` (Constituição) antes de propor qualquer coisa — a proposta não pode contradizer uma restrição já registrada sem sinalizar isso explicitamente.

## Passo 2 — Propor 3 opções de solução

Cada opção precisa ter, no mínimo:
- **Abordagem** — 2-3 frases, concreta o suficiente para ser implementável, não um rótulo genérico ("opção conservadora" sem conteúdo).
- **Trade-offs** — o que se ganha e o que se perde, especificamente para este projeto (citando papéis/camadas reais do `AGENTS.md`), não trade-offs genéricos de livro-texto.
- **Impacto estimado** — que papéis (`.claude/agents/`) seriam envolvidos, e se toca alguma restrição da Constituição.

Apresente as 3 lado a lado e peça a decisão do usuário. Se nenhuma opção servir, é um sinal válido — pergunte o que está faltando e refaça, não force uma escolha entre 3 ruins.

## Passo 3 — Gerar o ADR da decisão

A partir de `assets/templates/agents-hub/decisions/_template.md` (do `bootstrap-init`) ou o equivalente já usado no projeto: preencha contexto (o problema original), decisão (a opção escolhida), alternativas consideradas (as outras 2 opções, com o motivo de não terem sido escolhidas), consequências, e plano de adoção. Numere o ADR seguindo o próximo ID disponível em `.agents/decisions/`. Depois de salvar, rode a regeneração do índice (mesma lógica da checagem 4 de `bootstrap-audit`) para o `README.md` de `.agents/decisions/` já refletir a nova entrada.

## Passo 4 — Quebrar em tasks

Gere uma ou mais tasks em `.agents/tasks/backlog/`, uma por arquivo, seguindo o mesmo formato de `assets/templates/agents-hub/tasks/active/_template.md` (contexto, problema, objetivo, critérios de aceitação, impacto técnico, plano de implementação, estratégia de testes). Preencha `related_adrs` no frontmatter com o ADR do passo 3. Não crie uma task só — quebre por fronteira técnica real (ex.: uma task de backend, uma de frontend), do mesmo jeito que a arquitetura já separa papéis.

## Passo 5 — Snapshot de contexto (opcional, sob pedido)

Se a task for grande o suficiente para justificar abrir uma sessão nova para implementá-la, ofereça: "quer que eu gere o snapshot de contexto agora, para você abrir um chat zerado e economizar tokens?" Se sim, gere `.agents/tasks/backlog/<TASK-ID>-snapshot-contexto.md` a partir de `assets/templates/snapshot-contexto.md` desta skill, preenchendo com o ADR do passo 3 e as assinaturas de código realmente relevantes (leia o código, não invente assinatura). Quando a task for movida para `active/` (início da implementação), mova o snapshot junto, para o par ficar na mesma pasta.

## Regras que valem sempre

- Nunca proponha uma opção que contradiga a Constituição sem sinalizar isso explicitamente ao usuário antes de apresentar.
- Nunca decida sozinho qual das 3 opções seguir — a decisão é sempre do usuário.
- Nunca invente uma assinatura de código no snapshot — leia o arquivo real antes de citá-lo.
- Para uma task trivial e óbvia (1 passo, sem ambiguidade de abordagem), pule o ritual das 3 opções — crie a task diretamente e diga por que pulou.
