# Escrita de functions

Modelos a copiar (codigo novo):
- PHP: `Services/Api/Integration/BankStatementService.php`, `Services/PlaidWebhookService.php`, `Services/PlaidConnectionService.php`, `Http/Controllers/Api/Integration/BankStatementController.php`
- JS: `components/graph/functions.js`, `components/rangeSlider/functions.js`, `Modules/bankdemonstration/transactionsource/script.js` (classe static)

## PHP

- Assinatura: `public|private function nome(Tipo $p): Retorno`, com a chave de abertura na **linha seguinte** (PSR-12). Visibilidade sempre explicita e retorno tipado.
- 0 a 3 parametros. Acima disso, constructor promotion (`private readonly`) e argumentos nomeados.
- Guard clause com early return, em vez de aninhar.
- `fn` em callbacks de uma expressao; `match` em vez de `switch`.
- Nao use assinatura sem tipo (`function x($params = array()){`).
- Nome em camelCase com verbo em ingles. Nunca snake_case. Acao de Module nova: `{acaoEmIngles}Action` em camelCase (ver [nomenclatura.md](nomenclatura.md)).
- Nao adicione `declare(strict_types=1)`: o repo nao usa e a decisao e manter assim.
- Formatacao PHP: Laravel Pint (ja esta no `composer.json`) e o formatador adotado, para impor PSR-12. Ainda nao existe `pint.json`; nao crie sem pedido.

```php
public static function resolveBankName(int $id, array $treasuryById): ?string
{
    $node = $treasuryById[$id] ?? null;
    if ($node === null) {
        return null;
    }

    while ($node['NIVELSUPERIOR'] && isset($treasuryById[$node['NIVELSUPERIOR']])) {
        $node = $treasuryById[$node['NIVELSUPERIOR']];
    }

    return $node['NOME'];
}
```

## JavaScript

- `function nome(a, b) {` com a chave na **mesma linha**; `const`/`let`, **nunca `var`**; ponto e virgula; aspas simples (React usa duplas).
- Prefira `function` nomeada a arrow atribuida (172 contra 35 no codigo novo).
- Exponha com `window.nome = nome` ou classe com metodos `static`.
- 0 a 2 parametros.
- AJAX novo: `AllStrategyFuncoes.fetch(...)` com `.then` ou `await`. Nao use `$.ajax`, axios nem XHR direto.
- Nome em camelCase, em ingles. Nao aninhe `function(){}`.

```js
function dscrGeralPopulateMeta(form, savedFilter) {
    const input = form.querySelector('.dscr-meta-input');
    if (!input) {
        return;
    }
    const meta = parseMetaOrDefault(savedFilter.META);
    input.value = roundToDecimals(meta);
}
```

## Tamanho

- Service novo: 10 a 30 linhas por metodo publico (mediana 11).
- JS: funcao top-level mediana 12, p90 36. Nao passe de ~40 sem motivo.
- Funcao de ate 8 linhas usada uma vez: deixe inline. Excecoes e regra completa em `fluxo-reuso-e-funcoes`.

## Anti-padroes

- Micro-wrappers de uso unico (`FiltrosModule.php:1646,1650`, `BookmarksModule.php:63,69`, `rangeSlider/functions.js:204`).
- Chave na mesma linha em PHP novo.
- Funcoes de centenas de linhas e 10 ou mais niveis (`ProjectionsHistoryModule.php:574`).
- `$.ajax` repetido com `type-post` e `version-system` (`classificationrules/functions.js:82,122`).

## Escopo de funcoes JS

O modulo ja existente dita o estilo (global + `window.x` ou classe `static`). Em modulo novo, prefira `function` nomeada exposta em `window`.
