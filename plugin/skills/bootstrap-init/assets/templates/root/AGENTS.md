# Guia de Agentes — <NOME_DO_PROJETO>

Este arquivo é local (gitignored, salvo se você decidiu versionar — ver GUIA.md seção 3) e não é compartilhado entre máquinas/devs. Cada ambiente mantém sua própria cópia.

## Projeto

<Descrição de 2-3 linhas: o que o projeto faz e sua stack real. Ex.: "Plataforma de X com backend <STACK_BACKEND> em `<PASTA_BACKEND>/` e frontend <STACK_FRONTEND> em `<PASTA_FRONTEND>/`.">

## Fontes de verdade

- Contexto vivo: `.agents/context/CONTEXT.md`
- Estado de trabalho: `.agents/tasks/` e `.agents/handoffs/`
- Decisões arquiteturais: `.agents/decisions/` (índice em `.agents/decisions/README.md`)
- Constituição e teste de sanidade: `.agents/test-onboarding.md`
- Memória persistente entre sessões: `.agents/memory/`
- Documentação real do produto (versionada ou não — ver decisão do projeto): `docs/`

## Leitura obrigatória antes de alterar código

1. Leia `.agents/context/CONTEXT.md`.
2. Identifique se há task ativa em `.agents/tasks/active/`.
3. Leia o agente especializado relevante em `.claude/agents/` (ver lista abaixo).
4. Releia a seção "Constituição" de `.agents/test-onboarding.md` — nenhuma mudança deve contradizê-la silenciosamente.
5. <Se houver uma iniciativa/feature específica em andamento, aponte para a documentação dela aqui.>

## Auditoria local

Antes de um commit ou handoff, rode a skill `bootstrap-audit` (teste de sanidade, compliance de formato entre adaptadores, guardrail anti-vazamento, índice de ADRs). Se quiser que o guardrail anti-vazamento valha também para commits feitos manualmente (fora de uma sessão de IA), rode `bootstrap-install-hook` uma vez por máquina — é opcional e não é ativado por padrão.

## Ciclo de vida de uma task

`bootstrap-plan` (ingestão → 3 opções → ADR → task em `backlog/`) → você move para `active/` ao começar → `bootstrap-handoff` se precisar pausar → `bootstrap-complete` verifica o DoD e move para `completed/`. Nenhuma dessas skills pula etapa silenciosamente — se faltar evidência, elas reportam em vez de assumir.

## Mapa do repositório

<Preencha com as pastas reais do projeto. Exemplo de formato:>

- `<PASTA_BACKEND>` — <o que é>
- `<PASTA_FRONTEND>` — <o que é>
- `docs/` — documentação real do produto
- `<outras pastas relevantes>`

## Papéis especializados (agentes)

<Liste os 3-6 papéis reais identificados para este projeto — ver GUIA.md seção 8. Não copie nomes de outro projeto.>

- `.claude/agents/<papel-1>.md` — <responsabilidade>
- `.claude/agents/<papel-2>.md` — <responsabilidade>

## Regras globais

<Liste as regras que valem para qualquer papel/agente neste projeto — mantenha curto; detalhe vai em `.claude/rules/global.md`. Exemplos do tipo de regra a incluir (adapte à sua stack):>

- Não duplique regra de negócio entre camadas.
- Não altere contratos públicos (endpoints, schemas) silenciosamente.
- Não amplie o escopo de uma task sem registrar em `.agents/tasks/`.
- Registre decisões arquiteturais relevantes em `.agents/decisions/`.
- <Regras técnicas específicas da stack: ex. ORM proibido, padrão de autenticação obrigatório, etc.>

## Comandos reais

```bash
# <Substitua pelos comandos reais de build/test/lint do projeto — nunca invente>
<comando de build>
<comando de test>
<comando de lint>
```

## Critérios de conclusão

- Critérios de aceitação da task verificados.
- Build/testes executados conforme o escopo alterado.
- Riscos e pendências declarados.
- Handoff preenchido em `.agents/handoffs/` quando houver continuação em outra sessão/ferramenta.
