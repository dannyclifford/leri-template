---
description: Run brain sleep to consolidate conversation memories and extract learnings
---

# Brain Sleep Workflow

Consolidate the last 24 hours of conversation history into organized learnings.

## Steps

### 1. Sync & List Recent Conversations
// turbo
```bash
./scripts/sync-brain.sh --all && echo "" && echo "=== Last 24 Hours (Non-Empty) ===" && find .brain/conversations -maxdepth 1 -type d -name "*-GMT" -mtime -1 | while read dir; do count=$(ls "$dir"/*.md 2>/dev/null | wc -l | tr -d ' '); if [ "$count" -gt "0" ]; then echo "$(basename $dir) ($count files)"; fi; done
```

### 2. Review Each Conversation

Read through the task.md and walkthrough.md files from each folder listed above. Extract:
- **Patterns**: Recurring approaches or solutions
- **Errors**: Problems encountered with root causes and fixes
- **Insights**: Key learnings or discoveries

### 3. Document in Consolidated Files

Add findings directly to the **repository** (not the agent brain):
- `.brain/consolidated/patterns.md`
- `.brain/consolidated/errors.md`
- `.brain/consolidated/insights.md`

Use format:
```markdown
## YYYY-MM-DD

### [Title]
[Description]
**Source**: [folder name]
```

### 4. Update Sleep Log
// turbo
```bash
echo '{"lastSleepAt": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'", "conversationsProcessed": '$(find .brain/conversations -maxdepth 1 -type d -name "*-GMT" -mtime -1 | wc -l | tr -d ' ')'}' > .brain/sleep_log.json
```
