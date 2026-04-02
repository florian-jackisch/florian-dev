#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 [--replace] <source-repo|git-url|local-dir> <plugin-path> <plugin-name> [repo-root]" >&2
  exit 1
}

replace=0
if [[ ${1:-} == "--replace" ]]; then
  replace=1
  shift
fi

[[ $# -ge 3 && $# -le 4 ]] || usage

source_spec=$1
plugin_path=$2
plugin_name=$3
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
default_repo_root="$(cd -- "$script_dir/../../../.." && pwd)"
repo_root=${4:-$default_repo_root}

if [[ ! "$plugin_name" =~ ^[a-z0-9-]+$ ]]; then
  echo "Plugin name must be lowercase-kebab-case: $plugin_name" >&2
  exit 1
fi

if [[ ! -d "$repo_root" ]]; then
  echo "Repository root does not exist: $repo_root" >&2
  exit 1
fi

if [[ ! -f "$repo_root/plugin.json" ]]; then
  echo "Expected plugin.json in repository root: $repo_root" >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
cleanup() {
  rm -rf "$tmpdir"
}
trap cleanup EXIT

source_root=
if [[ -d "$source_spec" ]]; then
  source_root="$(cd -- "$source_spec" && pwd)"
else
  clone_url=$source_spec
  if [[ "$source_spec" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]]; then
    clone_url="https://github.com/$source_spec.git"
  fi

  source_root="$tmpdir/source"
  git clone --depth 1 "$clone_url" "$source_root" >/dev/null 2>&1
fi

source_dir="$source_root/$plugin_path"
if [[ ! -d "$source_dir" ]]; then
  echo "Plugin path does not exist in source: $plugin_path" >&2
  exit 1
fi

target_dir="$repo_root/plugins/$plugin_name"
if [[ -e "$target_dir" ]]; then
  if [[ $replace -eq 1 ]]; then
    rm -rf "$target_dir"
  else
    echo "Target already exists: $target_dir" >&2
    echo "Use --replace to overwrite the existing vendored plugin." >&2
    exit 1
  fi
fi

mkdir -p "$target_dir/.claude-plugin"

copied=0

copy_if_exists() {
  local src=$1
  local dest=$2
  if [[ -e "$src" ]]; then
    mkdir -p "$(dirname -- "$dest")"
    cp -R "$src" "$dest"
    copied=1
  fi
}

copy_if_exists "$source_dir/.claude-plugin/plugin.json" "$target_dir/.claude-plugin/plugin.json"
copy_if_exists "$source_dir/.mcp.json" "$target_dir/.mcp.json"
copy_if_exists "$source_dir/skills" "$target_dir/skills"
copy_if_exists "$source_dir/commands" "$target_dir/commands"

if [[ -d "$source_dir/agents" ]]; then
  mkdir -p "$target_dir/agents"
  shopt -s nullglob
  for src in "$source_dir/agents"/*.md; do
    base=$(basename -- "$src")
    if [[ "$base" == *.agent.md ]]; then
      dest="$target_dir/agents/$base"
    else
      stem=${base%.md}
      dest="$target_dir/agents/$stem.agent.md"
    fi
    cp "$src" "$dest"
    copied=1
  done
  shopt -u nullglob
fi

if [[ $copied -eq 0 ]]; then
  echo "No supported plugin files were copied from: $source_dir" >&2
  exit 1
fi

manifest_path="$target_dir/.claude-plugin/plugin.json"
if [[ -f "$manifest_path" ]]; then
  node - "$manifest_path" "$target_dir" <<'EOF'
const fs = require("fs");
const manifestPath = process.argv[2];
const targetDir = process.argv[3];
const manifest = JSON.parse(fs.readFileSync(manifestPath, "utf8"));

const hasDir = (name) => fs.existsSync(`${targetDir}/${name}`);
const hasFile = (name) => fs.existsSync(`${targetDir}/${name}`);

if (hasDir("skills")) {
  manifest.skills = "skills/";
}
if (hasDir("agents")) {
  manifest.agents = "agents/";
}
if (hasDir("commands")) {
  manifest.commands = "commands/";
}
if (hasFile(".mcp.json")) {
  manifest.mcpServers = ".mcp.json";
}

fs.writeFileSync(manifestPath, `${JSON.stringify(manifest, null, 2)}\n`);
EOF
fi

echo "Vendored plugin payload '$plugin_name' from '$source_spec:$plugin_path' into '$target_dir'."
echo "Next: merge any vendored MCP config into the root .mcp.json and wire vendored skills, agents, and commands through plugin.json."
