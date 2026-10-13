---
name: fluxo-planejamento
description: Roteiro de spec, plano e execucao para feature, tela, endpoint ou ajuste de regra no repo Fluxo, ancorado na wiki e nas skills fluxo-*. Use ao iniciar mudanca que exige entender o modulo, desenhar a solucao ou delegar a subagentes. Funciona sozinho ou com superpowers.
---

# Fluxo - Planejamento

Para mudanca trivial use o **caminho curto** abaixo. Para o resto, roteiro em 3 fases: **spec**, **plano** e **execucao**. Serve com qualquer ferramenta de planejamento (plan mode do Claude Code, conversa direta, superpowers ou outra). Esta skill so diz o que acrescentar para spec, plano e execucao respeitarem as skills `fluxo-*`.

Se voce usa o superpowers: spec = `brainstorming`, plano = `writing-plans`, execucao = `subagent-driven-development` (ou `executing-plans`). O conteudo abaixo e o mesmo; ele complementa essas skills, nao as substitui.

## Caminho curto (mudanca trivial)

Pule spec e plano formais quando a mudanca for pequena e localizada: ajuste de texto ou traducao, correcao de bug em 1 ou 2 arquivos existentes, ajuste de CSS, renomeacao local. Vale so se **todas** as condicoes forem verdadeiras:

- nao cria arquivo, tela, endpoint, migration nem registro (permissao, menu, bind);
- nao altera regra de negocio, calculo, permissao nem contrato de API;
- o efeito e facil de ver e de reverter.

Nesse caso:

1. Leia o arquivo e o irmao mais proximo do codigo novo.
2. Aplique os temas de `fluxo-padroes-de-codigo` que a mudanca toca (i18n, ifs, CSS etc.) e `fluxo-reuso-e-funcoes` se escrever logica nova.
3. Rode o que a mudanca exige (build do Vite se mexeu em JS/CSS, teste afetado).
4. Resuma em 2 ou 3 linhas o que mudou e o que foi reutilizado.

Se surgir qualquer duvida de regra de negocio, ou a mudanca crescer alem das condicoes acima, volte ao roteiro completo (fases 1 a 4). Na duvida, use o roteiro completo.

## 1. Spec

- Antes de propor abordagens, use `fluxo-wiki` para achar o modulo e ler as regras de negocio e tecnicas dele.
- Registre uma secao **Contexto Fluxo**: modulo afetado, paginas da wiki consultadas (caminho) e as regras aplicaveis em 1 linha cada.
- Lacunas da wiki e divergencias entre wiki e codigo viram **perguntas abertas** para o usuario. Nao suponha a regra.
- Se a wiki estiver indisponivel, diga isso na spec.

## 2. Plano

O cabecalho do plano repete o **Contexto Fluxo**, com as regras de negocio ja resumidas, para quem executar nao precisar reler a wiki.

Cada tarefa do plano traz:

- **Arquivos exatos** (criar e alterar), com local e nome conforme `fluxo-arquitetura`. Inclua JS e CSS de tela, `lang.php`/JSONs de idioma e testes.
- **Registros obrigatorios** quando houver tela ou endpoint novo: permissao, titulo, menu, bind do Repository, `mount.js`, `@import`.
- **Reuso:** o que sera reaproveitado ou adaptado (caminho da function/helper, ver `fluxo-reuso-e-funcoes`) e o que sera criado, com o motivo. Faca a busca no codigo ao planejar; nao a deixe para quem executa.
- **Padroes:** os temas de `fluxo-padroes-de-codigo` que a tarefa toca (i18n, functions, ifs, CSS, comentarios, nomenclatura).
- **Teste:** local e tipo (Unit, Feature mockado), conforme `fluxo-arquitetura`.
- Etapa final de **verificacao**: build do Vite se houver JS/CSS e `npm test`.

## 3. Execucao

**Sozinho (sem subagentes):** antes de cada tarefa, aplique `fluxo-arquitetura`, `fluxo-reuso-e-funcoes` e os temas de `fluxo-padroes-de-codigo` listados no plano.

**Com subagentes:** eles comecam sem contexto e nao herdam o que o agente principal leu. O prompt de **cada** subagente (implementador e revisores) deve incluir:

1. O texto da tarefa e o **Contexto Fluxo** do plano.
2. A instrucao: "Use as skills `fluxo-arquitetura`, `fluxo-reuso-e-funcoes` e `fluxo-padroes-de-codigo` (temas: ...)".
3. Os caminhos exatos de arquivos e os candidatos de reuso do plano.
4. Regras criticas inline, caso a skill nao carregue: kebab-case em CSS, nada de SQL interpolado, texto visivel com `__()`/`LangFluxo.get()`, nao copiar de `Model_*`/`AllStrategy_*`/`allstrategy-legacy/`.

Revisores conferem o resultado contra a spec, o Contexto Fluxo, o checklist final de cada skill `fluxo-*` tocada e se algum arquivo ficou fora do local indicado no plano. Se um subagente encontrar divergencia entre wiki e codigo, ele reporta ao agente principal em vez de decidir.

## 4. Fechamento

Antes de declarar pronto: build e testes rodaram, registros de tela/endpoint foram feitos, e a lista "reutilizado / adaptado / criado" foi entregue ao usuario. Se a mudanca alterou uma regra documentada, avise qual pagina da wiki precisa de atualizacao (nao edite a wiki sem pedido).
