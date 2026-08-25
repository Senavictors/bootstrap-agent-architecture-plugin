---
name: bootstrap-init
description: Inicializa neste projeto (novo ou existente) a arquitetura de agentes de IA de Victor — roteadores AGENTS.md/CLAUDE.md, papéis especializados em .claude/.cursor/.codex, fonte de verdade de estado em .agents/ (context/tasks/handoffs/decisions/quarantine), constituição e teste de sanidade, e documentação de arquitetura do produto em docs/. Use esta skill sempre que o usuário pedir para configurar/preparar um projeto para uso com Claude Code, Cursor e/ou Codex, ou pedir para "montar os agentes desse projeto", "bootstrapar a arquitetura", "documentar a arquitetura do sistema" — mesmo sem citar o nome da skill. Não use para adicionar um papel a um projeto já inicializado (use bootstrap-add-role) nem para rodar uma checagem de sanidade/compliance (use bootstrap-audit).
---

# bootstrap-init — inicialização do projeto

Esta skill monta, uma única vez por projeto, o esqueleto completo da arquitetura de agentes de IA: roteadores, hub de estado (`.agents/`), constituição/teste de sanidade, e — se decidido — documentação de arquitetura do produto (`docs/`). Papéis especializados individuais são criados chamando o **mesmo procedimento** descrito na skill `bootstrap-add-role`, uma vez por papel — esta skill não duplica aquela lógica, só a invoca em sequência.

Se o projeto já tiver sido inicializado antes (já existe `AGENTS.md`/`.agents/`), confirme com o usuário antes de sobrescrever qualquer coisa — esta skill é para o dia zero, não para reprocessar um projeto em andamento.

## Passo 1 — Explorar o projeto de verdade

Antes de escrever qualquer arquivo:
- `ls`/`find` na raiz para entender a estrutura real (linguagens, monorepo ou não).
- Leia o `.gitignore` atual.
- Verifique se já existe `.claude/`, `.cursor/`, `.codex/`, `.agents/`, `docs/`, e se algo já está rastreado no Git por acidente: `git ls-files | grep -iE "\.claude|\.cursor|\.codex|\.agents|CLAUDE\.md|AGENTS\.md"`.
- Identifique os comandos **reais** de build/test/lint (leia `package.json`/`*.sln`/`Makefile`/`Cargo.toml`/`pyproject.toml`/etc. — nunca invente um comando). Se um comando não faz o que o nome sugere (ex.: `npm test` só roda typecheck), registre essa ressalva explicitamente para usar no passo 4.

## Passo 2 — Perguntar ao usuário (não assuma)

Use uma ferramenta de pergunta estruturada se disponível; senão, pergunte em texto e espere a resposta. Três perguntas, sempre, mesmo que o usuário já tenha respondido em outro projeto:

1. **Escopo de versionamento**: "Deseja versionar o estado das tarefas (`.agents/`), a documentação (`docs/`) e as decisões (`.agents/decisions/`) no Git, ou mantê-los apenas locais (`.gitignore`)?" — a resposta pode ser diferente por categoria (ex.: `.agents/` local, `docs/` versionado); pergunte com essa granularidade se o usuário quiser diferenciar.
2. **Constituição**: "Quais são as restrições inegociáveis (Constituição) deste projeto que eu devo sempre respeitar?" — colete quantas o usuário quiser declarar agora; deixe claro que mais podem ser adicionadas depois (`bootstrap-audit` não invalida isso por estar incompleto no dia 1).
3. **Ferramentas de IA usadas de fato**: "Quais ferramentas de IA você usa neste projeto — Claude Code, Cursor, Codex, alguma outra?" — só crie o adaptador das que a resposta confirmar.

## Passo 3 — Atualizar o `.gitignore`

Use `assets/templates/gitignore-snippet.txt` como base, removendo as linhas correspondentes a qualquer categoria que o usuário decidiu versionar no passo 2. Nunca remova a seção de segredos (`.env*`, `secrets/**`, `credentials/**`, `*.pem`, `*.key`, `backups/**`, `dumps/**`) independente da decisão.

## Passo 4 — Criar os arquivos-raiz

Copie `assets/templates/root/{AGENTS.md,CLAUDE.md,PLANS.md}` para a raiz do projeto e preencha cada `<PLACEHOLDER>` com informação real: nome do projeto, stack real, mapa de pastas real, comandos reais (com as ressalvas identificadas no passo 1), e — em `CLAUDE.md` — os nomes reais dos papéis que serão criados no passo 6. `CLAUDE.md` deve apontar explicitamente para `AGENTS.md` como fonte de verdade unificada, sem duplicar o conteúdo dele. A seção "Fontes de verdade" deve listar `.agents/context/CONTEXT.md`, `.agents/tasks/`, `.agents/handoffs/`, `.agents/decisions/` e `.agents/test-onboarding.md` — nunca uma pasta `.ai/` (esta arquitetura não usa esse conceito).

## Passo 5 — Montar o hub `.agents/`

Copie `assets/templates/agents-hub/` inteiro, incluindo as pastas novas desta versão:
- `context/CONTEXT.md` — preencha com o estado real do projeto agora (branch, iniciativa em andamento, dívida técnica conhecida, restrições) — nunca deixe genérico.
- `tasks/{active,backlog,completed}/` — deixe só com `_template.md` até existir uma task real.
- `handoffs/`, `decisions/` — deixe só com `_template.md`; copie também `decisions/README.md` (índice de ADRs, mantido depois por `bootstrap-audit`).
- `quarantine/` — copie `quarantine/README.md`; a pasta fica vazia até o usuário importar uma skill externa.
- `test-onboarding.md` — preencha a seção **Constituição** com as respostas do passo 2, item 2. Deixe a seção **Perguntas de sanidade** com 2-3 perguntas iniciais genéricas o suficiente para o estágio atual do projeto (ex.: "qual camada não pode depender de qual"); ela cresce conforme papéis são adicionados via `bootstrap-add-role`.

