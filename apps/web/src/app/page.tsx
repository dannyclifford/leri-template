export default function Home() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center gap-8 p-8">
      <main className="flex flex-col items-center gap-6 text-center">
        <h1 className="text-4xl font-bold tracking-tight sm:text-5xl">
          Welcome to Your Project
        </h1>
        <p className="max-w-md text-lg text-gray-600 dark:text-gray-400">
          Built with Turborepo, Next.js 16, Shadcn/ui, Tailwind CSS v4, and AI
          Elements.
        </p>
        <div className="flex gap-4">
          <a
            href="https://nextjs.org/docs"
            target="_blank"
            rel="noopener noreferrer"
            className="rounded-lg bg-foreground px-5 py-2.5 text-sm font-medium text-background transition-colors hover:bg-foreground/90"
          >
            Get Started
          </a>
          <a
            href="https://turborepo.dev/docs"
            target="_blank"
            rel="noopener noreferrer"
            className="rounded-lg border border-gray-200 px-5 py-2.5 text-sm font-medium transition-colors hover:bg-gray-100 dark:border-gray-800 dark:hover:bg-gray-900"
          >
            Read Docs
          </a>
        </div>
      </main>
    </div>
  );
}
