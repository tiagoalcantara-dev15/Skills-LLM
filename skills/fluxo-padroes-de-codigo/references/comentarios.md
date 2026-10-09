# Comentarios

## Regras

- Comente o **porque** (invariante, limitacao, ordem, motivo de decisao), nao o que o codigo ja diz.
- Use `//` de linha. Evite `/* */`, `TODO` e codigo comentado.
- Docblock `/** */` em Services e Controllers da API, com `@param`/`@return`/`@throws` e descricao real, sem repetir o nome.
- Idioma: **ingles** em `Services/Api` e `Controllers/Api`; **portugues** em Modules e logica de negocio. Fora disso, siga o idioma do arquivo.
- JS: JSDoc `@param {tipo} nome - descricao` em funcao publica de componente; `//` para o motivo. Separador de secao no estilo `// --- Population helpers ---`.
- Testes: docblock de classe bilingue `EN — ... PT — ...`.
- Se precisar de TODO, inclua dono ou contexto, nunca so `TODO` em maiusculas.

## Bons exemplos

- `Services/PlaidWebhookService.php:59-62`: explica por que grava um log por conta.
- `Services/Api/Integration/BankStatementService.php:31-37`: explica que o `DROP` roda depois da transacao porque DDL faz commit implicito.
- `classificationrules/functions.js:19-22`: explica por que usa listener nativo com `capture=true`.

## Anti-padroes

- Docblock que so repete o nome (`@param string $hash`).
- `/**` duplicado (`ClassificationrulesModule.php` ~linha 95).
- `TODO` sem dono ou data (`functions-form.js:574,584`).
- Codigo comentado em controllers.

## Nota

Comentarios bilingues `PT || EN` existem em `contratosfinanceiros`, `modalAlert` e `tagBox`, mas nao sao padrao: nao crie novos.
