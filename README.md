# Skills-LLM

Skills para agentes de IA (Claude Code, Codex e similares) que padronizam o codigo gerado no **Fluxo** (AllStrategy / Prophix Cash Management). Elas dizem ao agente onde criar arquivos, o que reaproveitar, como escrever o codigo e onde achar a regra de negocio, gastando poucos tokens: o agente carrega so o que a tarefa precisa.

## Como funciona

As skills formam 3 camadas:

| Camada | Skills | Papel |
|--------|--------|-------|
| 1. Padroes tecnicos | `fluxo-arquitetura`, `fluxo-reuso-e-funcoes`, `fluxo-padroes-de-codigo` | **Como** codar: local dos arquivos, reuso, estilo de escrita. |
| 2. Conhecimento | `fluxo-wiki` | **O que** e **por que**: aponta a pagina da wiki com a regra de negocio, sem carregar a wiki inteira. |
| 3. Planejamento | `fluxo-planejamento` | Roteiro de spec, plano e execucao que usa as camadas 1 e 2. Funciona sozinho ou junto do superpowers. |

## Skills disponiveis

| Skill | Quando usar |
|-------|-------------|
| [fluxo-planejamento](skills/fluxo-planejamento/SKILL.md) | Ao especificar, planejar ou executar uma mudanca: ancora a spec na wiki e o plano nas demais skills. |
| [fluxo-wiki](skills/fluxo-wiki/SKILL.md) | Ao precisar de regra de negocio ou regra tecnica: indica qual arquivo da wiki ler. |
| [fluxo-arquitetura](skills/fluxo-arquitetura/SKILL.md) | Antes de criar, mover ou renomear arquivos: onde e como criar. |
| [fluxo-reuso-e-funcoes](skills/fluxo-reuso-e-funcoes/SKILL.md) | Antes de escrever logica nova: reaproveitar codigo existente e evitar micro-functions. |
| [fluxo-padroes-de-codigo](skills/fluxo-padroes-de-codigo/SKILL.md) | Ao escrever ou revisar codigo: traducao, functions, ifs, CSS, comentarios e nomenclatura. |

## Instalacao

As skills foram pensadas para serem instaladas juntas, porque se referenciam entre si.

### Script (qualquer agente)

```bash
git clone https://github.com/tiagoalcantara-dev15/Skills-LLM.git
cd Skills-LLM
./install.sh                          # todas, em ./.claude/skills (so no projeto atual)
./install.sh fluxo-arquitetura        # apenas uma
./install.sh --project                # igual ao padrao (./.claude/skills)
./install.sh --dest ~/.codex/skills   # outro agente (global: --dest ~/.claude/skills)
./install.sh --wiki                   # clona/atualiza a wiki usada por fluxo-wiki (~/fluxo.wiki)
```

Sem clonar:

```bash
curl -fsSL https://raw.githubusercontent.com/tiagoalcantara-dev15/Skills-LLM/main/install.sh | bash
```

### Projeto no VSCode (extensao do Claude Code)

A extensao le as skills de `.claude/skills` (projeto) e `~/.claude/skills` (usuario). Para instalar so no projeto, rode o script **de dentro da pasta do projeto**, pois `--project` usa o diretorio atual:

```bash
git clone https://github.com/tiagoalcantara-dev15/Skills-LLM.git ~/Skills-LLM
cd /caminho/do/seu/projeto
~/Skills-LLM/install.sh --project                # todas as skills
~/Skills-LLM/install.sh --project fluxo-wiki     # apenas uma
```

Depois, abra uma nova conversa ou rode `Developer: Reload Window`. Digite `/` no chat para conferir se as skills `fluxo-*` aparecem. Para o time inteiro receber as skills, faca commit da pasta `.claude/skills`.

### Claude Code (plugin)

```
/plugin marketplace add tiagoalcantara-dev15/Skills-LLM
/plugin install skills-llm@skills-llm
```

### Manual

Copie a pasta inteira `skills/<nome>/` (nao so o `SKILL.md`) para o diretorio de skills do agente.

## Para agentes de IA (usuario passou so o link do repositorio)

Se voce e um agente e o usuario so informou este repositorio (ex: "instale as skills de https://github.com/tiagoalcantara-dev15/Skills-LLM"), siga estes passos sem pedir mais contexto:

1. **Clone** em um diretorio temporario, fora do projeto do usuario:
   ```bash
   git clone --depth 1 https://github.com/tiagoalcantara-dev15/Skills-LLM.git "$(mktemp -d)/Skills-LLM"
   ```
