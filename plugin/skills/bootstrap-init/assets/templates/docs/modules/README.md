# Módulos

Responsabilidade, localização, dependências e invariantes por módulo funcional.

## Template por módulo

```markdown
---
estado: <planejado | real | divergente>
fonte: <caminho do código do módulo>
ultima-revisao: <task ou data>
---

# Módulo <Nome>

## Responsabilidade
## Localização
- Backend: <caminho>
- Frontend: <caminho>

## Conceitos principais
## Dependências
### Depende de
### É usado por

## Interfaces públicas
## Invariantes
## Modos de falha
## Testes
## Decisões relacionadas
```

_(criar um arquivo por módulo conforme necessário)_
