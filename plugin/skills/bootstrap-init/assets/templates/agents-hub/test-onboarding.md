# Teste de Sanidade — <NOME_DO_PROJETO>

Este arquivo tem duas seções com propósitos diferentes. Não misture o conteúdo delas — um `bootstrap-audit` futuro precisa poder checar as duas separadamente.

## Constituição do projeto

Princípios inegociáveis, coletados do usuário na inicialização (`bootstrap-init`). Qualquer proposta de mudança que contradiga um item aqui deve ser sinalizada explicitamente antes de prosseguir — não corrigida ou ignorada silenciosamente.

- <Princípio 1 — ex.: "tenant sempre derivado do JWT, nunca de parâmetro de request">
- <Princípio 2>
- <Princípio 3>

_Atualize esta seção quando o usuário declarar uma nova restrição inegociável — não adicione itens aqui por conta própria; isso é decisão do usuário, registrada aqui como referência rápida (o detalhe completo, se houver, vive em `.agents/decisions/`)._

## Perguntas de sanidade

Perguntas específicas deste projeto (não genéricas) que o agente deve responder corretamente, mentalmente, antes de começar a codificar uma task nova. O objetivo é confirmar que o contexto atual da sessão não perdeu uma regra arquitetural importante — não é um exame com nota, é uma checagem de si mesmo.

1. <Pergunta 1 — ex.: "Qual camada nunca pode depender de qual outra, e por quê?">
2. <Pergunta 2 — ex.: "Que operação neste projeto exige confirmação humana antes de executar?">
3. <Pergunta 3 — ex.: "Qual papel tem poder de veto sobre mudanças destrutivas de banco, e o que ele veta?">

`bootstrap-audit` relê esta seção como parte da checagem de sanidade — ver a skill `bootstrap-audit` para o que acontece quando a resposta não bate com o comportamento observado na sessão.
