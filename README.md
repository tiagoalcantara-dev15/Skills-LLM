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
./install.sh                          # todas, em ~/.claude/skills
./install.sh fluxo-arquitetura        # apenas uma
./install.sh --project                # em ./.claude/skills (so no projeto atual)
./install.sh --dest ~/.codex/skills   # outro agente
./install.sh --wiki                   # clona/atualiza a wiki usada por fluxo-wiki (~/fluxo.wiki)
```

Sem clonar:

```bash
curl -fsSL https://raw.githubusercontent.com/tiagoalcantara-dev15/Skills-LLM/main/install.sh | bash
```

### Claude Code (plugin)

```
/plugin marketplace add tiagoalcantara-dev15/Skills-LLM
/plugin install skills-llm@skills-llm
```

### Manual

Copie a pasta inteira `skills/<nome>/` (nao so o `SKILL.md`) para o diretorio de skills do agente.

## Configuracao no repo Fluxo

1. **Wiki:** clone ou copie a wiki do Fluxo e informe o caminho com a variavel `FLUXO_WIKI` (padrao: `~/fluxo.wiki`). Sem a wiki, a `fluxo-wiki` avisa que esta indisponivel e o agente segue so com o codigo.
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
