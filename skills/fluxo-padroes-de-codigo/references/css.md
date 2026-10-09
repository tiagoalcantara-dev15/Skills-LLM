# Classes e estilos CSS

## Regras

- Estilo novo vai em `resources/css/Modules/{recurso}/[{acao}/]style.css`, em CSS puro. Componente transversal vai em `resources/css/components/` com `@import` em `components/style.css`. (Ver `fluxo-arquitetura`.)
- Classes novas **sempre em kebab-case** e ingles, sem excecao (nao use camelCase com prefixo de modulo, como `bcDocumentoModal`). BEM so quando ja existir no bloco (`cash-flow-alert-bar__left`, `--with-button`).
- Cor e espacamento por variavel: `var(--prophix-*)` (tema novo). `var(--allstrategy-*)` e legado: nao crie cor nova nele.
- O CSS novo precisa funcionar nos dois temas de variaveis (`variables.css` e `variables-prophix.css`, trocados por `APP_VERSION_PROPHIX`).
- Evite hex literal, `style=""`, `<style>` em Blade e `!important`.
- Breakpoints: `@media` com `max-width`; nao ha valores padronizados, reuse os do arquivo e nao invente um novo.

## Stack

Bootstrap **4.6.2** vendorizado (`css/theme-pages/bootstrap.css`), DevExtreme 23.2.5 e jQuery. O `package.json` declara Bootstrap 5 e assim permanece, mas a UI renderiza com o v4 vendorizado: use as classes v4 (`mr-2`, `ml-2`, `data-toggle`), nao as v5 (`me-*`, `ms-*`, `data-bs-toggle`).

Design system vivo em `/design-system` (`DesignSystemController`, `views/designSystem/{buttons,colors,forms,tables,modal,toast-message}`). Consulte antes de criar componente visual.

## Classes a reutilizar

| Classe | Papel |
|--------|-------|
| `form-group-default` + `campo-input` | wrapper de campo |
| `btn btn-prophix-dimensions` | botao 36px |
| `btn-primary`, `btn-default` | botoes |
| `btn-danger`, `btn-tertiary`, `btn-danger-secondary` | `components/action-buttons.css` |
| `btn-prophix-small`, `btn-prophix-icon`, `text-link` | `style.css` |

## Exemplo real

```html
<div class="cash-flow-alert-bar {{ $isAdmin ? 'cash-flow-alert-bar--with-button' : '' }}" id="cashFlowAlertBar">
  <div class="cash-flow-alert-bar__left">...
  <button class="btn btn-prophix-dimensions btn-danger" ...>
```

SCSS: `sass/components/FinancialOperations/debtDashboard/card.scss` (`.debt-dashboard-card { ... var(--font-size-input); var(--prophix-neutral-600) }`).

## Anti-padroes (nao copiar)

- snake_case e prefixo `all_*` (`bloco_novo_cenario`).
- `.dx-*` sobrescrito com `!important`.
- Seletor com especificidade inflada (`.tabela-regras-classificacao` repetido 3 vezes).
- Cor nova em `--allstrategy-*`.
- Arquivo monolitico (`fluxodecaixa/style.css` 2473 linhas, `financialplanning/style.css` 2168).
