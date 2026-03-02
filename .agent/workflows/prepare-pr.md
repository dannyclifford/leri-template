---
description: Prepare and create a pull request with proper branch synchronization
---

# /prepare-pr - Pull Request Preparation Workflow

This workflow ensures branches are properly synchronized before creating a PR, preventing confusion about what changes will be merged.

---

## Step 1: Identify Current State

```bash
# Check current branch
git branch --show-current

# Check for uncommitted changes
git status --short
```

If there are uncommitted changes, either commit or stash them first.

---

## Step 2: Fetch Latest from Remote

// turbo
```bash
git fetch origin
```

---

## Step 3: Check Branch Divergence (CRITICAL)

```bash
# Find common ancestor with target branch (usually dev)
git merge-base dev HEAD

# See what's on dev that this branch doesn't have
git log --oneline HEAD..origin/dev
```

**If there are commits on dev that aren't on this branch, the branch is STALE.**

> [!IMPORTANT]
> A stale branch WILL still merge correctly on GitHub (Git does a proper merge, not a replace). However, the diff will show misleading "deletions" that are actually just code the branch never had. This causes confusion during review.

---

## Step 4: Update Branch (If Stale)

**Option A: Merge dev into your branch** (preserves commit history, creates merge commit)
```bash
git merge origin/dev
```

**Option B: Rebase onto dev** (cleaner history, rewrites commits)
```bash
git rebase origin/dev
```

Resolve any conflicts that arise, then continue.

---

## Step 5: Verify the Diff

```bash
# See file-level summary
git diff dev --stat

# Check total insertions vs deletions
git diff dev --shortstat
```

**What to Look For:**

| Pattern | Meaning |
|---------|---------|
| Mostly insertions (+) | Normal feature branch |
| Large deletions (-) you intended | Refactoring/cleanup branch |
| Large deletions (-) you didn't intend | **Branch is stale - go back to Step 4** |

If unsure about deletions:
```bash
# See exactly what's being deleted in a specific file
git diff dev -- <file-path>
```

---

## Step 6: Push the Updated Branch

```bash
# If you merged:
git push origin <branch-name>

# If you rebased (requires force push):
git push --force-with-lease origin <branch-name>
```

---

## Step 7: Create the Pull Request

```bash
gh pr create --base dev --head <branch-name> --title "<type>: <description>" --body "<PR body>"
```

**PR Title Conventions:**
- `feat:` - New feature
- `fix:` - Bug fix
- `refactor:` - Code restructuring
- `chore:` - Maintenance/config changes
- `docs:` - Documentation only

---

## Quick Reference: Full Command Sequence

```bash
# 1. Fetch and check divergence
git fetch origin
git log --oneline HEAD..origin/dev

# 2. If stale, merge dev (or rebase)
git merge origin/dev

# 3. Verify diff shows only intended changes
git diff dev --shortstat

# 4. Push
git push origin <branch-name>

# 5. Create PR
gh pr create --base dev --head <branch-name> --title "feat: description" --body "..."
```

---

## Common Issues

### "Diff shows large deletions I didn't make"
The branch is stale. While GitHub will merge correctly, update the branch first to get an accurate diff for review.

### "Merge conflicts during update"
Resolve conflicts in each file, then:
```bash
git add <resolved-files>
git merge --continue   # or: git rebase --continue
```

### "Force push rejected"
Use `--force-with-lease` (safer) or coordinate with team before using `--force`.

### "PR shows commits from other branches"
The target branch was incorrectly specified. Close the PR and recreate with correct `--base`.

---

## Incident Reference: January 30, 2026

A PR was created from a stale branch that showed 600+ line deletions. This caused alarm even though GitHub would have merged correctly. The fix was rebasing the branch before the PR to show an accurate diff (+1233/-14 instead of +1282/-621).

**Lesson:** Always update stale branches before PR creation, not for merge correctness, but for accurate review.
