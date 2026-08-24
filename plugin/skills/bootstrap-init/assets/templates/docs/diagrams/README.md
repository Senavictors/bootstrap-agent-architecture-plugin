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

Cada diagrama deve indicar propósito, escopo, data de revisão e links para os documentos relacionados em `../architecture/`.

Se o projeto já tiver diagramas de arquitetura em outro lugar (ex.: gerados por uma ferramenta, ou já existentes em outra pasta), **não duplique** — linke a partir daqui em vez de recriar.
