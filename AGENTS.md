# Instrucoes para agentes de IA

Este repositorio e um catalogo de skills. Cada skill e uma pasta em `skills/<nome>/` com um `SKILL.md` (frontmatter `name` + `description`, seguido das instrucoes).

## Instalar skills

Prefira o script, que copia as pastas para o diretorio de skills do agente:

```bash
git clone https://github.com/tiagoalcantara-dev15/Skills-LLM.git
cd Skills-LLM
./install.sh                       # todas, em ~/.claude/skills
./install.sh <nome-da-skill>       # apenas uma
./install.sh --project             # em ./.claude/skills (escopo do projeto)
./install.sh --dest <diretorio>    # outro agente (ex: ~/.codex/skills)
```

Sem o script: copie `skills/<nome>/` inteira (nao so o `SKILL.md`) para o diretorio de skills do seu agente.

## Descobrir skills

Liste `skills/*/SKILL.md` e leia o campo `description` de cada um para decidir qual se aplica a tarefa. O catalogo tambem esta no [README.md](README.md).

## Adicionar uma skill

1. Crie `skills/<nome-em-kebab-case>/SKILL.md` com frontmatter `name` (igual ao nome da pasta) e `description` (quando usar a skill).
2. Coloque arquivos auxiliares na mesma pasta (`references/`, `scripts/`), referenciados a partir do `SKILL.md`.
3. Adicione a skill na tabela do [README.md](README.md).
