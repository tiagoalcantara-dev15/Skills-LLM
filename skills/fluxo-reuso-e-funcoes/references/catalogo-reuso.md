# Catalogo de reuso do Fluxo

Procure aqui antes de criar. Contagens de uso sao aproximadas.

## PHP

| Uso | Caminho | O que faz |
|-----|---------|-----------|
| ~2274 refs | `Models/Model_Generica.php` | CRUD por tabela. `new Model_Generica(true,'FLX_X')` usa a conexao client, `false` a oficial. `where` e SQL cru: nunca interpolar entrada do usuario. |
| ~920 refs | `Services/DbOldService.php` | Substitui `Zend_Db`. `selectPrepared` e `queryPrepared` com bindings, alem de transacao. |
| 338x | `DB::connection('client')` | Query Builder, padrao em Services e Models/Api novos. |
| ~2824 refs | `Utilities/AllStrategy_Date.php` | Wrapper de data com constantes `FORMAT_*`. |
| 137 refs | `Carbon` | Padrao em codigo novo de API e Services. |
| ~850 refs | `Helpers/LocalizationHelpers.php:6` | `formatLocalizedValue()`. |
| ~164 refs | `Helpers/LocalizationHelpers.php:45` | `unformatLocalizedValue()`. |
| 71x | `Services/VariableService.php` | Variaveis do sistema e do cliente (cache de 30 min). |
| ~149 refs | `Utilities/SessionNamespace.php` | Substitui `Zend_Session_Namespace`. |
| 69x | `Helpers/TempDataHelper.php` | Dados temporarios por usuario com TTL (24h por padrao). |
| 120 refs | `AllStrategy_PadronizacaoParametrosAtivos::getDadosPametrosAtivos()` | Parametros ativos (centros de custo, projetos, pessoas) com cache. |
| 74 refs | `Model_ControleAcesso::checkAccessfunctionality` | Nivel de acesso. |
| 118x | `AllStrategy_Funcoes::addSystemLog` | Grava `FLX_LOG`. |
| 84x | `Log::error` | Log Laravel, preferir em codigo novo. |
| 33x, 26x, 9x | `Http/Resources/Api/` | `BatchResultResource`, `IntegrationResource`, `PaginatedCollection`. |
| — | `Traits/BuildsBatchResult.php`, `Enums/HttpStatusCode.php`, `Exceptions/ApiException.php`, `Http/Controllers/Api/ParameterController.php` | Resposta e erro da API. |
| 34x | `Rules/ValidNoSpecialCharacters::checkSpecialCharacters` | Validacao compartilhada entre FormRequest e Module. |
| — | `Services/Api/Helpers/BatchItemValidator.php`, `Requests/Api/BaseBatchRequest.php` | Validacao em lote da API. |
| 130 arquivos | `AllStrategy_Template_Template('pasta','view',...)->get()` | Renderiza Blade como string, para HTML devolvido por Module. |
| — | `Helpers/MoneyAndFormulaNormalizerHelper`, `ExpressionLocaleConverterHelper` | Dinheiro e formulas por locale. |

## JavaScript

| Uso | Onde | O que faz |
|-----|------|-----------|
| 1427 | `lang.fluxo.js` | `LangFluxo.get('Texto PT', {chave: valor})`. |
| 237 | `allstrategy-legacy/AllStrategyFuncoes.js:120` | `AllStrategyFuncoes.fetch(url, dados, ...)`. Retorna `$.Deferred`. Ja injeta `type-post` e `version-system`. |
| 369 e 381 | `allstrategy-legacy/functions-form.js:543,572` | `resultPost` e `resultError`. |
| 145 | `allstrategy-notifications/notifications.js:12` | `allstrategyNotification(msg, tipo, ms)` (toast). |
| 15 e 7 | `components/modalAlert/functions.js:184` | `modalAlert(...)` e `AlertModalManager`. |
| 83 | `functions-form.js:651` | `formConfirmacao(acaoConfirma, texto, acaoNega, titulo)`. |
| 119 | `functions-form.js` | `FunctionFormAjaxForm()`. |
| 131 | `allstrategy-legacy/functions.js` | `buildDropBox()`. |
| 106 | `allstrategy-legacy/functions-table-documentos.js:100` | `buildtableDocumentos('.seletor')` (DevExtreme DataGrid). |
| 220 | `localization.services.js:279` | `formatLocalizedValue` (JS). |
| — | `localization.services.js` | `getLocalizedMaskMoneyConfig`, `getLocalizedAutoNumericConfig`, `getLocalizedHighchartsSetOptions`. |
| 104 | `localization.services.js:398` | `getLocalizationStringFormatDateDefault`. |
| 89 | `resources/js/functions.js` | `generealFunctions.*`. |
| — | `components/{skeletonLoader,tagBox,launchModal,treeView}/functions.js`, `all-date-range-picker.js` | Componentes. |

## Contrato Module -> UI

O retorno do Module leva `status` (0 e erro), `msg`, `redirect` e `callback_application`. O tipo de `status` e misto (string e inteiro) nos Modules e o JS aceita os dois. Nao existe helper padrao de resposta: cada Module monta o array a mao. Mantenha o formato dos modulos novos (`Modules/Bankdemonstration/`).

## Anti-padroes de reuso

- `number_format` e `.val().replaceAll('.', '')` para dinheiro. Use `formatLocalizedValue` / `unformatLocalizedValue`.
- `AllStrategy_Funcoes::PriceVirgula` e `price`.
- Atribuir array direto a `Auth::user()` ou `SessionNamespace`: nao persiste. Use `__set`.
- SQL com interpolacao (ex.: `UnidadeModule.php` interpola `$params` nas linhas 47, 58, 76, 86, 247, 268). Use `selectPrepared` / `queryPrepared` ou bindings.
- `$.ajax` repetido com `type-post` e `version-system`: use `AllStrategyFuncoes.fetch`.
- Funcoes possivelmente mortas (`getDadosCores`, `getPersonalizedTitle`): confirme uso antes de reaproveitar.

## Decisoes

- **Banco em tela nova (Module):** `DbOldService` / `Model_Generica`, sempre com bindings. **Service e API novos:** `DB::connection('client')`.
- **Data em codigo novo:** `Carbon`. `AllStrategy_Date` so ao manter tela legada que ja o usa.
