# WealthNest


WealthNest is a personal finance tracker that runs entirely in the browser. The name combines **wealth** (your money and financial goals) with **nest** (a safe, organized place to keep and grow what matters) — the idea being that your finances have a secure home.

## What It's For

WealthNest helps individuals track their income, expenses, savings goals, budgets, and investment assets in one unified workspace. It is built for people who want a clean, private, and intuitive view of their finances without connecting third-party bank aggregators or installing native desktop apps.

## Features

- **Dashboard** — monthly overview of income, expenses, savings, and investments, with cash flow trend analytics and direct navigation to all modules
- **Transactions** — log income, expenses, and savings deposits with categories, subcategories, and designated holding locations ("Saving In")
- **Budgets** — set monthly spending targets per category and track live progress with clear indicators
- **Savings Goals** — create goals with target amounts, target dates, and assigned holding vaults
- **Investments & Projections** — track holdings across asset classes, monitor portfolio valuation and ROI, and simulate long-term compound growth outcomes
- **Reports** — visual breakdown of spending by category, subcategory details, and period-over-period comparisons
- **Settings** — manage custom categories, currency preference, payment methods, and account settings
- **Cloud Sync** — sign in to sync data to the cloud; works offline in local demo mode
- **Authentication** — email/password sign-up or Google OAuth via Supabase
- **Account Deletion** — users can permanently delete their account and all data from within the app

### Investment Tracking & Wealth Projections

The Investments module gives users a complete picture of their asset allocation and wealth trajectory:
- **Holdings Management**: Log investments across asset classes (ETFs, Stocks, Crypto, Real Estate, Bonds) and record where they are held (e.g., Fidelity, Vanguard, Robinhood, Cold Storage).
- **Valuation & Performance**: Tracks total capital invested (cost basis), current market value, and net return (ROI) alongside an asset allocation donut breakdown.
- **Outcome Projection Engine**: Interactive compound interest simulator with adjustable time horizons (3–30 years), annual return rates (5% conservative, 10% index, 14% growth), and recurring monthly contributions. Calculates future values, capital doubling time (Rule of 72), and projected passive income (4% safe withdrawal rule).
- **Milestone Roadmap**: Dynamic timeline highlighting estimated arrival dates for key net worth thresholds based on contribution pace and return rate.

### Cash Flow & Visual Analytics

- **Bar Numbers on Trend Charts**: Cash flow trend displays formatted amounts directly on and above bars with collision prevention.
- **High-Contrast Metrics**: Dark, crisp labels and axes calibrated for readability from an arm's distance.
- **Touch-Friendly Tooltips**: Responsive column selection on desktop hover and mobile touch.

## Technologies

| Layer | Technology |
|-------|-----------|
| Frontend | HTML, CSS, JavaScript (single file, no framework) |
| Charts | [Chart.js](https://www.chartjs.org/) |
| Auth & Database | [Supabase](https://supabase.com/) (PostgreSQL + Auth) |
| Fonts | Google Fonts (Plus Jakarta Sans, Manrope, JetBrains Mono) |
| Hosting | [Vercel](https://vercel.com/) |
| Version Control | [GitHub](https://github.com/) |

## System Architecture

```
Browser (Client)  →  Single-page web application with responsive UI and offline local storage
GitHub            →  Source control and repository hosting
Vercel            →  Automated deployment on every push
Supabase          →  User authentication and PostgreSQL database with Row Level Security (RLS)
```

- **Client**: Pure vanilla HTML, CSS, and modern JavaScript packaged into a lightweight single-page application with responsive layouts for mobile and desktop screens.
- **Database & Auth**: Supabase provides user authentication (email/password and Google OAuth) and PostgreSQL persistence. User data is isolated using Row Level Security (RLS).
- **Deployment**: Hosted on Vercel with automatic continuous deployment on every push to the `main` branch.

## Running Locally

You need [Node.js](https://nodejs.org/) installed.

```bash
npx serve .
```

Then open [http://localhost:3000](http://localhost:3000) in your browser.

Alternatively, open `index.html` directly in a browser. Most features work without a server; OAuth sign-in requires a proper origin (use `npx serve .` for that).

## Deploying to Vercel

### Option A — GitHub Import (recommended)

1. Push this repo to GitHub.
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
2. Replace `SUPABASE_URL` and `SUPABASE_ANON_KEY` in `index.html` with your own values.
3. Enable Google OAuth under **Authentication → Providers → Google** if needed.
4. Under **Authentication → URL Configuration**:
   - Set **Site URL** to your production domain: `https://wealthnest-yahya-kq.vercel.app`
   - Add to **Redirect URLs**: `https://wealthnest-yahya-kq.vercel.app/**`
5. Run `supabase-delete-account.sql` in the Supabase SQL Editor to enable in-app account deletion.

The Supabase anon key in the source code is a public browser key — it is safe to commit. User data is protected by Row Level Security (RLS) policies, not by hiding this key.
