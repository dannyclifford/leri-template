#!/bin/bash
# Sync agent brain artifacts to repository for visibility
# Supports: conversations, knowledge, browser recordings, playground

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."
AG_SOURCE="$HOME/.gemini/antigravity"
BRAIN_DEST="$REPO_ROOT/.brain"

# Rsync exclude patterns for all sync modes
RSYNC_EXCLUDES=(
  --exclude='.DS_Store'
  --exclude='*.metadata.json'
  --exclude='*.resolved'
  --exclude='*.pb'
  --exclude='*.lock'
  --exclude='user_settings.pb'
  --exclude='mcp_config.json'
  --exclude='onboarding.json'
)

usage() {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  <CONVERSATION_ID>           Sync a specific conversation + knowledge"
  echo "  --all                       Sync everything (conversations + knowledge + recordings)"
  echo "  --conversations [ID]        Sync conversations only (optionally a specific ID)"
  echo "  --knowledge                 Sync knowledge items only"
  echo "  --recordings                Sync browser recordings only"
  echo "  --playground                Sync playground experiments only"
  echo "  (no argument)               Sync most recent conversation + knowledge"
  exit 1
}

# ─── Conversation sync ──────────────────────────────────────────────
sync_conversation() {
  local conv_id="$1"
  local source_dir="$AG_SOURCE/brain/$conv_id"

  if [ ! -d "$source_dir" ]; then
    echo "❌ Brain directory not found: $source_dir"
    return 1
  fi

  # Get creation time of the source directory for stable folder naming
  local creation_sec
  creation_sec=$(stat -f "%B" "$source_dir")

  # Format as YYYY-MM-DD-HH-MM-SS-GMT
  local folder_name
  folder_name=$(date -u -r "$creation_sec" "+%Y-%m-%d-%H-%M-%S-GMT")

  local dest_dir="$BRAIN_DEST/conversations/$folder_name"
  mkdir -p "$dest_dir"

  # Sync all .md files (excluding metadata/resolved variants)
  local synced_count=0

  for file in "$source_dir"/*.md; do
    if [ -f "$file" ]; then
      local basename
      basename=$(basename "$file")
      if [[ "$basename" != *.metadata.* ]] && [[ "$basename" != *.resolved* ]]; then
        cp "$file" "$dest_dir/$basename"
        synced_count=$((synced_count + 1))
      fi
    fi
  done

  echo "✅ Synced $synced_count artifacts from $conv_id → conversations/$folder_name"
  return 0
}

sync_all_conversations() {
  echo "📂 Syncing ALL conversations..."
  local count=0
  for dir in "$AG_SOURCE/brain"/*; do
    if [ -d "$dir" ]; then
      local conv_id
      conv_id=$(basename "$dir")
      # Skip non-UUID directories (e.g. tempmediaStorage)
      if [[ "$conv_id" =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]]; then
        if sync_conversation "$conv_id"; then
          count=$((count + 1))
        fi
      fi
    fi
  done
  echo "   ✅ Synced $count conversations total."
}

sync_most_recent_conversation() {
  # Find most recently modified brain directory (UUID only)
  local last_id
  last_id=$(ls -t "$AG_SOURCE/brain" 2>/dev/null | grep -E '^[0-9a-f]{8}-' | head -1)

  if [ -z "$last_id" ]; then
    echo "❌ No brain directories found in $AG_SOURCE/brain"
    return 1
  fi

  sync_conversation "$last_id"
}

# ─── Knowledge sync ─────────────────────────────────────────────────
sync_knowledge() {
  local source="$AG_SOURCE/knowledge"
  local dest="$BRAIN_DEST/knowledge"

  if [ ! -d "$source" ]; then
    echo "⚠️  No knowledge directory found at $source"
    return 0
  fi

  mkdir -p "$dest"
  rsync -a --delete "${RSYNC_EXCLUDES[@]}" "$source/" "$dest/"

  local topic_count
  topic_count=$(find "$dest" -maxdepth 1 -type d | tail -n +2 | wc -l | tr -d ' ')
  echo "✅ Synced knowledge ($topic_count topics) → knowledge/"
}

# ─── Browser recordings sync ────────────────────────────────────────
sync_recordings() {
  local source="$AG_SOURCE/browser_recordings"
  local dest="$BRAIN_DEST/browser_recordings"

  if [ ! -d "$source" ]; then
    echo "⚠️  No browser_recordings directory found at $source"
    return 0
  fi

  mkdir -p "$dest"
  rsync -a --delete "${RSYNC_EXCLUDES[@]}" "$source/" "$dest/"

  local file_count
  file_count=$(find "$dest" -type f | wc -l | tr -d ' ')
  echo "✅ Synced browser recordings ($file_count files) → browser_recordings/"
}

# ─── Playground sync ────────────────────────────────────────────────
sync_playground() {
  local source="$AG_SOURCE/playground"
  local dest="$BRAIN_DEST/playground"

  if [ ! -d "$source" ]; then
    echo "⚠️  No playground directory found at $source"
    return 0
  fi

  mkdir -p "$dest"
  rsync -a --delete "${RSYNC_EXCLUDES[@]}" "$source/" "$dest/"

  local file_count
  file_count=$(find "$dest" -type f | wc -l | tr -d ' ')
  echo "✅ Synced playground ($file_count files) → playground/"
}

# ─── Main execution ─────────────────────────────────────────────────
echo "🧠 Antigravity Sync"
echo "   Source: $AG_SOURCE"
echo "   Dest:   $BRAIN_DEST"
echo ""

case "${1:-}" in
  --all)
    sync_all_conversations
    sync_knowledge
    sync_recordings
    sync_playground
    echo ""
    echo "🎉 Full sync complete."
    ;;
  --conversations)
    if [ -n "${2:-}" ]; then
      sync_conversation "$2"
    else
      sync_all_conversations
    fi
    ;;
  --knowledge)
    sync_knowledge
    ;;
  --recordings)
    sync_recordings
    ;;
  --playground)
    sync_playground
    ;;
  --help|-h)
    usage
    ;;
  "")
    # Default: most recent conversation + knowledge
    sync_most_recent_conversation
    sync_knowledge
    ;;
  *)
    # Assume it's a conversation ID — sync that conversation + knowledge
    sync_conversation "$1"
    sync_knowledge
    ;;
esac
