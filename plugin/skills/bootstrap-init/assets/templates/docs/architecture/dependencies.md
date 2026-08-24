# Dependências

Direção estrita de dependência entre camadas/containers.

## Backend

```text
<Camada de entrada>  →  <Camada de negócio>  →  <Camada de dados>  →  <Núcleo/domínio>
```

- **Permitido**: uma camada depende apenas da(s) camada(s) imediatamente abaixo.
- **Proibido**: o núcleo/domínio depender de qualquer outra camada.
- **Proibido**: camadas inferiores referenciarem camadas superiores.
- **Proibido**: pular uma camada (ex.: camada de entrada acessar dados diretamente, sem passar pela camada de negócio).
- **Proibido**: <tecnologia proibida específica da stack, se houver — ex.: "introduzir ORM X quando a stack usa Y por decisão deliberada">.

## Frontend

```text
<Camada de UI>  →  <Camada de serviços/dados>
```

- **Permitido**: <regra>.
- **Proibido**: <regra inversa proibida>.

## Entre containers

```text
<Frontend>  →  <Backend>  →  <Banco>
```

- **Proibido**: o frontend acessar o banco diretamente.
- **Proibido**: qualquer camada abrir conexão com serviços externos fora dos componentes dedicados a isso.

## Contratos públicos

Endpoints/DTOs (ou equivalente) são o contrato entre containers. Mudança de contrato não deve ser silenciosa — registrar em `.agents/decisions/` (ADR) quando quebrar compatibilidade.
