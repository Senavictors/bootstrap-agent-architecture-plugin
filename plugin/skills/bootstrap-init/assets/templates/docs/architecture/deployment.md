---
estado: <planejado | real | divergente>
fonte: <arquivos de configuração/bootstrap/deploy reais que sustentam este doc, ou a spec de origem>
ultima-revisao: <task ou data>
---

# Implantação

Ambiente: <plataforma real — ex.: Replit, AWS, Docker Compose, etc.>. Escreva este documento a partir da configuração de deploy real (arquivos de config, scripts de start, variáveis de ambiente lidas no código) — nunca do que "deveria ser".

## Processos/serviços

| Serviço | Processo | Porta | Path público | Env relevantes |
|---|---|---|---|---|
| <serviço 1> | <comando real de start> | <porta> | <path> | <variáveis> |
| <serviço 2> | <comando real de start> | <porta> | <path> | <variáveis> |

## Roteamento/proxy (se houver)

<Descreva qualquer proxy reverso, path rewriting, ou motivo pelo qual um serviço está numa porta específica — geralmente ligado a uma restrição da plataforma de hospedagem que não pode ser mudada por ferramenta nenhuma. Documente o "porquê", não só o "o quê".>

## Variáveis de ambiente relevantes

- `<VAR_1>` — <o que controla, valor default, fallback>.
- `<VAR_2>` — <idem>.

## Boot da aplicação

1. <Passo 1 — ex.: inicialização de logging antes do resto>.
2. <Passo 2 — ex.: migrations aplicadas antes de aceitar tráfego>.
3. <Passo 3 — ordem real do pipeline/middleware, se relevante>.

## Armazenamento de arquivos (se aplicável)

<Onde ficam uploads/arquivos gerados pelo usuário — disco local, bucket externo, etc.>

## Observabilidade

<O que existe: logging estruturado, correlação de requisições, auditoria, alertas — e onde configurar/consultar.>

## Divergência conhecida

<Se algum diagrama ou documento anterior descrever uma topologia diferente da atual, registre aqui a divergência e qual é a versão vigente, em vez de silenciosamente corrigir ou ignorar.>
