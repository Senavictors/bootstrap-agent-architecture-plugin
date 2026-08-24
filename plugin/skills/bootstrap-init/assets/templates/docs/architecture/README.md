# Arquitetura

Visão estrutural de <NOME_DO_PROJETO>: contexto do sistema, containers, componentes, dependências permitidas/proibidas, comunicação síncrona/assíncrona, implantação, observabilidade, tolerância a falhas.

## Documentos

- [`context.md`](context.md) — propósito do sistema, atores, fronteiras e integrações externas
- [`containers.md`](containers.md) — processos/serviços implantáveis de forma independente, responsabilidades e comunicação
- [`components.md`](components.md) — componentes internos relevantes por camada/módulo
- [`dependencies.md`](dependencies.md) — direção de dependência permitida/proibida entre camadas e containers
- [`deployment.md`](deployment.md) — topologia real de implantação (ambiente, portas, variáveis de ambiente, boot)

Diagramas visuais complementares (Mermaid/PlantUML): [`../diagrams/`](../diagrams/README.md).

**Importante**: escreva estes documentos a partir do código de configuração real (arquivos de deploy, scripts de start, código de bootstrap), nunca do que "deveria ser". Se encontrar divergência entre um diagrama/documento antigo e o comportamento real, registre a divergência explicitamente em vez de escolher um dos dois silenciosamente.
