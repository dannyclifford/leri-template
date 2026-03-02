---
description: Add a new external repo to the reference library
---

# Add Reference Workflow

// turbo-all

## 1. Fetch the repo

```bash
./scripts/fetch-repo.sh <org/repo> <local-name> <branch>

# Example:
./scripts/fetch-repo.sh workos/next-b2b-starter-kit next-b2b-starter-kit main
```

## 2. Update fetch-all-refs.sh

Add a new line to `scripts/fetch-all-refs.sh`:

```bash
"$SCRIPT_DIR/fetch-repo.sh" "<org/repo>" "<local-name>" "<branch>"
```

## 3. Update fetch-references workflow

Edit `.agent/workflows/fetch-references.md`:

1. Add example to **Section 2** examples
2. Add row to **Section 4** reference directories table

## 4. Update .ref/README.md

Edit `.ref/README.md`:

1. Add row to **Current References** table
2. Add bullet to **For AI Agents** section

## Files to update

| File | What to add |
|------|-------------|
| `scripts/fetch-all-refs.sh` | Fetch command line |
| `.agent/workflows/fetch-references.md` | Example + table row |
| `.ref/README.md` | Table row + AI guidance |