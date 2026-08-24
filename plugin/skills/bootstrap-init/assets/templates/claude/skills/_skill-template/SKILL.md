---
name: <nome-da-skill>
description: <Procedimento padronizado para X. Use quando o usuário pedir Y.>
---

# Entradas obrigatórias
- <O que precisa existir/estar definido antes de rodar esta skill — ex.: task ativa, critérios de aceitação>

# Processo
1. Ler instruções e contexto (`AGENTS.md`, `.agents/context/CONTEXT.md`, papel relevante em `.claude/agents/`).
2. Verificar estado real do repositório (não assumir a partir de memória/conversa).
3. Compreender o fluxo existente antes de replicar um padrão.
4. Localizar testes relacionados.
5. Elaborar um plano proporcional ao risco da mudança.
6. Implementar a menor mudança coerente.
7. Executar as validações reais do projeto (build/test/lint).
8. Atualizar documentação, task e handoff conforme necessário.

# Restrições
- Não ampliar o escopo silenciosamente.
- Não alterar contratos públicos sem registrar compatibilidade/ADR.
- Não esconder falhas preexistentes encontradas no caminho.
- Não declarar conclusão sem evidência (comandos rodados + resultado).

# Saída
- Resumo do que foi feito.
- Arquivos alterados.
- Testes/validações executados e resultado.
- Riscos e pendências.
- Documentação/task/handoff atualizados, se aplicável.
