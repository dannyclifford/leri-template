---
description: Fetch external repos for AI-searchable reference documentation
---

# Fetch Reference Repos Workflow

// turbo-all

## 1. Fetch all standard references

```bash
./scripts/fetch-all-refs.sh
```

## 2. Fetch a specific repo

```bash
./scripts/fetch-repo.sh <org/repo> <local-name> [branch]

# Examples:
./scripts/fetch-repo.sh vercel/ai ai-sdk main
./scripts/fetch-repo.sh shadcn-ui/ui shadcn-ui main
./scripts/fetch-repo.sh vercel/ai-chatbot ai-chatbot main
./scripts/fetch-repo.sh vercel/ai-elements ai-elements main
./scripts/fetch-repo.sh workos/next-b2b-starter-kit next-b2b-starter-kit main
./scripts/fetch-repo.sh PostHog/posthog-js posthog-js main
./scripts/fetch-repo.sh vercel/turborepo turborepo main
./scripts/fetch-repo.sh ComposioHQ/composio composio main
./scripts/fetch-repo.sh get-convex/workos-authkit workos-authkit main
./scripts/fetch-repo.sh OpenRouterTeam/ai-sdk-provider openrouter-ai-sdk main
./scripts/fetch-repo.sh colinhacks/zod zod main

# Skills community repos:
./scripts/fetch-repo.sh VoltAgent/awesome-agent-skills _skills/voltagent-awesome-agent-skills main
./scripts/fetch-repo.sh anthropics/skills _skills/anthropics-skills main
./scripts/fetch-repo.sh heilcheng/awesome-agent-skills _skills/heilcheng-awesome-agent-skills main
./scripts/fetch-repo.sh Automattic/agent-skills _skills/automattic-agent-skills main
./scripts/fetch-repo.sh skillcreatorai/Awesome-Agent-Skills _skills/skillcreatorai-awesome-agent-skills main
./scripts/fetch-repo.sh vercel-labs/skills _skills/vercel-skills main

```

## 3. Search within references

```bash
# Find a specific file
find .ref -name "*.tsx" | grep -i "button"

# Search for code patterns
grep -r "useChat" .reference/ai-chatbot/

# Find component implementations
ls .ref/shadcn-ui/apps/www/registry/new-york/ui/
```

## 4. Reference directories

| Directory | Contents |
|-----------|----------|
| `.ref/ai-sdk/` | Vercel AI SDK source, docs, examples |
| `.ref/shadcn-ui/` | Shadcn component library |
| `.ref/ai-chatbot/` | Full Next.js AI chat application |
| `.ref/ai-elements/` | AI Elements component library |
| `.ref/next-b2b-starter-kit/` | WorkOS B2B auth, teams, SSO patterns |
| `.ref/posthog-js/` | PostHog analytics SDK, Next.js examples |
| `.ref/turborepo/` | Turborepo monorepo tools, Vercel deployment docs |
| `.ref/composio/` | Composio tools SDK, Vercel AI integration |
| `.ref/workos-authkit/` | Official Convex + WorkOS AuthKit component |
| `.ref/openrouter-ai-sdk/` | OpenRouter AI SDK provider for multi-model routing |
| `.ref/zod/` | Zod schema validation library (v4), migration guide, docs |

## 5. Best practices

1. **Search references before implementing** - Check if a pattern exists
2. **Don't modify reference code** - It's gitignored and may be overwritten
3. **Copy patterns, not code** - Adapt to our conventions
4. **Update references periodically** - Re-run fetch scripts to get updates