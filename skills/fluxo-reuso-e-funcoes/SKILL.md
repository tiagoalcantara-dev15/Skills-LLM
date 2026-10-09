---
name: fluxo-reuso-e-funcoes
description: Obriga a reutilizar codigo existente no repo Fluxo antes de escrever codigo novo e limita a criacao de funcoes pequenas. Use ANTES de criar qualquer function, metodo, helper, componente ou trecho de logica, e ao decidir se extrai um bloco para uma nova function ou mantem na function principal.
---

# Fluxo - Reuso e funcoes

Use esta skill antes de escrever logica nova. Objetivo: reaproveitar o que ja existe com pequenas modificacoes, e manter o codigo legivel numa function principal em vez de espalhar micro-functions.

## 1. Procure antes de criar

Se a logica depende de regra de negocio, consulte antes a skill `fluxo-wiki` (a wiki tambem documenta functions e services do modulo).

Comece pelo catalogo [references/catalogo-reuso.md](references/catalogo-reuso.md) (helpers, services, componentes JS e contrato Module -> UI). Para AJAX, toast, confirmacao, formatacao de data/numero, banco e log ja existe helper: use-o.

Antes de escrever uma function, metodo ou componente:

1. Busque no repo por nome, por palavras-chave do dominio e por comportamento parecido (Grep em PHP, JS, React e Blade).
2. Verifique helpers globais, services e componentes compartilhados.
3. Verifique se outra tela ja faz algo equivalente.

Ao encontrar algo parecido, nesta ordem de preferencia:

1. **Usar como esta.**
2. **Adaptar com pequena modificacao**: novo parametro opcional com valor padrao que preserva o comportamento atual, ou nova opcao de configuracao.
3. **Generalizar** o codigo existente, desde que todos os chamadores atuais continuem funcionando. Confira os chamadores antes (Grep).
4. **Criar novo** somente se nenhuma opcao acima servir.

Ao adaptar uma function existente, nao mude o comportamento para quem ja a usa.

Ao final, diga ao usuario o que foi reutilizado e o que foi criado, com o motivo.

## 2. Evite micro-functions

- Nao crie function com ate 8 linhas de codigo apenas para "organizar". Deixe o codigo na function principal, na ordem em que e executado, para a leitura ser linear.
- Extraia para uma function propria somente quando:
  - o bloco e usado em 2 ou mais lugares, ou
  - o bloco tem mais de 8 linhas e representa uma responsabilidade clara, ou
  - o framework exige (callback, handler, metodo de interface).
- **Excecoes** (pode extrair mesmo com ate 8 linhas): a function da nome a uma regra de negocio; encapsula SQL repetido; faz parte de uma familia despachada por `match` (ex.: `PlaidWebhookService.php:164-190`).
- Alvo de tamanho: 10 a 30 linhas por metodo publico em Service. Mediana atual em Services e 11. Acima disso, extraia blocos com responsabilidade clara, nunca fatias arbitrarias.
- Anti-exemplos reais: `FiltrosModule.php:1646,1650` (`count_analiticos`, `count_registros`), `BookmarksModule.php:63,69` (`nextPosition`/`nextPositionShared` com SQL quase identico), `rangeSlider/functions.js:204` (`scheduleBandStopsSync`).
- Se a function principal ficou longa, separe por blocos com comentario curto de intencao antes de pensar em extrair.
- Nao crie wrapper que apenas repassa chamada para outra function.

### Exemplo

Evite:

```php
private function getNome($dados) { return trim($dados['nome']); }
private function getEmail($dados) { return strtolower($dados['email']); }

public function salvar($dados) {
    $nome = $this->getNome($dados);
    $email = $this->getEmail($dados);
}
```

Prefira:

```php
public function salvar($dados) {
    $nome = trim($dados['nome']);
    $email = strtolower($dados['email']);
}
```

## Checklist final

- Busquei por codigo existente antes de criar?
- Reaproveitei ou adaptei em vez de duplicar?
- Os chamadores existentes continuam funcionando?
- Alguma function nova tem 8 linhas ou menos e so e usada uma vez? Se sim, inline na principal.
- Informei o que foi reutilizado e o que foi criado?
