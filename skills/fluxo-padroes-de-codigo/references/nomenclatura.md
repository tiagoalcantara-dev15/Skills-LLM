# Nomenclatura

Codigo novo: nomes em **ingles**. Classes em PascalCase com sufixo de papel (`Controller`, `Service`, `Repository`, `Request`, `Module`, `Helper`; Rules com prefixo `Valid*`). Metodos e variaveis em camelCase, constantes em UPPER_SNAKE (`const string X` tipada em Services/Api). Nao crie `AllStrategy_*` nem `Model_*`.

| Elemento | Padrao | Exemplo | Legado / anti-padrao |
|----------|--------|---------|----------------------|
| Classe PHP | PascalCase em ingles com sufixo | `CurrencyController`, `PlaidTransactionSyncService`, `StoreRequest` | `AllStrategy_Funcoes`, `Model_Generica`, `Bankclassification` |
| Metodo de Service/Helper/Repository | camelCase, verbo em ingles | `findOneByStructure`, `validateStoreSeparated` | `montarColunas` (PT) |
| Metodo de Module | `{acao}Action`, camelCase em ingles | `getValuesAction` | tudo minusculo (`classificarmanualAction`, `getvaloresAction`) |
| Variavel PHP | camelCase | `$dataIndex` | `$ID_BANCO`, snake_case |
| Constante PHP | UPPER_SNAKE | `COLUNAS_PLAID_COMPARAVEIS` | — |
| Enum | PascalCase, casos UPPER | `IndexType::MONETARY` | — |
| Arquivo Blade | minusculo ou kebab | `bankstatementimport.blade.php`, `modal-link.blade.php` | snake |
| Arquivo JS | `functions.js` e `script.js` por tela | `Modules/bankdemonstration/bankclassification/functions.js` | — |
| Classe JS | PascalCase em `window` | `window.SkeletonLoader = class {...}` | `class systemSettings` |
| Funcao/variavel JS | camelCase em ingles | `applyColumns` | PT misto (`abrirPainelRegra`) |
| Constante JS | UPPER_SNAKE com prefixo do contexto | `DSCR_GERAL_TEMPLATE_ID` | — |
| Classe CSS | kebab-case | `debt-dashboard-card` | snake_case, `all_*` |
| Tabela DB | `FLX_` + MAIUSCULAS | `FLX_PLAID_SALDO_DIARIO` | `TMP_INTEGRADOR_API` |
| Coluna DB | MAIUSCULAS | `ID`, `ID_BANCO`, `DATAINCLUSAO` | `id`, `created_at` |
| Indice / FK | minusculas com prefixo | `idx_`, `fk_`, `uk_` | — |
| Rota web | kebab-case | `/contratosfinanceiros/export-table-of-values` | `/get_titulo_personalizado`, `/exportValues/exportValuesCSV` |
| Rota API | kebab-case em ingles | `parameters/trading-partners`, `banking/bank-statement/start` | `/integrador/integracao/iniciar` |

## Regras

- Nao misture PT e EN no mesmo identificador.
- Em arquivo existente de Module, a rota dita o nome do metodo (`{metodo}Action`): confirme a URL antes de renomear.
- Legado a nao replicar: `AllStrategy_*`, `Model_*`, `DashboardsModuleOLD`, `dashboardsOLD`, rotas em portugues, prefixo `allstrategy-` em CSS e variaveis, propriedades privadas em maiusculas (`Model_Plaid::$CLIENT_ID`).

## Decisoes

- **id HTML novo:** camelCase (`cashFlowAlertBar`). Em arquivo existente, nao renomeie ids usados por JS ou CSS.
- **Metodo de Module novo:** camelCase em ingles (`getValuesAction`).
- `Helper` no singular ou plural e `Fluxodecaixa` contra `FluxoDeCaixa`: siga o nome ja existente na pasta.
