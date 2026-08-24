---
name: bootstrap-install-hook
description: Instala (opcionalmente) um hook de git pre-commit real que bloqueia commits com padrões comuns de segredo (chave AWS, chave privada, api key/secret/token/password atribuídos) — a versão sistêmica do guardrail anti-vazamento de bootstrap-audit, que só cobre ações executadas pelo próprio agente. Use quando o usuário pedir "quero que isso bloqueie commit de verdade", "instala o guardrail como hook", ou explicitamente pedir um pre-commit. Nunca instale isso sem o usuário pedir — é uma mudança no `.git/` do repositório dele, não um arquivo de configuração de IA comum.
---

# bootstrap-install-hook — guardrail anti-vazamento como hook de git real

Diferença central em relação ao guardrail de `bootstrap-audit`: aquele só bloqueia um commit/handoff que **o próprio agente** executa dentro da conversa. Este hook roda para **qualquer** `git commit`, inclusive um rodado manualmente pelo usuário num terminal separado, fora de qualquer sessão de IA. É por isso que é opt-in — mexe em `.git/hooks/`, que fica fora do que esta arquitetura normalmente toca.

## Antes de instalar — avise o usuário sobre as limitações

Diga isso explicitamente antes de instalar, não depois:

- `.git/hooks/` **nunca é versionado pelo Git** — mesmo que o script de lógica (`.agents/scripts/pre-commit-guardrail.sh`) seja commitado e chegue a outro desenvolvedor via `git clone`, o hook em si (`.git/hooks/pre-commit`) não é ativado automaticamente nessa cópia nova. Cada pessoa que clonar o repositório precisa rodar esta skill (ou o passo manual equivalente) uma vez, na própria máquina.
- É um filtro por **padrões conhecidos via `grep`** (chave AWS, cabeçalho de chave privada, `secret`/`token`/`password`/`api key` atribuídos) — não é uma solução completa de detecção de segredo. Falso negativo é possível para um segredo que não bate nenhum desses padrões; falso positivo é possível (raro, testado contra os casos comuns antes de entregar).
- `git commit --no-verify` sempre pula qualquer hook — isso é um comportamento do Git, não uma falha desta implementação. Documente isso para o usuário para que ele saiba que o hook não é uma garantia absoluta.

## Procedimento

1. **Verifique se já existe um hook `pre-commit`** em `.git/hooks/pre-commit` no repositório do usuário.
   - **Se não existir**: crie `.agents/scripts/pre-commit-guardrail.sh` (copiando `assets/pre-commit-guardrail.sh` desta skill), dê permissão de execução (`chmod +x`), e crie `.git/hooks/pre-commit` com um shim mínimo:
     ```sh
     #!/usr/bin/env sh
     exec .agents/scripts/pre-commit-guardrail.sh
     ```
     Dê permissão de execução também no shim.
   - **Se já existir** (ex.: Husky, ou outro hook do próprio usuário): **não sobrescreva**. Copie `assets/pre-commit-guardrail.sh` para `.agents/scripts/pre-commit-guardrail.sh` mesmo assim, mas mostre ao usuário a linha exata que ele precisa adicionar ao hook existente (`.agents/scripts/pre-commit-guardrail.sh || exit 1`) e pergunte se quer que você edite o arquivo existente ou prefere fazer isso manualmente.

2. **Decida onde `.agents/scripts/pre-commit-guardrail.sh` se encaixa na decisão de escopo do projeto** (categoria B/estado de processo, da mesma pergunta feita em `bootstrap-init`) — se o usuário quer que outros desenvolvedores tenham acesso fácil ao mesmo script (mesmo que precisem ativá-lo manualmente), commitar esse arquivo específico é razoável mesmo que o resto de `.agents/` fique local; deixe a decisão explícita, não assumida.

3. **Teste imediatamente após instalar**: peça para o usuário (ou faça você mesmo, se tiver acesso ao terminal do projeto) tentar um commit trivial para confirmar que o hook roda sem erro de permissão/caminho. Não declare a instalação concluída sem essa confirmação — um hook instalado com o caminho errado falha silenciosamente ou trava todo commit futuro, então vale confirmar antes de seguir em frente.

## Regras que valem sempre

- Nunca instale este hook sem o usuário pedir explicitamente.
- Nunca sobrescreva um hook `pre-commit` existente sem aprovação explícita.
- Nunca prometa que isso substitui o guardrail de `bootstrap-audit` — os dois se complementam: `bootstrap-audit` roda sob demanda dentro da sessão (mais contexto, pode ser mais criterioso); este hook roda sempre, para qualquer commit, mas só com os padrões fixos do script.
