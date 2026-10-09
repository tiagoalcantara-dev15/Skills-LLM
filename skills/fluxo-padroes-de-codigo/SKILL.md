---
name: fluxo-padroes-de-codigo
description: Padroes de escrita de codigo do repo Fluxo. Use ao escrever ou revisar codigo PHP, JavaScript, React, Blade ou CSS; cobre traducao e localizacao (__(), LangFluxo.get(), datas, numeros, moeda), escrita de functions e ifs, classes CSS, comentarios e nomenclatura. Carregue so a referencia do tema envolvido.
---

# Fluxo - Padroes de codigo

Padroes de escrita do Fluxo. Leia apenas as referencias dos temas que a mudanca toca. Em caso de conflito, o padrao do arquivo que voce esta editando prevalece sobre o gosto pessoal; alinhe codigo novo ao padrao e aponte limpezas maiores separadamente.

## Referencias

| Tema | Leia quando | Arquivo |
|------|-------------|---------|
| Traducao e localizacao | Texto visivel, placeholders, labels, mensagens, datas, numeros, moeda | [references/i18n.md](references/i18n.md) |
| Functions | Escrever ou alterar function/metodo em PHP ou JS | [references/functions.md](references/functions.md) |
| Condicionais (ifs) | Escrever ou alterar if/else/switch/ternario | [references/condicionais.md](references/condicionais.md) |
| CSS | Criar ou alterar classes e estilos | [references/css.md](references/css.md) |
| Comentarios | Comentar ou documentar codigo | [references/comentarios.md](references/comentarios.md) |
| Nomenclatura | Nomear variavel, function, classe, arquivo, coluna | [references/nomenclatura.md](references/nomenclatura.md) |

## Regras que valem sempre

- Regra de negocio nao esta aqui: consulte a skill `fluxo-wiki`.
- Todo texto visivel ao usuario passa por `__()` ou `LangFluxo.get()`.
- Nunca fixe locale, formato de data ou de numero no codigo.
- Copie o estilo do arquivo irmao do **codigo novo** (nao do legado `Model_*`, `AllStrategy_*`, `allstrategy-legacy/`).
- Nunca interpole entrada do usuario em SQL; use bindings (`selectPrepared`, `queryPrepared`, Query Builder).
- Nao ha linter no repo (so `.editorconfig`: UTF-8, LF, 4 espacos, newline final). A convencao e a observada nas referencias.
- Copie o estilo do arquivo irmao mais proximo quando a referencia nao cobrir o caso.
- Antes de criar function nova, aplique `fluxo-reuso-e-funcoes`; antes de criar arquivo, `fluxo-arquitetura`.
