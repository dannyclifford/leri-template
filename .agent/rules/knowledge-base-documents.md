---
trigger: always_on
description: Mirror all Antigravity artifacts into the repository for visibility
---

# Antigravity Artifact Synchronization

## Rule

Any artifact saved anywhere under `~/.gemini/antigravity/` during the course of a conversation MUST be synced to `.brain/` in this repository.

## Sync Locations

| Source (`~/.gemini/antigravity/`) | Destination (`.brain/`) | Sync Mode |
|----------------------------------|------------------------|-----------|
| `brain/<conversation>/*.md` | `conversations/<timestamp>/` | Per-conversation (timestamp = dir birth time) |
| `knowledge/` | `knowledge/` | Full mirror (rsync) |
| `browser_recordings/` | `browser_recordings/` | Full mirror |
| `playground/` | `playground/` | Full mirror |

### Excluded from sync
- `.DS_Store`, `.metadata.json`, `.resolved`, `*.pb`, `*.lock` files
- `user_settings.pb`, `mcp_config.json`, `onboarding.json`
- `code_tracker/`, `context_state/`, `implicit/`, `annotations/`

## Required Actions

1. **After creating or updating any artifact** (task.md, implementation_plan.md, walkthrough.md, knowledge items, etc.):
   - Run the sync script with your Conversation ID:
     ```bash
     ./scripts/sync-brain.sh <YOUR_CONVERSATION_ID>
     ```
   - Find your ID in the "Artifact Directory Path" or your brain path (`~/.gemini/antigravity/brain/<UUID>`)
   - Only `.md` files are copied from conversations (not `.metadata.json` or `.resolved` variants)

2. **Check sync at conversation end**:
   - Before finishing work, verify `.brain/` contains the current conversation folder

3. **Maintain .gitignore**:
   - Ensure `.brain/` is in `.gitignore` (user wants local visibility, not git commits)

## Why

This allows the user to:
- See what the agent is planning/doing without navigating hidden `~/.gemini/` directories
- Review artifacts, knowledge items, and recordings in their IDE
- Maintain a complete local mirror showing full agent history

## Consolidated Knowledge vs. Raw Sync

- **Raw Sync**: The `sync-brain.sh` script mirrors conversation artifacts and knowledge items to `.brain/`
- **Consolidated Knowledge**: When running the `/sleep` workflow, write specific findings (`patterns.md`, `errors.md`, `insights.md`) **DIRECTLY** to `.brain/consolidated/` in the repository. Do not write these to your agent brain first.

## Commands

```bash
# Sync a specific conversation (PREFERRED - always pass your Conversation ID)
./scripts/sync-brain.sh <YOUR_CONVERSATION_ID>

# Sync all conversations + knowledge + recordings
./scripts/sync-brain.sh --all

# Sync only conversations (all or most recent)
./scripts/sync-brain.sh --conversations [CONVERSATION_ID]

# Sync only knowledge items
./scripts/sync-brain.sh --knowledge

# Sync only browser recordings
./scripts/sync-brain.sh --recordings
```

Anything related to the repository in the ~/.gemini/antigravity/* should be here, if it's not, then sync it. This includes knowledge items, conversation artifacts, browser recordings, playground experiments, and any other generated content. ALL synced to the repository but ONLY the ones related to this particular repository, not all projects in the folder.