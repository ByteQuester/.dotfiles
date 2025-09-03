#!/usr/bin/env bash
set -euo pipefail

# Delegate to the modular installer to ensure consistent behavior
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/install/install.sh" "$@"