2. **Escolha o escopo.** Se o usuario nao disse, use o projeto atual (padrao do script), que cria `./.claude/skills` no diretorio onde voce esta trabalhando. Use o escopo de usuario (`--dest ~/.claude/skills`) apenas se ele pedir "para todos os projetos".
3. **Instale** rodando o script a partir da raiz do projeto do usuario (`--project` usa o diretorio atual):
   ```bash
   cd <raiz-do-projeto-do-usuario>
   <clone>/install.sh --project            # todas as skills (recomendado: elas se referenciam)
   <clone>/install.sh --project fluxo-wiki # apenas uma, se o usuario pedir
   ```
   Para outro agente (ex: Codex), use `--dest <diretorio-de-skills-do-agente>`. Sem o script, copie `skills/<nome>/` inteira (nao so o `SKILL.md`).
4. **Confira** que cada `.claude/skills/<nome>/SKILL.md` existe e informe ao usuario quais skills foram instaladas.
5. **Wiki (fluxo-wiki):** pergunte ao usuario se ele ja tem a wiki do Fluxo. Se nao, e ele tiver acesso ao repositorio, rode `<clone>/install.sh --wiki` (clona em `~/fluxo.wiki`, ou em `$FLUXO_WIKI`). Se ele ja tiver a wiki em outro lugar, peca o caminho e oriente a definir `FLUXO_WIKI`.
6. **CLAUDE.md (opcional):** ofereca copiar [templates/CLAUDE.fluxo.md](templates/CLAUDE.fluxo.md) para o `CLAUDE.md` do repo Fluxo, sem sobrescrever um arquivo existente (acrescente ao final).
7. **Avise** que a pessoa precisa abrir uma nova conversa ou recarregar a janela do VSCode para as skills aparecerem.

Nao faca commit nem altere arquivos do projeto alem de `.claude/skills/` (e do `CLAUDE.md`, se o usuario aceitar).

## Configuracao no repo Fluxo

1. **Wiki:** baixe a wiki do Fluxo (requer acesso ao repositorio `allstrategy-git`). Sem a wiki, a `fluxo-wiki` avisa que esta indisponivel e o agente segue so com o codigo.

   ```bash
   git clone https://github.com/allstrategy-git/fluxo.wiki.git ~/fluxo.wiki
   # ou, com o instalador (clona ou atualiza em ~/fluxo.wiki):
   ./install.sh --wiki
   ```

   A `fluxo-wiki` procura a wiki em `$FLUXO_WIKI` e, se a variavel nao existir, em `~/fluxo.wiki`. Se nao achar em nenhum dos dois, o Claude pergunta o caminho da wiki e usa a resposta na conversa. Para nao precisar informar toda vez, defina `export FLUXO_WIKI=/caminho/da/fluxo.wiki`. Para atualizar a wiki depois, rode `git -C ~/fluxo.wiki pull` ou `./install.sh --wiki`.
2. **CLAUDE.md:** copie [templates/CLAUDE.fluxo.md](templates/CLAUDE.fluxo.md) para o `CLAUDE.md` do repo Fluxo. Isso garante que o agente siga a `fluxo-planejamento` em toda mudanca.
3. **Superpowers (opcional):** se voce usa, o fluxo `brainstorming` -> `writing-plans` -> subagentes encaixa direto na `fluxo-planejamento`. Sem ele, o mesmo roteiro vale no plan mode ou no chat.

## Estrutura do repositorio

```
skills/
├── fluxo-planejamento/       # spec, plano e execucao
├── fluxo-wiki/               # roteador da wiki
├── fluxo-arquitetura/        # onde criar arquivos
├── fluxo-reuso-e-funcoes/    # reuso (+ references/catalogo-reuso.md)
└── fluxo-padroes-de-codigo/  # padroes (+ references/: i18n, functions, condicionais, css, comentarios, nomenclatura)
templates/CLAUDE.fluxo.md     # trecho para o CLAUDE.md do repo Fluxo
install.sh                    # instalador
AGENTS.md                     # instrucoes para agentes de IA
.claude-plugin/               # manifestos de plugin/marketplace do Claude Code
```

## Contribuindo

Para criar ou alterar uma skill, veja [AGENTS.md](AGENTS.md). Em resumo: uma pasta por skill em `skills/<nome>/` com `SKILL.md` enxuto (frontmatter `name` e `description`) e o volume em `references/`. Mantenha as `description` curtas, porque carregam em toda sessao.
