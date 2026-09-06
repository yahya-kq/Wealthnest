# WealthNest

WealthNest is a personal finance tracker that runs entirely in the browser. The name combines **wealth** (your money and financial goals) with **nest** (a safe, organized place to keep and grow what matters) — the idea being that your finances have a secure home.

## What It's For

WealthNest helps individuals track their income, expenses, savings goals, and budgets in one place. It's built for people who want a clean, private view of their finances without connecting to a bank or installing an app.

## Features

- **Dashboard** — monthly summary of income, expenses, and savings at a glance
- **Transactions** — log income, expenses, and savings contributions with categories and subcategories
- **Budgets** — set monthly spending limits per category and track progress
- **Savings Goals** — create goals with target amounts and deadlines
- **Reports** — visual breakdown of spending by category and month-over-month comparison
- **Settings** — manage categories, currency, and account details
- **Cloud Sync** — sign in to save data to the cloud; works offline in local demo mode
- **Authentication** — email/password sign-up or Google OAuth via Supabase
- **Account Deletion** — users can permanently delete their account and all data from within the app

## Technologies

| Layer | Technology |
|-------|-----------|
| Frontend | HTML, CSS, JavaScript (single file, no framework) |
| Charts | [Chart.js](https://www.chartjs.org/) |
| Auth & Database | [Supabase](https://supabase.com/) (PostgreSQL + Auth) |
| Fonts | Google Fonts (Plus Jakarta Sans, Manrope, JetBrains Mono) |
| Hosting | [Vercel](https://vercel.com/) |
| Version Control | [GitHub](https://github.com/) |
| Built with | [Antigravity](https://antigravity.dev/) (AI coding assistant by Google DeepMind) |

## How the Tools Work Together

```
Antigravity  →  wrote and iterated on the entire codebase
GitHub       →  stores and versions the source code
Vercel       →  deploys from GitHub automatically on every push
Supabase     →  handles user authentication and stores financial data securely
```

- **Antigravity** (Google DeepMind's AI coding assistant) was used to build the entire project — from UI design to database integration — in a single conversation.
- **GitHub** hosts the source code. Vercel is connected to this repo.
- **Vercel** deploys the app automatically whenever the `main` branch is updated. No build step is needed — Vercel serves `index.html` directly.
- **Supabase** provides authentication (email/password and Google OAuth) and a PostgreSQL database. Each user's financial data is stored in a `user_finances` table, protected by Row Level Security (RLS) so users can only access their own data.

## Running Locally

You need [Node.js](https://nodejs.org/) installed.

```bash
npx serve .
```

Then open [http://localhost:3000](http://localhost:3000) in your browser.

Alternatively, open `index.html` directly in a browser. Most features work without a server; OAuth sign-in requires a proper origin (use `npx serve .` for that).

## Deploying to Vercel

### Option A — GitHub Import (recommended)

1. Push this repo to GitHub (already done).
2. Go to [vercel.com](https://vercel.com/) → **Add New Project** → import the `Wealthnest` repo.
3. Framework preset: **Other** (static site).
4. No build command, no output directory needed.
5. Click **Deploy**.

### Option B — Vercel CLI

```bash
npm install -g vercel
vercel
```

Follow the prompts. Run `vercel --prod` to deploy to production.

## Supabase Setup Notes

WealthNest connects to an existing Supabase project. If you're setting up your own:

1. Create a project at [supabase.com](https://supabase.com/).
2. Replace `SUPABASE_URL` and `SUPABASE_ANON_KEY` in `index.html` (lines ~1731–1732) with your own values.
3. Enable Google OAuth under **Authentication → Providers → Google** if needed.
4. Run `supabase-delete-account.sql` in the Supabase SQL Editor to enable in-app account deletion.

The Supabase anon key in the source code is a public browser key — it is safe to commit. User data is protected by Row Level Security (RLS) policies, not by hiding this key.
