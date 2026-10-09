# Escrita de condicionais

## Regras

- `if (cond) {` com espaco apos `if` e chave na mesma linha. `} else {` e `} elseif (` na mesma linha. Sempre com chaves.
- Excecao: guard de uma linha so com `continue` ou `return`, sem logica.
- Comparacao estrita (`===`, `!==`). `==` e `!=` so existem em legado: nao use em codigo novo, nem em JS.
- Guard clause com `return`, `continue` ou `throw`. Aninhamento tipico de 1 a 3 niveis, maximo 4.
- `match` em vez de `switch` (125 switch contra 46 match, e o match e o mais novo).
- Ternario simples, nunca aninhado. `??` para default. `empty()` e `isset()` valem para arrays e requests; use `=== null` quando `0` ou `''` forem validos.
- Nunca condicione logica ao texto traduzido; use codigos ou IDs estaveis (ver [i18n.md](i18n.md)).
- JS: `?.` e `||` para default.

## Exemplos reais (`PlaidWebhookService.php:19`, `BankStatementService.php:96`)

```php
if (!$itemId) {
    return ['success' => false, 'error' => 'item_id missing'];
}
...
$account = $this->resolveAccount($item, $lookups);
if (is_string($account)) {
    $errors["DATA.{$index}." . self::ACCOUNT_FIELD] = [$account];
    continue;
}
```

`match`: `PlaidConnectionService.php:58` (`displayStatus`) e `PlaidWebhookService.php:26` (`match (true)`).

## Anti-padroes

- `if($x == 1){ ... }else{` e `else` em linha propria (`FuncoesviewModule.php:418,626`, `RoutinesModule.php:119`).
- `switch` novo.
- 5 ou mais `foreach` aninhados.
- `count($var_nullable)`: use `!empty`, `!is_null` ou `is_array`.
- JS: `if(Number(result?.status) == 1){` (`contratosfinanceiros/functions.js:331`).
