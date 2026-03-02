# Reference Library

External repositories cloned for AI-searchable reference. These are **gitignored** and fetched on demand.

## Current References

| Directory | Source | Description |
|-----------|--------|-------------|
| `ai-sdk/` | `vercel/ai` | Vercel AI SDK source, docs, examples |
| `shadcn-ui/` | `shadcn-ui/ui` | Shadcn component library |
| `ai-chatbot/` | `vercel/ai-chatbot` | Full Next.js AI chat application |
| `ai-elements/` | `vercel/ai-elements` | AI Elements component library |
| `next-b2b-starter-kit/` | `workos/next-b2b-starter-kit` | WorkOS B2B auth, teams, SSO patterns |
| `convex-monorepo-example/` | `get-convex/turbo-expo-nextjs-clerk-convex-monorepo` | Convex + Turborepo monorepo example |
| `posthog-js/` | `PostHog/posthog-js` | PostHog analytics SDK, Next.js examples |
| `turborepo/` | `vercel/turborepo` | Turborepo monorepo tools, Vercel deployment docs |
| `workos-authkit/` | `get-convex/workos-authkit` | Official Convex + WorkOS AuthKit component |
| `openrouter-ai-sdk/` | `OpenRouterTeam/ai-sdk-provider` | OpenRouter AI SDK provider for multi-model routing |
| `zod/` | `colinhacks/zod` | Zod schema validation library (v4), migration guide, docs |

### Skills Community

| Directory | Source | Description |
|-----------|--------|-------------|
| `_skills/voltagent-awesome-agent-skills/` | `VoltAgent/awesome-agent-skills` | VoltAgent agent skills collection |
| `_skills/anthropics-skills/` | `anthropics/skills` | Anthropic's official agent skills |
| `_skills/heilcheng-awesome-agent-skills/` | `heilcheng/awesome-agent-skills` | Community agent skills collection |
| `_skills/automattic-agent-skills/` | `Automattic/agent-skills` | Automattic agent skills |
| `_skills/skillcreatorai-awesome-agent-skills/` | `skillcreatorai/Awesome-Agent-Skills` | SkillCreatorAI agent skills |
| `_skills/vercel-skills/` | `vercel-labs/skills` | Vercel skills.sh CLI and open agent skills ecosystem |

## Usage

```bash
# Fetch all references
./scripts/fetch-all-refs.sh

# Fetch a specific repo
./scripts/fetch-repo.sh <org/repo> <local-name> [branch]
```

## For AI Agents

- **Search before implementing** — check if a pattern already exists in references
- **`ai-sdk/`** — streaming patterns, tool calling, structured output, provider implementations
- **`shadcn-ui/`** — component patterns, registry system, styling conventions
- **`ai-chatbot/`** — full-stack AI chat architecture, message persistence, auth integration
- **`ai-elements/`** — AI-specific UI components (code blocks, markdown rendering)
- **`next-b2b-starter-kit/`** — WorkOS auth patterns, team management, SSO
- **`turborepo/`** — monorepo configuration, task pipelines, caching strategies
- **`workos-authkit/`** — Convex + WorkOS session management patterns
- **`zod/`** — schema validation patterns, v4 migration
- **Don't modify reference code** — it's gitignored and may be overwritten
- **Copy patterns, not code** — adapt to project conventions