## Passo 6 — Identificar e criar os papéis especializados iniciais

Não existe número fixo — tipicamente 3 a 6. Decida observando o código real: onde estão as fronteiras técnicas onde as regras mudam completamente, onde um erro comum aplicaria o padrão errado, e onde existe uma operação destrutiva que merece um papel com poder de veto.

Para cada papel identificado, **execute o procedimento completo descrito na skill `bootstrap-add-role`** (leia `../bootstrap-add-role/SKILL.md` se precisar relembrar o passo a passo) — não reescreva essa lógica aqui. Isso garante que um papel criado durante o bootstrap inicial e um papel adicionado depois, num projeto já maduro, sigam exatamente o mesmo processo e o mesmo formato.

## Passo 7 — Montar `docs/` (se decidido no passo 2)

Antes de escrever, procure documentação/diagramas já existentes no projeto — reaproveite, não duplique. Se o projeto já tem uma pasta `docs/` de produto pré-existente e versionada, não a duplique nem mova — crie a nova estrutura ao lado dela, e registre no `docs/README.md` novo a tabela de **Fontes primárias** apontando quem é dono de cada assunto (a doc externa é a fonte; `docs/` só complementa).

Copie `assets/templates/docs/` e preencha assim:

**7a — Núcleo, visão geral primeiro (nunca exaustivo no bootstrap).** Preencha o `README.md` de **cada** subpasta do núcleo (`architecture/`, `domain/`, `modules/`, `api/`, `data/`, `integrations/`, `diagrams/`) com uma visão geral real do projeto — nada de placeholder genérico sobrando. Em `architecture/`, preencha também os cinco documentos (`context`, `containers`, `components`, `dependencies`, `deployment`). Os arquivos individuais por módulo/endpoint/integração **não** são criados no bootstrap: eles nascem sob demanda, quando uma task tocar aquela área (`bootstrap-plan`/`bootstrap-complete`).

**7b — Estado de cada documento (frontmatter).** Todo documento criado (exceto READMEs de índice) recebe o frontmatter `estado`/`fonte`/`ultima-revisao` descrito no template de `docs/README.md`:
- Projeto **com código**: escreva a partir do código real de configuração/bootstrap/deploy — nunca do que "deveria ser" — e marque `estado: real`, com `fonte` apontando os arquivos que sustentam o doc.
- Projeto **ainda sem código (greenfield)**: documente a arquitetura planejada a partir da especificação disponível e marque `estado: planejado` — nunca apresente o planejado como se já existisse. Conforme as tasks implementarem, `bootstrap-complete` vira o estado para `real`.
- Divergência entre doc/diagrama antigo e o comportamento real do código: marque `estado: divergente` e registre a divergência explicitamente, nunca corrija ou ignore silenciosamente.

**7c — Extensões opcionais: detecte e sugira, nunca crie por padrão.** Observe o projeto real e **sugira** ao usuário as extensões de `docs/` que se aplicam — crie somente as que ele confirmar:
- Funcionalidade de IA no produto (chamadas a APIs de LLM, prompts no código) → sugira `ai/` (avaliação, segurança e limites dessa funcionalidade).
- Projeto pré-desenvolvimento / orientado a produto (spec extensa, pouco ou nenhum código) → sugira `product/` (visão, contrato do MVP, fluxos de UX) e `roadmap/`.
- Front-end com design system ou biblioteca de componentes própria → sugira `ui/`.
- Sinais de exigência de qualidade/segurança formal (suíte de testes robusta, requisitos não funcionais declarados, dados sensíveis) → sugira `quality/` e/ou `security/`.

Cada extensão criada entra **declarada na lista de extensões do `docs/README.md`** — nenhuma pasta surge em `docs/` fora do mapa. As linhas de exemplo não usadas são apagadas.

**7d — Nada solto na raiz.** Nenhum arquivo é criado solto na raiz de `docs/` além do `README.md`. Se o projeto já tinha documentos soltos ali, catalogue-os e linke-os no `README.md` — não os mova sem aprovação.

## Passo 8 — Verificar e reportar

- `git status` não deve mostrar nenhum arquivo novo das categorias decididas como locais no passo 2.
- Reporte um resumo do que foi criado: arquivos-raiz, papéis criados (e em quais adaptadores), decisão de escopo de cada categoria, e a Constituição registrada.
- Sugira rodar `bootstrap-audit` como primeira checagem, já no fim deste bootstrap.

## Regras que valem em qualquer etapa

- Nunca invente um comando de build/test/lint.
- Nunca copie nome de papel, regra ou conteúdo de outro projeto — os exemplos em `references/` (se presentes) servem para calibrar nível de detalhe, não para copiar.
- Nunca deixe um `<PLACEHOLDER>` sem preencher nos arquivos finais.
- Nunca crie o adaptador de uma ferramenta que o usuário não usa.
- Nunca coloque uma skill importada diretamente em `.claude/skills/` sem passar por `.agents/quarantine/` primeiro (ver template de quarentena) — mesmo que a triagem ainda seja manual nesta versão.
