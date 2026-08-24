---
name: bootstrap-handoff
description: Gera ou atualiza o handoff da task ativa para pausar o trabalho e continuar depois — na mesma sessão, em outra ferramenta (Cursor/Codex), ou por outra pessoa se .agents/ for versionado. Use quando o usuário disser "faz o handoff", "vou pausar aqui", "preciso parar por hoje", ou pedir para registrar o estado antes de encerrar. Não é automático — só roda quando o usuário pede explicitamente; esta skill não tenta detectar sozinha que o contexto está acabando.
---

# bootstrap-handoff — pausa e continuidade

O gatilho é sempre manual. Não existe (e não deveria existir) uma forma confiável de a sessão detectar sozinha "meu orçamento de contexto está acabando" e disparar isso — o usuário decide quando pausar, seja por token, por fim de expediente, ou por qualquer outro motivo.

## Entrada opcional

O usuário pode passar um comentário livre junto do pedido (ex.: "faz o handoff — falta só o tratamento de erro da API"). Trate isso como o conteúdo mais confiável para a seção "Próximos passos" — mais confiável que qualquer inferência sua a partir do código.

## Procedimento

1. **Identifique a task ativa.** Se houver mais de uma em `.agents/tasks/active/`, pergunte qual (não assuma a mais recente).
2. **Rode `git status` e `git diff`** (ou equivalente do VCS do projeto) para capturar exatamente o que está modificado na working tree — isso é mais confiável que confiar na sua própria memória da sessão.
3. **Abra o arquivo da task** e atualize, sem apagar o que já existia:
   - **Registro de execução → Alterações realizadas**: o que foi de fato concluído nesta sessão, com evidência (arquivo, comando rodado, resultado).
   - **Próximos passos imediatos**: incorporando o comentário do usuário (se houver) e o que o `git diff` mostra como código a meio caminho.
   - **Pendências**: qualquer coisa que ficou sabidamente quebrada ou incompleta — não esconda isso para a task parecer mais avançada do que está.
4. **Preencha (ou atualize) `.agents/handoffs/<task-id>-<data>.md`** a partir de `assets/templates/agents-hub/handoffs/_template.md` (do `bootstrap-init`): objetivo, estado atual, concluído, em andamento, próximos passos, arquivos modificados, comandos executados, falhas atuais, decisões tomadas, e **"não refazer"** — este último campo é o mais fácil de esquecer e o que mais evita retrabalho na próxima sessão.
5. **Vincule o handoff à task** — adicione o link no campo "Handoff" da task ativa.
6. **Se o guardrail anti-vazamento não rodou recentemente**, sugira rodar `bootstrap-audit` antes de encerrar — um handoff é um bom momento para pegar um segredo colado por engano antes que ele fique registrado num arquivo que sobrevive à sessão.

## Resultado

Confirme com uma linha objetiva: "Handoff gerado em `.agents/handoffs/<arquivo>`. Para continuar, abra uma sessão nova (nesta ou noutra ferramenta, mesma branch) e peça para ler esse handoff antes de prosseguir." Lembre, se for relevante: isso só chega a outra pessoa (não só outra ferramenta na mesma máquina) se `.agents/` estiver versionado no Git — se estiver em modo local, o handoff continua funcionando entre Claude Code/Cursor/Codex na mesma máquina.

## Regras que valem sempre

- Nunca invente que algo foi concluído — só registre o que o `git diff`/execução real confirma.
- Nunca omita uma falha conhecida para o handoff parecer mais limpo.
- Nunca sobrescreva um handoff anterior da mesma task sem necessidade — se ainda é o mesmo ciclo de pausa, atualize; se é um novo ciclo, crie um arquivo novo com timestamp.
