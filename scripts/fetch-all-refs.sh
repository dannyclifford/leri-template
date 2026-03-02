#!/bin/bash
# Fetch all standard reference repos
# Run from repo root: ./scripts/fetch-all-refs.sh

set -e

SCRIPT_DIR="$(dirname "$0")"

echo "🔄 Fetching all reference repos..."
echo ""

"$SCRIPT_DIR/fetch-repo.sh" "vercel/ai" "ai-sdk" "main"
"$SCRIPT_DIR/fetch-repo.sh" "shadcn-ui/ui" "shadcn-ui" "main"
"$SCRIPT_DIR/fetch-repo.sh" "vercel/ai-chatbot" "ai-chatbot" "main"
"$SCRIPT_DIR/fetch-repo.sh" "vercel/ai-elements" "ai-elements" "main"
"$SCRIPT_DIR/fetch-repo.sh" "workos/next-b2b-starter-kit" "next-b2b-starter-kit" "main"
"$SCRIPT_DIR/fetch-repo.sh" "get-convex/turbo-expo-nextjs-clerk-convex-monorepo" "convex-monorepo-example" "main"
"$SCRIPT_DIR/fetch-repo.sh" "PostHog/posthog-js" "posthog-js" "main"
"$SCRIPT_DIR/fetch-repo.sh" "vercel/turborepo" "turborepo" "main"
"$SCRIPT_DIR/fetch-repo.sh" "get-convex/workos-authkit" "workos-authkit" "main"
"$SCRIPT_DIR/fetch-repo.sh" "OpenRouterTeam/ai-sdk-provider" "openrouter-ai-sdk" "main"
"$SCRIPT_DIR/fetch-repo.sh" "colinhacks/zod" "zod" "main"

# Skills community repos
"$SCRIPT_DIR/fetch-repo.sh" "VoltAgent/awesome-agent-skills" "_skills/voltagent-awesome-agent-skills" "main"
"$SCRIPT_DIR/fetch-repo.sh" "anthropics/skills" "_skills/anthropics-skills" "main"
"$SCRIPT_DIR/fetch-repo.sh" "heilcheng/awesome-agent-skills" "_skills/heilcheng-awesome-agent-skills" "main"
"$SCRIPT_DIR/fetch-repo.sh" "Automattic/agent-skills" "_skills/automattic-agent-skills" "main"
"$SCRIPT_DIR/fetch-repo.sh" "skillcreatorai/Awesome-Agent-Skills" "_skills/skillcreatorai-awesome-agent-skills" "main"
"$SCRIPT_DIR/fetch-repo.sh" "vercel-labs/skills" "_skills/vercel-skills" "main"

echo ""
echo "✅ All reference repos ready!"
