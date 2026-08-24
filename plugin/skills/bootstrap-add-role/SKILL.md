---
name: bootstrap-add-role
description: Adiciona um papel especializado (agente) novo a um projeto que já usa a arquitetura bootstrap-agent-architecture, replicando o mesmo conteúdo para .claude/agents, .cursor/rules e .codex/agents — só para as ferramentas que o projeto já usa. Use quando o usuário pedir "cria um papel para X", "preciso de um especialista em Y", ou quando bootstrap-init estiver criando os papéis iniciais de um projeto novo.
---

# bootstrap-add-role — criar ou atualizar um papel especializado

## Entradas necessárias

- Nome do papel e seu objetivo principal — se o usuário não deu isso pronto, pergunte: **"Qual o nome do novo papel e seu objetivo principal?"** Peça também, se não estiver implícito: o que esse papel pode fazer sozinho, o que ele deve recusar/perguntar antes de fazer, e se ele tem poder de veto sobre algo específico (comum em papéis de banco de dados/infra).
- Quais adaptadores este projeto usa de fato — leia `AGENTS.md`/`CLAUDE.md` existentes ou pergunte, se for a primeira vez. Nunca crie `.cursor/` ou `.codex/` "só para completar" se o projeto não usa essas ferramentas.

## Procedimento

1. **Confira duplicidade.** Verifique se já existe um papel com responsabilidade sobreposta em `.claude/agents/`. Papéis demais com fronteiras confusas são piores que poucos papéis bem definidos — se houver sobreposição real, sugira ajustar o papel existente em vez de criar um novo.

2. **Se o papel envolve uma operação de risco (banco de dados, deploy, infraestrutura), pergunte sobre MCP antes de decidir as ferramentas**: "Existe um servidor MCP configurado neste ambiente para este recurso (ex.: um MCP de Postgres/MySQL com escopo de leitura de schema)? Se sim, qual?"
   - **Se sim**: liste esse servidor MCP em `tools:` no lugar de (ou junto com) `Bash`, e registre como regra obrigatória do papel que operações destrutivas (`DROP`, `DELETE` sem `WHERE`, etc.) devem passar por esse escopo restrito, nunca por um `Bash` genérico.
   - **Se não existir ou o usuário não souber**: siga com `Bash` e a lista explícita de "o que não pode fazer sem perguntar antes" (mecanismo padrão desta arquitetura) — não bloqueie a criação do papel por falta de MCP, e não invente um servidor que não existe.

3. **Escreva o conteúdo canônico em `.claude/agents/<papel>.md` primeiro** (é o mais legível para revisar), a partir de `assets/templates/claude/agents/_role-template.md` (reaproveitado de `bootstrap-init`, ou o equivalente já usado no projeto). O corpo deve responder:
   - **Arquitetura confirmada** — citando pastas/namespaces/arquivos reais do projeto, nunca em abstrato.
   - **Regras obrigatórias, numeradas** — com o "porquê" quando não for óbvio.
   - **Referências de código reais** — 2-3 exemplos concretos, não pseudocódigo.
   - **O que pode fazer** e **o que não pode fazer sem perguntar antes** — a segunda lista é a mais importante para prevenir dano; inclua aqui qualquer poder de veto declarado pelo usuário.

4. **Frontmatter do Claude Code** — inclua os campos nativos, escolhidos pelo peso real do papel, não por padrão fixo:
   ```yaml
   ---
   name: <papel>
   description: <uma frase objetiva: quando usar, e o que este papel explicitamente NÃO faz>
   tools: <lista mínima necessária — um papel de auditoria/veto normalmente não precisa de Edit/Write; se o passo 2 confirmou um MCP, liste-o aqui>
   model: <sonnet para papéis que fazem trabalho complexo/orquestração; haiku (ou modelo leve equivalente) para papéis simples, repetitivos ou efêmeros>
   memory: project   # se este papel se beneficia de lembrar contexto entre sessões
   ---
   ```
   `model`, `memory` e `skills:` (pré-carregar skills relevantes, se houver) são campos nativos do Claude Code — não têm equivalente em Cursor/Codex; nos outros dois adaptadores, só o conteúdo textual do papel é replicado, sem esses campos.

5. **Replique para Codex, se usado**: `.codex/agents/<papel>.toml`, copiando o corpo (tudo após o frontmatter) para dentro de `developer_instructions = """ ... """`, preservando o Markdown.

6. **Replique para Cursor, se usado**: `.cursor/rules/<papel>.mdc`, copiando o mesmo corpo, com frontmatter `description` (idêntica à do Claude Code), `globs` inferidos dos caminhos reais que este papel edita (ex.: `["src/billing/**/*"]`), e `alwaysApply: false`.

7. **Confira identidade de conteúdo.** Faça um diff visual rápido entre as três versões — a única divergência aceitável é a casca (frontmatter/formato); o corpo deve ser idêntico. O uso de MCP (se houver) é exclusivo do Claude Code, então não replique a referência ao servidor MCP para Cursor/Codex — nesses dois, a regra correspondente vira texto (ex.: "operações destrutivas exigem confirmação humana"), sem citar mecanismo específico.

8. **Atualize os roteadores.** Adicione o novo papel à lista de "Papéis especializados" em `AGENTS.md` e `CLAUDE.md`.

9. **Considere atualizar `test-onboarding.md`.** Se este papel introduz uma regra que vale a pena checar na seção "Perguntas de sanidade" (`.agents/test-onboarding.md`), proponha uma pergunta nova — não é obrigatório para papéis simples.

10. **Reporte.** Confirme ao usuário: nome do papel, em quais adaptadores foi criado, o modelo escolhido para o Claude Code e por quê, se algum poder de veto foi registrado, e se o acesso a um recurso de risco ficou via MCP restrito ou via `Bash` com veto-list.

## Regras que valem sempre

- Nunca copie nome de papel, regra ou conteúdo de outro projeto — cada papel é escrito com referências reais deste projeto.
- Nunca deixe um `<PLACEHOLDER>` sem preencher no arquivo final.
- Nunca crie o adaptador de uma ferramenta que o projeto não usa.
- Um papel com poder de veto (ex.: banco de dados, deploy) deve ter isso explícito na lista "o que não pode fazer sem perguntar antes" — não deixe implícito.
