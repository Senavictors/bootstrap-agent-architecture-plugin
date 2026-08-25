---
name: bootstrap-complete
description: Verifica o Definition of Done de uma task ativa (código -> documentação -> testes, nessa ordem, com evidência registrada) e só então move o arquivo de .agents/tasks/active/ para .agents/tasks/completed/. Use quando o usuário disser "terminei essa task", "marca como concluída", "move pra completed". Não move nada sem confirmar que as evidências existem — se faltar algo, reporta o que falta em vez de mover mesmo assim.
---

# bootstrap-complete — checagem de DoD e conclusão da task

O princípio desta skill: **o estado da task é comunicado pela pasta em que o arquivo está** (regra do v1). Mover para `completed/` sem evidência real quebra essa garantia para qualquer sessão futura que confiar nela — por isso esta skill nunca move o arquivo sem checar antes.

## Procedimento

1. **Identifique a task.** Se o usuário não especificou qual, e há mais de uma em `active/`, pergunte.

2. **Checagem de DoD — três verificações, nesta ordem:**

   - **Código.** A seção "Registro de execução → Alterações realizadas" da task está preenchida, e o `git diff`/histórico de commits recente confirma que existe trabalho de código correspondente (não é só uma descrição sem alteração real por trás)?
   - **Documentação (docs viva).** Duas checagens:
     - Se a task tem `related_adrs` preenchido no frontmatter, ou se o trabalho mudou algo arquiteturalmente relevante, isso está de fato registrado?
     - Se a task tocou módulo, endpoint, schema de dados ou integração, o documento correspondente em `docs/` (`modules/`, `api/`, `data/`, `integrations/`, `architecture/` ou uma extensão declarada) foi atualizado? Atualizar inclui manter o frontmatter: carimbar `ultima-revisao` com a task/data, e virar `estado: planejado → real` quando a task implementou o que estava só especificado. Se o doc ainda não existe (arquivos por módulo/endpoint nascem sob demanda), crie-o agora a partir do template da subpasta. Se a task revelou que um doc `real` está errado e a correção não cabe nesta task, marque `estado: divergente` e registre a divergência — nunca deixe o doc fingindo estar certo.
     
     Se a task genuinamente não precisa de documentação nova (ex.: correção pontual sem impacto arquitetural), aceite isso — mas só se a task disser explicitamente por que não se aplica, não por omissão silenciosa.
   - **Testes.** A seção "Validação" ou "Estratégia de testes" tem comandos e resultado reais registrados — não só as caixas marcadas sem evidência ao lado?

3. **Se as três passarem**: mova o arquivo de `.agents/tasks/active/<task>.md` para `.agents/tasks/completed/<task>.md`, atualize o campo `status` no frontmatter para `completed` e `updated_at` para a data atual. Se havia um snapshot de contexto associado (`bootstrap-plan`, passo 5), mova-o junto ou marque como obsoleto.

4. **Se alguma falhar**: **não mova o arquivo.** Reporte exatamente o que falta, por item (ex.: "Testes: a seção Validação está vazia — rode a suíte real e cole o resultado antes de eu marcar como concluída"). O usuário pode registrar uma justificativa explícita para pular um item (ex.: "não precisa de teste, é só um typo de comentário") — nesse caso, registre a justificativa na própria task antes de mover, para não ficar implícito.

5. **Reporte o resultado** de forma direta: task movida ou task ainda pendente, e por quê.

## Regras que valem sempre

- Nunca mova uma task para `completed/` só porque o usuário pediu, sem checar o DoD — se o usuário insistir mesmo faltando evidência, exija a justificativa explícita do passo 4 antes de mover, não mova em silêncio.
- Nunca invente uma evidência que não está escrita na task nem confirmável pelo `git diff`.
- Esta skill não roda o guardrail anti-vazamento nem o compliance de formato — isso é `bootstrap-audit`. Se fizer sentido rodar os dois juntos antes de um commit, sugira, mas não duplique a lógica aqui.
