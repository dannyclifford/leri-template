---
description: Keep feature branches in sync with dev to avoid merge conflicts
---

# Branch Maintenance Workflow

Stale branches cause painful merge conflicts and misleading PR diffs. Follow this workflow to keep branches healthy.

---

## Starting a New Branch

// turbo
```bash
git checkout dev
git pull origin dev
git checkout -b your-feature-name
```

---

## While Working (Every Few Days)

Sync your branch with `dev` regularly to catch conflicts early:

// turbo
```bash
git fetch origin
git merge origin/dev
```

If conflicts occur, resolve them immediately while they're small.

> [!TIP]
> Set a calendar reminder to sync every 2-3 days on active branches.

---

## Before Creating a PR

**Always** sync before creating a PR:

// turbo
```bash
git fetch origin
git merge origin/dev
git push origin your-feature-name
```

Then verify your diff only shows your intended changes:

// turbo
```bash
git diff origin/dev --shortstat
```

---

## Warning Signs of a Stale Branch

| Sign | What It Means |
|------|---------------|
| `git log --oneline HEAD..origin/dev` shows many commits | You're behind `dev` |
| PR diff shows large unexpected deletions | Branch diverged significantly |
| Many merge conflicts at PR time | Branch was not synced regularly |

---

## Recovery: If Your Branch Is Already Stale

If your branch is far behind `dev` (10+ commits), consider rebasing:

```bash
# Create a backup first
git branch your-feature-backup

# Rebase onto dev
git fetch origin
git rebase origin/dev

# If too many conflicts, abort and use merge instead
git rebase --abort
git merge origin/dev
```

For severely diverged branches (different histories), see `/prepare-pr` workflow.

---

## Quick Reference

| Frequency | Action |
|-----------|--------|
| **Daily/Every few days** | `git fetch origin && git merge origin/dev` |
| **Before PR** | Sync + verify diff shows only your changes |
| **After PR merged** | Delete the local branch, start fresh for next feature |
