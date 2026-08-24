# Containers

Processos/serviços implantáveis de forma independente (sentido C4), mais serviços externos consumidos. Topologia de implantação real (portas, proxy) fica em [deployment.md](deployment.md); aqui o foco é responsabilidade e forma de comunicação.

## 1. <Nome do container 1 — ex.: SPA Frontend>

- <Stack, responsabilidade principal>
- <Como autentica/se comunica com o backend>

## 2. <Nome do container 2 — ex.: API Backend>

- <Stack, camadas internas — link para dependencies.md>
- <Acesso a dados: como, nunca EF/ORM proibido se for o caso>

## 3. Banco de dados

- <Motor, como o schema é gerenciado (migrations), regra de soft-delete/auditoria se aplicável>

## Serviços externos consumidos

| Serviço | Consumido por | Protocolo |
|---|---|---|
| <Serviço 1> | <Componente> | <HTTP/SMTP/etc.> |

## Comunicação entre containers

```text
<Ator> → <Container 1> → <Container 2> → <Banco>
```
