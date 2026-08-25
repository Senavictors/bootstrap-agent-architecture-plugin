---
name: bootstrap-audit
description: Roda uma auditoria local do projeto bootstrapado por bootstrap-agent-architecture — teste de sanidade contra a Constituição, compliance de formato entre os três adaptadores, guardrail anti-vazamento de segredos, e regeneração do índice de ADRs. Use antes de um commit, antes de um handoff, ou quando o usuário pedir "audita o projeto", "confere se tá tudo certo", "roda o compliance". Não altera código de produto — só arquivos de configuração de IA e o índice de decisões.
---

# bootstrap-audit — auditoria local

Esta skill não precisa de CI nem de ferramenta nova — é uma varredura mecânica (grep/leitura de frontmatter) mais uma releitura de contexto pela própria sessão. Rode as quatro checagens nesta ordem e produza um relatório único ao final, no formato da seção "Relatório final" abaixo.

## Checagem 1 — Teste de sanidade

1. Leia `.agents/test-onboarding.md` inteiro — as duas seções, **Constituição** e **Perguntas de sanidade**.
2. Releia o que foi feito na sessão atual (ou, se invocado no início de uma sessão nova, o `CONTEXT.md` e a task ativa).
3. Para cada item da Constituição, confirme mentalmente que nada no trabalho recente o contradiz. Para cada pergunta de sanidade, confirme que a resposta certa ainda é verdadeira dado o estado atual do código (não é um exame para o usuário — é uma autochecagem sua).
4. Se encontrar uma contradição: **não corrija silenciosamente**. Reporte como falha nesta checagem e proponha, como a seção de Governança da spec v2.0 descreve ("Shadow ADR"), documentar um ADR novo justificando a mudança — ou reverter, se a mudança não foi intencional.

## Checagem 2 — Compliance de formato

Varra mecanicamente (Grep/leitura direta, sem exigir ferramenta nova):

- Todo arquivo em `.claude/agents/*.md` e `.claude/skills/*/SKILL.md` tem `description` preenchida no frontmatter?
- Todo arquivo em `.cursor/rules/*.mdc` tem `description` preenchida?
- Todo arquivo em `.codex/agents/*.toml` tem `description` preenchida?
- Para cada papel que existe nos três adaptadores, o conteúdo (corpo, não frontmatter) é idêntico entre eles? Sinalize qualquer divergência de texto encontrada — isso é o único "bug estrutural" que esta arquitetura pode ter por não ter sincronização automática.
- Algum link relativo dentro de `.agents/**/*.md` ou `docs/**/*.md` aponta para um arquivo que não existe?
- **Docs viva** (se o projeto tem `docs/` desta arquitetura): todo doc de `docs/` fora os READMEs de índice tem o frontmatter `estado`/`fonte`/`ultima-revisao` preenchido? Liste os docs marcados `estado: divergente` (são pendências abertas, não erros — mas não podem ficar esquecidos). Para docs `estado: real`, quando for barato verificar (ex.: `git log -1 --format=%ci -- <fonte>`), sinalize como **suspeito de defasagem** qualquer doc cuja `fonte` mudou no Git depois da `ultima-revisao` — apenas sinalize; quem atualiza é uma task via `bootstrap-complete`, não esta auditoria.

Para achados triviais e reversíveis (ex.: `description` ausente), **pergunte antes de corrigir**: "Encontrei `<arquivo>` sem `description`. Posso preencher com `<sugestão>`?" — nunca aplique a correção sem confirmação, mesmo sendo um achado de baixo risco.

## Checagem 3 — Guardrail anti-vazamento

Rode uma varredura de padrões comuns de segredo nos arquivos que esta arquitetura mantém (nunca no código de produto, que já deveria ter sua própria proteção):

- `.agents/context/CONTEXT.md`
- `.agents/decisions/*.md`
- `.agents/tasks/**/*.md`
- `.agents/handoffs/*.md`
- `docs/architecture/deployment.md` (onde variáveis de ambiente costumam ser documentadas — fácil de colar um valor real por engano)

Padrões mínimos a checar via grep/regex: `AKIA[0-9A-Z]{16}` (chave AWS), `-----BEGIN[A-Z ]*PRIVATE KEY-----`, sequências que pareçam token/senha atribuídas diretamente (`(api[_-]?key|secret|token|password)\s*[:=]\s*['"][^'"]{12,}['"]`), e qualquer linha copiada de um `.env` real (valor não vazio ao lado de uma variável que também aparece em `.env.example` como vazia).

Se algo for encontrado:
- Reporte como **alerta crítico**, citando arquivo e linha (sem repetir o segredo inteiro no relatório).
- Se esta mesma sessão for quem executaria um commit ou um handoff em seguida, **recuse-se a prosseguir com essa ação específica** até o segredo ser removido ou rotacionado. Deixe claro para o usuário que esta trava vale para ações que você mesmo executa nesta conversa — não é um hook de Git real, então não impede um `git commit` rodado manualmente pelo usuário num terminal separado, fora desta sessão. Se o usuário quiser a trava sistêmica (valendo para qualquer commit, mesmo manual), mencione a skill `bootstrap-install-hook` — ela instala isso como um hook de `pre-commit` de verdade, de forma opt-in.

## Checagem 4 — Índice de ADRs

Releia o frontmatter (`id`, `title`, `status`, `date`) de cada arquivo em `.agents/decisions/*.md` (exceto `_template.md`) e regenere a tabela em `.agents/decisions/README.md`, entre o cabeçalho e o comentário-marcador — não edite nada fora dessa área do arquivo.

## Relatório final

Reporte sempre neste formato, mesmo quando tudo passou:

```text
Teste de sanidade: <✅ passou | ❌ falhou — motivo>
Compliance de formato: <✅ passou | ❌ falhou — lista de achados, um por linha>
Guardrail anti-vazamento: <✅ nada encontrado | ❌ alerta crítico — arquivo(s) e ação bloqueada>
Índice de ADRs: <✅ atualizado (N decisões) | — nenhuma decisão registrada ainda>
```

## Regras que valem sempre

- Não altera código de produto — só `.agents/`, adaptadores de IA e `docs/`.
- Não corrige nada automaticamente sem perguntar antes, mesmo achados triviais.
- Não é substituto de CI — é uma checagem local, sob demanda, sem pipeline.
- Um alerta crítico do guardrail nunca é rebaixado a aviso — se um padrão de segredo for encontrado, sempre bloqueia a ação da sessão atual, mesmo que pareça um falso positivo (o usuário decide, não a skill).
