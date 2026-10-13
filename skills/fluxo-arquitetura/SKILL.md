---
name: fluxo-arquitetura
description: Define onde e como criar arquivos no repo Fluxo (Laravel + Blade + JS/Vite). Use ANTES de criar, mover ou renomear arquivo ou pasta (controller, module, service, repository, view, JS/CSS de tela, migration, teste, idioma) e ao criar tela ou endpoint de API novo.
---

# Fluxo - Arquitetura e criacao de arquivos

Use esta skill antes de criar qualquer arquivo novo. O arquivo nasce no lugar certo, com o nome certo e uma unica responsabilidade.

## Dois "Fluxos" no codigo

- **Legado migrado do Zend** (nao copiar): `Modules/` antigos, `Model_*`, `AllStrategy_*`, `resources/js/allstrategy-legacy/`.
- **Codigo novo** (modelo a copiar): `Services/Api`, `Controllers/Api`, `Repositories/Api`, `Models/Api`, `Plaid*`, `OpenFinance*`, `resources/js/Modules/**`, `resources/js/components/`.

Ao procurar um arquivo irmao para copiar, escolha sempre do codigo novo.

## Fluxo de decisao

0. Se a tarefa envolve regra de negocio do modulo, consulte antes a skill `fluxo-wiki`.
1. Procure arquivo existente que ja cubra a responsabilidade (ver `fluxo-reuso-e-funcoes`). Se existir, edite-o.
2. Identifique o tipo do arquivo na tabela abaixo.
3. Copie a estrutura, nome e estilo de um arquivo irmao do codigo novo.
4. Crie somente no local indicado e faca os registros obrigatorios.

## Roteamento por convencao de URL

Tela nova **nao cria rota**. Controller, Module, view, JS e CSS saem dos segmentos da URL, com a caixa exata (Linux e case-sensitive).

- `GET /{controller}/{metodo}` chama `{Controller}Controller::{metodo}Action()` e renderiza `views/{controller}/{metodo}.blade.php`. Sem a view, 404. (`routes/web.php` ~115-170)
- `POST/AJAX /{pasta?}/{modulo}/{metodo}` chama `App\Modules\{Pasta}\{Modulo}Module::{metodo}Action()`, e o array retornado vira JSON. (`routes/web.php` ~172-235)
- Rotas explicitas ficam acima do catch-all, que deve ser sempre o ultimo item de `web.php`.
- Tela nova = Controller + view Blade + Module AJAX + `resources/js/Modules/{recurso}/{acao}/functions.js` + `resources/css/Modules/{recurso}/{acao}/style.css`. JS e CSS carregam sozinhos pelo caminho (`layouts/app.blade.php` ~845-1040). Precisa de build do Vite.
- API nova = Controller/Api + FormRequest + Service/Api + Repository (interface + bind) + Model/Api + Resource, com rota em `routes/api.php`.

## Onde criar cada tipo de arquivo

