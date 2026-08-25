# Diagramas — <NOME_DO_PROJETO>

Diagramas em formato de texto versionável (Mermaid, PlantUML ou Structurizr DSL) — nunca só a imagem renderizada. Organize por tipo:

```text
diagrams/
├── context/
├── containers/
├── components/
├── sequences/
├── domain/
├── database/
└── deployment/
```

## Governança por diagrama

Cada diagrama deve indicar, num cabeçalho no topo do próprio arquivo:

- **Propósito e escopo** — o que mostra e o que fica de fora.
- **`status:`** — `canônico` (fonte confiável e revisada), `rascunho` (em construção) ou `desatualizado` (o código mudou e o diagrama ainda não acompanhou).
- **`fonte:`** — o código/documento primário que o diagrama representa (é contra isso que ele será conferido).
- **Data da última revisão** e links para os documentos relacionados em `../architecture/`.

Quando o catálogo passar de ~10 diagramas, mantenha um **índice** neste README (tabela: arquivo, tipo, status, fonte) — sem índice, um catálogo grande vira ruído e ninguém sabe qual diagrama ainda é confiável.

Se algum diagrama for gerado por script/ferramenta, o gerador é a fonte de verdade e o arquivo aqui é output — indique o comando de regeneração no cabeçalho e nunca edite o output à mão.

Se o projeto já tiver diagramas de arquitetura em outro lugar (ex.: gerados por uma ferramenta, ou já existentes em outra pasta), **não duplique** — linke a partir daqui em vez de recriar.
