# Leri Template

This repository is the Bun-managed Turborepo that Leri copies when creating a project.

## Commands

```sh
bun install
bun run dev
bun run lint
bun run check-types
bun run build
```

## Working conventions

- Use Bun. Keep root tooling and workspace package versions aligned.
- The deployable application is `apps/web`; shared primitives live in `packages/ui`.
- Keep the template free of optional integration-specific dependencies, environment variables, and infrastructure until a generated project needs them.
- Reuse the included shadcn and AI Elements components before adding new UI primitives.
- Keep agent skills in `.agents/skills`. Do not edit registry-managed skills by hand.
- The installed AI SDK's version-matched documentation is at `apps/web/node_modules/ai/docs/`.

## Skills maintenance

- Registry-managed skills are recorded in `skills-lock.json`; the custom `frontend-design` skill is maintained in-repo.
- When updating core dependencies or preparing a template release, run `bun run skills:update`, review the skill and lockfile diff, then run the normal lint, typecheck, and build checks.

## Reference cache

- `.ref/` is gitignored local source material, never application code.
- Fetch the core UI references with `bun run refs:core`.
- Fetch other repositories only for the task at hand with `bash scripts/fetch-repo.sh <owner/repository> <local-name> [branch]`.
