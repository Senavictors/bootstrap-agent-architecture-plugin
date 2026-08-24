---
name: global
description: Regras globais de <NOME_DO_PROJETO>, válidas para qualquer subagente ou alteração no repositório.
---

## Propósito
<Por que essas regras existem — geralmente: consistência arquitetural entre as partes do sistema, independente de qual agente/ferramenta executa a mudança.>

## Escopo
<Quais pastas/workspaces este documento cobre. Ex.: "Todo o repositório (`<PASTA_BACKEND>/`, `<PASTA_FRONTEND>/`)".>

## Práticas exigidas
- <Regra 1 — ex.: "Backend: usar <ORM/padrão de acesso a dados>, nunca <alternativa proibida>.">
- <Regra 2 — ex.: "Frontend: usar <padrão de estado>, autenticação via <mecanismo>.">
- <Regra 3 — ex.: "Schema de banco só muda via migration em `<pasta>`.">
- <Regra 4 — ex.: "Contratos públicos (endpoints, DTOs) não mudam silenciosamente — registrar em `.agents/decisions/`.">

## Práticas proibidas
- <Proibição 1>
- <Proibição 2>
- <Proibição 3>

## Documentos necessários antes de alterar código
- `.agents/context/CONTEXT.md`
- Subagente relevante: `.claude/agents/<papel>.md`
- Task ativa em `.agents/tasks/active/`, se houver

## Comandos de validação
```bash
<comando de build/test real do backend>
```
```bash
<comando de build/test real do frontend, se aplicável>
```

## Condições de atualização
Revisar quando um novo padrão arquitetural for adotado ou quando um ADR novo em `.agents/decisions/` mudar uma regra aqui listada.