| Tipo | Pasta | Padrao de nome | Observacoes |
|------|-------|----------------|-------------|
| Controller web | `app/Http/Controllers/` | `{Recurso}Controller` (1a maiuscula, resto minuscula: `BankdemonstrationController`); metodos `{acao}Action()` | Sem registro. Retorna `get_object_vars($this)` com `innerTitle` para o layout. Modelo: `BankdemonstrationController.php:188`. |
| Controller API | `app/Http/Controllers/Api/` (`Integration/` para sessao start/data/finish/cancel) | `{Entidade}Controller` em ingles; `store/update/destroy` ou `startAction/dataAction/finishAction/cancelAction` | Rota em `routes/api.php`. Injeta Service no construtor (`private readonly`). Parametros estendem `ParameterController`. Retorna `JsonResponse` + Resource. Modelo: `Api/Integration/BankStatementController.php`. |
| Module (AJAX de tela) | `app/Modules/{Recurso}/` (direto em `Modules/` se a URL tem 1 segmento) | `{Acao}Module.php`; metodos `{acao}Action(array $params): array` | Sem registro. Retorna `status`, `msg` e payload. Valida, orquestra e monta a resposta. Modelo: `Modules/Bankdemonstration/ClassificationrulesModule.php`. |
| Service | `app/Services/` (dominio/integracoes) e `app/Services/Api/` (API publica) | `{Nome}Service` | Na API injeta `RepositoryInterface` e `BatchItemValidator`. Em tela e instanciado com `new` dentro da Module. Regra de negocio fica no Service, sem acoplar ao HTTP; a Module so valida, orquestra e monta a resposta (modelo: Plaid e Open Finance). Modelo: `Services/Api/Integration/BankStatementService.php`. |
| Repository | `app/Repositories/Api/` + `Api/Interfaces/` + `Base/` | `{Entidade}Repository` + `{Entidade}RepositoryInterface` | So para a API. Bind em `Providers/ApiServiceProvider.php`. SQL fica aqui. |
| Model Eloquent | `app/Models/Api/` | Entidade em ingles (`CostCenter`) | `$connection='client'`, `$table`, `$fillable`, `$timestamps=false`. |
| Helper | `app/Helpers/` | `{Nome}Helper(s)`, classe com metodos `static` | Padrao mais novo para utilitario. Funcao global so via `composer.json` -> `autoload.files`. So crie se nao existir helper equivalente. |
| Rule | `app/Rules/` | `Valid{Coisa}` | Implementa `ValidationRule`. |
| Enum | `app/Enums/` | PascalCase, backed, casos UPPER | |
| FormRequest | `app/Http/Requests/Api/{Entidade}Request/{Store,Update,Delete}Request.php` | — | So API. Payload `DATA.*.CAMPO` em maiusculas. Base `BaseBatchRequest`. |
| View Blade (tela) | `resources/views/{recurso}/{acao}.blade.php` | minusculo | Subpastas por tela (`bankdemonstration/tabs/`). |
| Componente Blade | `resources/views/components/{nome}.blade.php` (anonimo, dominante) | `<x-nome>` | Usa `@props`. |
| JS de tela | `resources/js/Modules/{recurso}/[{acao}/]functions.js` e `script.js` | So esses dois nomes | Sem registro. Precisa de build do Vite. |
| JS de componente global | `resources/js/components/{nome}/functions.js` | `window.X = ...` | Carregado em todas as paginas. Par com `<x-...>`. |
| React | `resources/js/react/components/{Nome}.jsx` | PascalCase, `export default` | Registrar em `react/mount.js` (`componentRegistry`). No Blade: `<div data-react-component="Nome" data-props='@json(...)'>`. |
| CSS de tela | `resources/css/Modules/{recurso}/[{acao}/]style.css` | sempre `style.css` | Carregado pelo caminho da URL. |
| CSS de componente | `resources/css/components/{nome}.css` | kebab-case | Nao e automatico: `@import` em `components/style.css`. |
| SCSS | `resources/sass/` | — | Todo `.scss` fora de `Modules/` carrega em todas as paginas. CSS puro domina; so use SCSS se o modulo ja usa. |
| Migration | `database/migrations/` | `YYYY_MM_DD_HHMMSS_{create,add,update,change,widen}_..._{TABELA}_table.php` | Ver regra abaixo. |
| Teste | `tests/Unit/` (espelha `app/`), `Feature/MockedData/`, `Feature/RealData/` | `{Classe}Test`; metodos `test_snake_case` | Ver regra abaixo. |
| Idioma PHP | `resources/lang/{en_US,es_CL,fr_FR}.json` | chave = texto PT-BR literal | Enums de opcoes em `lang/{locale}/*.php`. |
| Idioma JS | `resources/lang/js/lang.php` | `$strings[] = 'Texto PT';` | Todo termo de `LangFluxo.get` precisa estar aqui. |
| Command (cron) | `app/Console/Commands/` | signature `proc-all:...` ou `cepp:...` | Agendar em `routes/cron.php`. |

**Nao criar codigo novo em:** `Models/Model_*`, `Utilities/AllStrategy_*`, `app/CEPP/AllStrategy_CEPP_*` (so para continuar um CEPP existente), `Controllers/Webservice/`, `resources/js/allstrategy-legacy/`.

## Regras de migration

- Tabelas e colunas em MAIUSCULAS (`FLX_*`).
- Use guardas `Schema::hasTable` / `Schema::hasColumn`, porque as migrations rodam por tenant.
- Nao defina `$connection`.
- Nunca repita o timestamp de outra migration. Verifique antes de nomear.
- Indices e FKs em minusculas com `idx_`, `fk_`, `uk_`.

## Regras de teste

- Unit espelha `app/`.
- Feature mockado define `REQUEST_URI` e `REQUEST_METHOD` antes de `parent::setUp()` e usa `withoutMiddleware(AuthAllstrategy::class)`.
- Docblock de classe bilingue `EN — ... PT — ...`.
- Mensagens novas de API: copie `BankStatementTranslationsTest.php`, que garante a chave nos 3 JSONs.
- Rode com `npm test`.

## Registros obrigatorios de tela nova (nao sao arquivos)

- Permissao em `Models/Model_ControleAcesso.php`: `carregaFuncionalidades` (~55-577), `checkAccessfunctionality` (~729) e `getValidatesAccess` (~1145).
- Titulo e icone em `Helpers/ModuleTitleHelper.php`.
- Item de menu, montado a mao em `layouts/app.blade.php` (~20-340).
- `APP_VERSION_PROPHIX` altera rotulos e modulos: confira se a tela vale para os dois perfis.

## Regras gerais

- Um arquivo, uma responsabilidade. Nao misture regra de negocio, acesso a dados e apresentacao.
- Nao crie pastas novas sem necessidade; siga a convencao das pastas irmas.
- Nao crie arquivos de documentacao, rascunho ou backup que nao foram pedidos.

## Anti-padroes

- Catch-all e `get_object_vars($this)` fora de telas do tipo antigo.
- `<style>` e `<script>` inline em views.
- Colocar mais coisas em `ParametrosController` (monolito).
- Nova classe `AllStrategy_*` ou `Model_*`.
- Duas migrations com o mesmo timestamp.
- Caixa de pasta inconsistente (`FinancialOperations` na view e `financialOperations` em JS/CSS/URL): confira a caixa exata da URL e replique.

## Checklist final

- Existe arquivo equivalente que poderia ser editado?
- Local, nome e caixa seguem a tabela e a URL?
- Copiei um irmao do codigo novo, nao do legado?
- Fiz os registros (permissao, titulo, menu, bind, `mount.js`, `@import`, `lang.php`)?
- Rodei o build do Vite se criei JS ou CSS?
