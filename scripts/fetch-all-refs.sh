#!/bin/bash
# Fetch the small reference set that matches Leri Template's bundled UI.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🔄 Fetching core references..."

"$SCRIPT_DIR/fetch-repo.sh" "vercel/ai-elements" "ai-elements" "main"
"$SCRIPT_DIR/fetch-repo.sh" "shadcn-ui/ui" "shadcn-ui" "main"

date -u +%Y-%m-%dT%H:%M:%SZ > "$SCRIPT_DIR/../.ref/.last_refreshed"
echo "✅ Core references ready. Fetch other sources individually when needed."
