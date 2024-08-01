#!/bin/bash

set -euo pipefail

# Function to resolve real paths using readlink
resolve_path() {
  local path="$1"
  cd "$(dirname "$path")"
  echo "$(pwd -P)/$(basename "$path")"
}

SCRIPT_DIR="$(resolve_path "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_DIR")"
ROOT_DIR="$(resolve_path "${SCRIPT_DIR}/..")"

. "$SCRIPT_DIR/_common.sh"

run "$ROOT_DIR" --build -P -v "$ROOT_DIR:/www" localhost-firebolt-docs
