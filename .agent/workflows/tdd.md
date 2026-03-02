---
description: Test-Driven Development workflow for all new features
---

# TDD Workflow

Test-Driven Development is **required** for all new features. Write tests first, then implement.

## The TDD Cycle

```
┌─────────────────────────────────────────────────────────────┐
│  1. RED     →  2. GREEN  →  3. REFACTOR  →  (repeat)        │
│  Write test    Make it      Clean up                        │
│  that fails    pass         the code                        │
└─────────────────────────────────────────────────────────────┘
```

## Workflow Steps

### 1. Write the test FIRST

```typescript
// packages/ui/__tests__/new-component.test.tsx
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { NewComponent } from '../src/components/new-component';

describe('NewComponent', () => {
  it('renders correctly', () => {
    render(<NewComponent>Hello</NewComponent>);
    expect(screen.getByText('Hello')).toBeInTheDocument();
  });

  it('handles click events', async () => {
    const onClick = vi.fn();
    render(<NewComponent onClick={onClick}>Click me</NewComponent>);
    await userEvent.click(screen.getByRole('button'));
    expect(onClick).toHaveBeenCalled();
  });
});
```

### 2. Run the test (expect failure)

```bash
bun run test --filter @workspace/ui
```

### 3. Implement minimum code to pass

```typescript
// packages/ui/src/components/new-component.tsx
export function NewComponent({ children, onClick }) {
  return <button onClick={onClick}>{children}</button>;
}
```

### 4. Run tests again (expect pass)

```bash
bun run test --filter @workspace/ui
```

### 5. Refactor

- Improve code quality
- Add types
- Run tests again to ensure nothing broke

## Commands

```bash
# Run all tests once
bun run test

# Watch mode (re-runs on file changes)
bun run test:watch

# Run specific package tests
bun run test --filter @workspace/ui
bun run test --filter @workspace/ai-elements
bun run test --filter playground

# With coverage
bun run test -- --coverage
```

## AI SDK Feature Development

For new AI SDK features, use the playground:

```bash
# 1. Create experiment + test in playground
touch playground/src/experiments/my-feature.ts
touch playground/tests/my-feature.test.ts

# 2. TDD in isolation (fast iteration)
bun run test --filter playground

# 3. Once tests pass, move to apps/web
```

## Test File Locations

| Package | Test Location |
|---------|---------------|
| `packages/ui` | `packages/ui/__tests__/` |
| `packages/ai-elements` | `packages/ai-elements/__tests__/` |
| `packages/backend` | `packages/backend/convex/__tests__/` |
| `apps/web` | `apps/web/__tests__/` or `apps/web/src/**/*.test.ts` |
| `playground` | `playground/tests/` |

## Test Naming Conventions

- Test files: `*.test.ts` or `*.test.tsx`
- Describe blocks: Component/function name
- It blocks: "should [expected behavior]" or "[action] [result]"

```typescript
describe('Calculator', () => {
  it('should add two numbers', () => { ... });
  it('should handle division by zero', () => { ... });
});
```
