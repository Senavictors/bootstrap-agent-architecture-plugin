# Quarentena de skills externas — <NOME_DO_PROJETO>

Esta pasta existe para skills de terceiros que você queira avaliar antes de ativar no projeto (`.claude/skills/`). O processo é **assistido, nunca automático** — nenhuma ferramenta desta arquitetura reescreve uma skill importada sem sua aprovação explícita.

> **Nota de status (v2.0 Fase 4):** a triagem já é assistida pela skill `bootstrap-quarantine` — ela lê a skill importada, compara com a Constituição e os ADRs aceitos, e gera o `relatorio-aderencia.md` automaticamente. Ela **nunca** copia a skill para `.claude/skills/` sozinha — isso continua exigindo sua aprovação explícita, sempre.

## Processo

1. Coloque a skill importada em `.agents/quarantine/<nome-da-skill>/SKILL.md.original` — nunca diretamente em `.claude/skills/`.
2. Peça para rodar `bootstrap-quarantine` (ou peça em texto livre: "importei essa skill, pode avaliar"). Ela gera o `relatorio-aderencia.md` na mesma pasta, seguindo o modelo abaixo.
3. Revise o relatório e decida: aprovar sem alteração, aprovar com os ajustes propostos (ou outros seus), ou rejeitar. Só depois da sua aprovação explícita a skill é copiada para `.claude/skills/<nome-da-skill>/SKILL.md` — o original permanece intacto na quarentena como registro de auditoria.

## Modelo de `relatorio-aderencia.md`

```markdown
# Relatório de aderência — <nome-da-skill>

## Conflitos encontrados
- <O que a skill importada assume> vs. <o que o projeto decidiu> (ver ADR-XXX ou Constituição, item Y).

## Recomendação
- [ ] Aprovar sem alteração
- [ ] Aprovar com os ajustes descritos abaixo
- [ ] Rejeitar (motivo)

## Ajustes propostos (se aplicável)
- <Trecho específico e a mudança sugerida — nunca reescreva o arquivo inteiro sem necessidade>
```
