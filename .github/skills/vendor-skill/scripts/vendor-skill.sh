#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 [--replace] <package> <skill-name> [repo-root]" >&2
  exit 1
}

replace=0
if [[ ${1:-} == "--replace" ]]; then
  replace=1
  shift
fi

[[ $# -ge 2 && $# -le 3 ]] || usage

package=$1
skill_name=$2
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
default_repo_root="$(cd -- "$script_dir/../../../.." && pwd)"
repo_root=${3:-$default_repo_root}

if [[ ! -d "$repo_root" ]]; then
  echo "Repository root does not exist: $repo_root" >&2
  exit 1
fi

if [[ ! -f "$repo_root/plugin.json" ]]; then
  echo "Expected plugin.json in repository root: $repo_root" >&2
  exit 1
fi

target_dir="$repo_root/skills/$skill_name"
tmpdir="$(mktemp -d)"
cleanup() {
  rm -rf "$tmpdir"
}
trap cleanup EXIT

mkdir -p "$repo_root/skills"

if [[ -e "$target_dir" ]]; then
  if [[ $replace -eq 1 ]]; then
    rm -rf "$target_dir"
  else
    echo "Target already exists: $target_dir" >&2
    echo "Use --replace to overwrite the existing vendored skill." >&2
    exit 1
  fi
fi

(
  cd "$tmpdir"
  npx --yes skills add "$package" --skill "$skill_name" --agent github-copilot --copy -y
)

installed_dir="$tmpdir/.agents/skills/$skill_name"
if [[ ! -d "$installed_dir" ]]; then
  echo "Installed skill not found at: $installed_dir" >&2
  exit 1
fi

cp -R "$installed_dir" "$target_dir"

echo "Vendored skill '$skill_name' from '$package' into '$target_dir'."
echo "Review the copied files before committing."
echo "Reinstall the plugin with /plugin install florian-jackisch/flow after review."
echo "If Copilot CLI does not pick up the new skill on the next turn, run /restart."
