# Mapa da Documentação — <NOME_DO_PROJETO>

<Se você decidiu manter esta pasta local (gitignored) — ver GUIA.md seção 3 — mantenha esta linha. Se decidiu versionar, remova-a.>
Pasta local (gitignored). Documentação de arquitetura de apoio, separada de qualquer documentação de produto que já exista em outro lugar do repositório.

## Comece por aqui

1. [Arquitetura](architecture/README.md)
2. [Domínio](domain/README.md)
3. [Módulos](modules/README.md)
4. [API](api/README.md)
5. [Dados](data/README.md)
6. [Integrações](integrations/README.md)
7. [Diagramas](diagrams/README.md)

## Implementar uma funcionalidade

Task (`.agents/tasks/`) → módulo (`modules/`) → API/dados (`api/`, `data/`) → decisões (`.agents/decisions/`) → testes

## Corrigir um bug

Task → módulo → known issues → testes → causa raiz → handoff (`.agents/handoffs/`)
