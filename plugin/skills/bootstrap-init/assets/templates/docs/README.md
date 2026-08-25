# Mapa da Documentação — <NOME_DO_PROJETO>

<Se você decidiu manter esta pasta local (gitignored) — ver GUIA.md seção 3 — mantenha esta linha. Se decidiu versionar, remova-a.>
Pasta local (gitignored). Documentação de arquitetura de apoio, separada de qualquer documentação de produto que já exista em outro lugar do repositório.

## Convenção de estado (documentação viva)

Todo documento desta pasta (exceto os `README.md` de índice) começa com um frontmatter mínimo:

```yaml
---
estado: planejado | real | divergente
fonte: <arquivo/pasta de código que sustenta este doc, ou a spec de origem>
ultima-revisao: <task ou data que atualizou este doc por último>
---
```

- **planejado** — descreve algo especificado mas ainda não implementado (projeto novo ou funcionalidade futura).
- **real** — descreve o comportamento confirmado no código atual.
- **divergente** — o documento e o código real discordam e a divergência ainda não foi resolvida; registre a divergência no corpo do doc, nunca corrija silenciosamente.

Quem mantém isso vivo: `bootstrap-complete` (ao concluir uma task que toca a área, atualiza o doc, carimba `ultima-revisao` e vira `planejado → real` quando aplicável) e `bootstrap-audit` (aponta docs `real` suspeitos de estarem defasados).

## Fontes primárias

Se já existe documentação forte fora desta pasta (ex.: um documento mestre na raiz, `api/docs/`, wiki), esta pasta **complementa** — nunca duplica. Declare aqui quem é dono de cada assunto:

| Assunto | Fonte primária |
|---|---|
| <ex.: fluxos funcionais completos> | <ex.: `DOCUMENTACAO.md` na raiz> |
| <ex.: contratos de API já publicados> | <ex.: `api/docs/`> |
| <assuntos sem dono externo> | esta pasta (`docs/`) |

_(Se não existe documentação externa, registre "não há — esta pasta é a fonte primária" e apague as linhas de exemplo.)_

## Regra de organização

Nenhum arquivo solto na raiz de `docs/` além deste `README.md` — todo doc vive numa subpasta do mapa abaixo. Documentos pré-existentes que já estavam soltos aqui não são movidos silenciosamente: catalogue-os e linke-os nesta seção até que sejam realocados com aprovação.

## Comece por aqui

Núcleo (existe em todo projeto):

1. [Arquitetura](architecture/README.md)
2. [Domínio](domain/README.md)
3. [Módulos](modules/README.md)
4. [API](api/README.md)
5. [Dados](data/README.md)
6. [Integrações](integrations/README.md)
7. [Diagramas](diagrams/README.md)

Extensões deste projeto (criadas por `bootstrap-init` mediante detecção + confirmação — apague as linhas que não se aplicam):

- <ex.: [`ai/`](ai/README.md) — avaliação/segurança de funcionalidades de IA do produto>
- <ex.: [`product/`](product/README.md) — visão de produto, contrato do MVP, fluxos de UX>
- <ex.: [`ui/`](ui/README.md) — design system>
- <ex.: [`quality/`](quality/README.md) — testes, observabilidade, requisitos não funcionais>
- <ex.: [`security/`](security/README.md) — threat model, privacidade>
- <ex.: [`roadmap/`](roadmap/README.md) — roadmap do produto>

Toda extensão nova entra declarada nesta lista — nenhuma pasta surge em `docs/` sem constar deste mapa.

## Implementar uma funcionalidade

Task (`.agents/tasks/`) → módulo (`modules/`) → API/dados (`api/`, `data/`) → decisões (`.agents/decisions/`) → testes

## Corrigir um bug

Task → módulo → known issues → testes → causa raiz → handoff (`.agents/handoffs/`)
