# Reference Library

`.ref/` is a local, gitignored cache for source code worth searching during a task. It is not part of the generated project and reference clones must never be edited.

## Core references

Fetch the two sources that match the components already bundled with the template:

```sh
bun run refs:core
```

| Directory | Source | Use it for |
| --- | --- | --- |
| `ai-elements/` | `vercel/ai-elements` | AI UI component patterns |
| `shadcn-ui/` | `shadcn-ui/ui` | shadcn component and registry patterns |

## Fetch on demand

Avoid a large default reference library. Fetch a source only when its implementation details are needed:

```sh
bash scripts/fetch-repo.sh <owner/repository> <local-name> [branch]
```

- `vercel/ai` as `ai-sdk` for repository-level AI SDK examples. Version-matched package docs are already at `apps/web/node_modules/ai/docs/`.
- `tailwindlabs/tailwindcss` as `tailwindcss` for Tailwind internals or migration work.
- `vercel/turborepo` as `turborepo` for workspace and cache configuration.
- `vercel/next.js` as `nextjs` only when Next.js source is necessary.

Search references before implementing, copy patterns rather than code, and discard no-longer-needed clones freely.
