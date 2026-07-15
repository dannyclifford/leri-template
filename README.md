# Leri Template

The GitHub template that Leri uses to create new project repositories. It is a Bun-managed Turborepo containing one deployable Next.js application.

## Stack

- Next.js 16, React 19, and TypeScript 5.9
- Tailwind CSS 4, shadcn/ui primitives, and Radix UI
- AI SDK 7 with Streamdown-based AI UI components
- Turborepo and Bun 1.3.5

## Requirements

- Node.js 22.11 or later
- Bun 1.3.5 or later

## Commands

```sh
bun install
bun run dev
bun run lint
bun run check-types
bun run build
```

`bun run dev` starts the `web` workspace. To work on it directly, run `bun --cwd apps/web run dev`.

## Layout

```text
apps/web/                 Next.js application deployed by Vercel
packages/ui/              Shared React component package
packages/eslint-config/   Shared flat ESLint configuration
packages/typescript-config/ Shared TypeScript configurations
```

The template requires no environment variables by default. Leri can copy additional variables into generated Vercel projects when they are added to its generated-project environment plan.
