# Instruções para Claude Code — <NOME_DO_PROJETO>

Arquivo local (gitignored, salvo se você decidiu versionar — ver GUIA.md seção 3). A fonte principal é `AGENTS.md`, na raiz.

Leia nesta ordem:
1. `AGENTS.md`
2. `.agents/context/CONTEXT.md`
3. task ativa em `.agents/tasks/active/` (se houver)
4. o subagente especializado relevante em `.claude/agents/`

Subagentes: `.claude/agents/` (<liste os nomes dos papéis reais deste projeto>)
Skills: `.claude/skills/` (<liste as skills reais deste projeto, se houver>)
Regras globais: `.claude/rules/global.md`

Não trate este arquivo como documentação completa. Siga os links indicados e registre o estado necessário à continuidade em `.agents/tasks/` e `.agents/handoffs/`.
