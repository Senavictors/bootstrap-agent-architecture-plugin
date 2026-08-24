# Tasks

Uma task por arquivo. O estado é comunicado pela pasta em que o arquivo está:

```text
backlog/ → active/ → completed/
                 ↘ blocked (ou um campo `status: blocked` no frontmatter)
```

Mover o arquivo entre pastas torna o estado visível sem precisar abrir o conteúdo. Use `_template.md` (em `active/`) como ponto de partida para uma task nova.
