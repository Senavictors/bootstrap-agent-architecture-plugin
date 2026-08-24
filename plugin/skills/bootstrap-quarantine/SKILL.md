---
name: bootstrap-quarantine
description: Analisa uma skill de terceiros colocada em .agents/quarantine/ contra a Constituição e os ADRs aceitos do projeto, gera um relatorio-aderencia.md com os conflitos encontrados, e só ativa a skill em .claude/skills/ depois de aprovação explícita do usuário. Use quando o usuário disser "importei essa skill, pode avaliar", "quero usar essa skill de terceiros, mas confere antes", ou colocar um SKILL.md externo na pasta de quarentena. Nunca reescreve a skill importada sem confirmação — isso é uma regra de segurança, não um detalhe de implementação.
---

# bootstrap-quarantine — triagem assistida de skills externas

O risco que esta skill existe para evitar: uma skill de terceiros carrega convenções testadas pelo autor original, que podem contradizer uma decisão já tomada neste projeto sem que ninguém perceba até o código já ter mudado. A mitigação **não** é reescrever a skill sozinha — é comparar, relatar, e deixar a decisão final com o usuário.

## Entrada

O usuário coloca (ou pede para você colocar) o arquivo original em `.agents/quarantine/<nome-da-skill>/SKILL.md.original`. Nunca comece a análise a partir de um arquivo já dentro de `.claude/skills/` — se ele já estiver lá, pergunte se foi colocado por engano antes de prosseguir.

## Procedimento

1. **Leia a skill importada inteira** — frontmatter e corpo. Identifique, de forma objetiva: que convenções técnicas ela assume (ex.: "usa migrations automáticas", "assume ORM X", "sempre cria um branch por task"), e que sequência de passos ela impõe.

2. **Leia as fontes de verdade do projeto**: `.agents/test-onboarding.md` (seção Constituição) e todos os ADRs com `status: accepted` em `.agents/decisions/`. Ignore ADRs `superseded`/`deprecated` para fins de conflito (mas cite se a skill importada contradiz algo que já foi superado — pode ser sinal de que a skill é antiga, não necessariamente errada).

3. **Compare e liste conflitos reais**, não hipotéticos — só liste algo se a skill importada de fato assume ou instrui algo que contradiz uma linha específica da Constituição ou de um ADR. Para cada conflito, cite a linha/trecho da skill importada e o ADR ou item da Constituição que ele contradiz.

4. **Gere `.agents/quarantine/<nome-da-skill>/relatorio-aderencia.md`** a partir de `assets/templates/agents-hub/quarantine/README.md` (modelo de relatório, do `bootstrap-init`):
   - **Conflitos encontrados** — a lista do passo 3. Se não houver nenhum, diga isso explicitamente ("nenhum conflito encontrado contra a Constituição e os ADRs aceitos") em vez de omitir a seção.
   - **Recomendação** — sua sugestão (aprovar sem alteração / aprovar com ajustes / rejeitar), com justificativa objetiva. É uma recomendação, não uma decisão.
   - **Ajustes propostos** — se houver conflito e ele for corrigível com uma edição pontual (não uma reescrita ampla), proponha o trecho específico e a mudança — como um diff pequeno, não um arquivo reescrito inteiro.

5. **Apresente o relatório ao usuário e peça a decisão explícita**: aprovar sem alteração, aprovar com os ajustes propostos (ou outros que o usuário pedir), ou rejeitar.

6. **Só depois da aprovação**, copie a skill (com os ajustes exatos que o usuário confirmou, se houver) para `.claude/skills/<nome-da-skill>/SKILL.md`. Mantenha o original intacto em `.agents/quarantine/<nome-da-skill>/SKILL.md.original` — não sobrescreva nem apague, é o registro de auditoria de onde a skill veio.

7. **Se rejeitada**, deixe o arquivo original na quarentena e registre o motivo da rejeição no `relatorio-aderencia.md` (útil se alguém reconsiderar depois).

## Regras que valem sempre

- Nunca copie uma skill para `.claude/skills/` sem aprovação explícita registrada — mesmo que o relatório não tenha encontrado nenhum conflito. "Sem conflito" não é a mesma coisa que "aprovado".
- Nunca edite o arquivo `SKILL.md.original` — qualquer ajuste vira uma cópia nova, nunca uma mutação do original.
- Nunca invente um conflito para parecer mais rigoroso, nem omita um conflito real para simplificar a aprovação.
- Se a skill importada for extensa e cobrir muitas áreas, é aceitável dividir o relatório por seção da skill em vez de uma lista corrida — desde que nenhum trecho relevante fique sem checagem.
