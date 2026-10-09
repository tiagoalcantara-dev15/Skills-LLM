---
name: fluxo-wiki
description: Roteador da wiki do AllStrategy Fluxo / Prophix Cash Management. Use ao responder perguntas ou alterar codigo do Fluxo e precisar achar documentacao - regras de negocio por modulo (fluxo de caixa, contratos, conciliacao, parametros, integracao, APIs), regras tecnicas (projecao, saldos, CEPP, Open Finance).
---

# Fluxo Wiki - roteador de documentacao

Base de conhecimento do Fluxo em Markdown (um arquivo por pagina, sem subpastas).

Esta skill NAO contem o conteudo: ela indica **qual arquivo ler**. Escolha o grupo, abra o indice do grupo e leia so os arquivos da wiki indicados.

## Onde fica a wiki

Todos os caminhos abaixo sao relativos a raiz da wiki (`WIKI`). Resolva nesta ordem:

1. Variavel de ambiente `FLUXO_WIKI`, se definida.
2. `~/fluxo.wiki`.
3. Se nenhuma existir, avise o usuario que a wiki esta indisponivel, diga que a resposta nao se baseia nela e siga so com o codigo e as demais skills `fluxo-*`. Nao invente regra de negocio.

## Passo 1 - escolher o grupo

| Pergunta e sobre... | Grupo | Indice |
|---|---|---|
| Como uma tela/modulo funciona para o usuario (regra de negocio, campos, botoes, menus) | Produto | `produto/` |
| Como consumir/integrar via API (autenticacao, endpoints, HASH, WebService) | APIs | `apis/consumo-api.md` |
| Como o sistema calcula por dentro (projecao, saldos, documentos, CEPP, snapshots, moeda) | Regras tecnicas | `regras-tecnicas/` |

Desempate: "o que o usuario ve/configura" -> Produto. "Como o back calcula/processa" -> Regras tecnicas.

## Passo 2 - indices por grupo

**produto/**
- `visao-geral-acessos.md` - mapa de modulos, perfis/acessos, glossario (comece aqui se nao souber o modulo)
- `fluxo-de-caixa.md` - todas as telas do Fluxo de Caixa + Dashboards
- `contratos-planejamento.md` - Contratos, Planejamento Financeiro (orcamento/cenarios/forecast)
- `bancario.md` - Demonstracao Bancaria, Conciliacao Bancaria
- `integracao.md` - Integracao (saldos, documentos, arquivo, agente, Open Finance)
- `parametros.md` - todos os cadastros de Parametros
- `rotinas-preferencias-avancadas.md` - Gerenciamento de Rotinas, Minhas Preferencias, Opcoes Avancadas

**apis/**
- `consumo-api.md` - modulo APIs (uso/integracao externa)

**regras-tecnicas/**
- `calculo-do-fluxo.md` - projecao, montagem da tabela, saldos, documentos, conversao de moeda, fotografia
- `projecoes-por-origem.md` - contratos, conciliacao, calendario, lancamento manual
- `processos-e-integracoes.md` - CEPP, Open Finance, integracao de pessoas, scripts uteis

## Regras de uso

1. Leia primeiro o arquivo "Regra geral" do modulo (ex.: `Fluxo-de-Caixa.md`); ele indexa as telas e relacoes com outros modulos.
2. Para termo ou modulo desconhecido, busque na wiki ignorando `bkp-wiki/`: `grep -ril "<termo>" "$WIKI" --include=*.md`.
3. Navegacao oficial da wiki: `_Sidebar.md`; entrada: `Home.md`; indices nativos: `Modulos.md`, `Regras-Tecnicas.md`.
4. `bkp-wiki/` e legado (versoes antigas, `BKP-*`). So consulte se a pagina atual nao cobrir o assunto, e trate como possivelmente desatualizado.
5. Duvida cruzando grupos (ex.: "como o Calendario de Previsoes funciona e como e projetado"): leia produto + regra tecnica correspondente.
6. Se a wiki e o codigo divergirem, o codigo vale; sinalize a divergencia ao usuario. Se a wiki nao cobrir o caso, diga isso em vez de supor a regra.
7. Se a mudanca alterar uma regra documentada, avise qual pagina precisa de atualizacao. Nao edite a wiki sem pedido.

## Relacao com as outras skills fluxo-*

- **Regra de negocio:** use esta skill antes de implementar ou alterar comportamento de um modulo; o modulo identificado aqui e o mesmo que `fluxo-arquitetura` deriva da URL.
- **Reuso:** a wiki pode listar functions e services do modulo; consulte-a junto com `fluxo-reuso-e-funcoes` antes de criar logica nova.
