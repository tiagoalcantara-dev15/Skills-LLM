#!/usr/bin/env bash
# Instala as skills deste repositorio no diretorio de skills de um agente.
#
# Uso:
#   ./install.sh                         # todas as skills em ./.claude/skills
#   ./install.sh --project               # igual ao padrao (./.claude/skills)
#   ./install.sh --dest <dir>            # destino customizado (ex: ~/.codex/skills)
#   ./install.sh <skill> [<skill> ...]   # apenas as skills indicadas
#   ./install.sh --wiki                  # clona/atualiza a wiki do Fluxo (~/fluxo.wiki ou $FLUXO_WIKI)
#
# Sem clonar antes:
#   curl -fsSL https://raw.githubusercontent.com/tiagoalcantara-dev15/Skills-LLM/main/install.sh | bash

set -euo pipefail

REPO_URL="https://github.com/tiagoalcantara-dev15/Skills-LLM.git"
DEST="$(pwd)/.claude/skills"
WIKI_URL="https://github.com/allstrategy-git/fluxo.wiki.git"
WIKI_DIR="${FLUXO_WIKI:-${HOME}/fluxo.wiki}"
WIKI_ONLY=0
SKILLS=()

while [ $# -gt 0 ]; do
  case "$1" in
    --project) DEST="$(pwd)/.claude/skills" ;;
    --dest) DEST="${2:?--dest requer um diretorio}"; shift ;;
    --wiki) WIKI_ONLY=1 ;;
    -h|--help) sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) SKILLS+=("$1") ;;
  esac
  shift
done

if [ "$WIKI_ONLY" -eq 1 ]; then
  if [ -d "$WIKI_DIR/.git" ]; then
    git -C "$WIKI_DIR" pull --ff-only --quiet
    echo "Wiki atualizada: $WIKI_DIR"
  elif [ -e "$WIKI_DIR" ]; then
    echo "$WIKI_DIR existe e nao e um clone git; nada foi alterado." >&2
    exit 1
  else
    git clone --quiet "$WIKI_URL" "$WIKI_DIR"
    echo "Wiki clonada: $WIKI_DIR"
  fi
  exit 0
fi

SRC="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [ -z "$SRC" ] || [ ! -d "$SRC/skills" ]; then
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  git clone --depth 1 --quiet "$REPO_URL" "$TMP/repo"
  SRC="$TMP/repo"
fi

if [ ${#SKILLS[@]} -eq 0 ]; then
  for d in "$SRC"/skills/*/; do SKILLS+=("$(basename "$d")"); done
fi

mkdir -p "$DEST"
for s in "${SKILLS[@]}"; do
  if [ ! -f "$SRC/skills/$s/SKILL.md" ]; then
    echo "Skill nao encontrada: $s" >&2
    exit 1
  fi
  rm -rf "${DEST:?}/$s"
  cp -R "$SRC/skills/$s" "$DEST/$s"
  echo "Instalada: $s -> $DEST/$s"
done
