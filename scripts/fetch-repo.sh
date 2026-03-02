#!/bin/bash
# Fetch external repos for AI-searchable reference
# Usage: ./scripts/fetch-repo.sh <org/repo> <local-name> [branch]

set -e

REPO="$1"
NAME="$2"
BRANCH="${3:-main}"
REF_DIR="$(dirname "$0")/../.ref"

if [ -z "$REPO" ] || [ -z "$NAME" ]; then
  echo "Usage: $0 <org/repo> <local-name> [branch]"
  echo "Example: $0 vercel/ai ai-sdk main"
  exit 1
fi

TARGET="$REF_DIR/$NAME"

# Create .reference if needed
mkdir -p "$REF_DIR"

if [ -d "$TARGET" ]; then
  echo "📦 Updating $NAME..."
  cd "$TARGET"
  git fetch origin "$BRANCH" --depth=1
  git reset --hard "origin/$BRANCH"
else
  echo "📥 Cloning $REPO to $NAME..."
  git clone --depth=1 --branch "$BRANCH" "https://github.com/$REPO.git" "$TARGET" 2>/dev/null || \
  git clone --depth=1 "https://github.com/$REPO.git" "$TARGET"
fi

# Stats
FILE_COUNT=$(find "$TARGET" -type f | wc -l | tr -d ' ')
SIZE=$(du -sh "$TARGET" | cut -f1)

echo "✅ $NAME ready: $FILE_COUNT files, $SIZE"
