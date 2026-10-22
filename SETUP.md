# Questlog Online — setup and usage

**Questlog Online** is an HTML web game with a responsive phone/desktop design, daily quests, skills that visually change the hero, XP, trophies, guided workouts, Minecraft PvP lessons, and account-based cloud saves (when connected to your own Supabase project).

**Important:** The downloadable game works immediately as an **offline guest**. **Real accounts and cross-device synchronization are not activated until you complete this setup.** Nobody else's account/backend is included.

## A. Try it right now on Windows (no account)

1. Unzip the folder and double-click `index.html` in Chrome or Edge.
2. Click **Daily Quests** and log 5 or 10 minutes in a habit.
3. See **Your Character** to watch the corresponding RPG attribute and visual effect progress.
4. Guest progress saves automatically in this browser. Open **Save & Settings → Export backup** regularly.

## B. Activate the free cloud-account features

1. Visit <https://supabase.com> and create a Supabase project on the **Free** plan. You control this database.
2. In the project dashboard, open **SQL Editor**, paste the entire `supabase_setup.sql` file, and run it. This creates two private tables with Row Level Security.
3. Under the project's **Connect / API Keys** area, locate your **Project URL** (`https://...supabase.co`) and the **publishable** key (`sb_publishable_...`; some projects offer a legacy `anon` key). **Do not use a secret key, service_role key, database password, or access token.**
4. Edit `config.js` with a text editor. Paste those two values between the quotes:

   ```javascript
   window.QUESTLOG_CONFIG = {
     supabaseUrl: "https://YOUR-PROJECT.supabase.co",
     supabasePublishableKey: "sb_publishable_YOUR_PUBLIC_KEY"
   };
   ```

5. For reliable accounts and mobile access, host **`index.html` and `config.js` together over HTTPS** using step C. Do not use a `file://` page for email-confirmation redirects.
6. In Supabase, check **Authentication → Providers → Email** (email/password sign-in enabled). **Leave Confirm Email on** for security. The free built-in email sender can have rate limits.
7. In **Authentication → URL Configuration**, set the **Site URL** to your published Questlog URL, such as `https://YOUR-USERNAME.github.io/questlog/`. Add this same URL to **Redirect URLs** if needed. Email confirmation must return to the hosted app.
8. Open **Save & Settings** in Questlog. Create your account using an email and a strong password. Confirm the email link if prompted, then sign in on both PC and iPhone using the **same website and email**.

## C. Free publishing with GitHub Pages

1. Create a GitHub account and a new repository, e.g. `questlog`. **Use a public repository only if you're happy to publish the game's source code; never commit passwords or secret keys.**
2. Upload `index.html`, `config.js` and optionally `manifest.webmanifest` and `icon.svg` into the repository's root. The **HTML file must be called `index.html`**.
3. Under **Settings → Pages**, choose **Deploy from a branch**, `main`, root (`/`), and Save. GitHub Pages will publish your project at a URL such as `https://YOUR-USERNAME.github.io/questlog/`.
4. On your iPhone, open the published link in Safari, then **Share → Add to Home Screen**. On PC, bookmark the same link.
5. Sign in on both devices. Your character and quests are linked to the same account. Saving works online; while temporarily disconnected, new edits are queued on the device and retried when you reconnect.

## D. How sync behaves

- Each day is stored separately in Supabase (`questlog_days`) and your display name in `questlog_profiles`; Row Level Security restricts both to the signed-in account.
- Saving is immediate to the local device cache, then automatically sent to the server after a short delay. When using another device, the app updates on opening/focus and approximately every 30 seconds while visible.
- A cloud error displays a warning; queued edits remain cached **in that browser**. Export backup if there is a long-lasting outage.
- **Last-write-wins for the same date:** simultaneous edits to the same day's record on two devices may overwrite each other. Do not edit the same date on both screens at once.
- If you used an earlier copy of Questlog under a different file path or web address, export its **Save & Settings → Export backup** file and import the backup into Questlog Online. Browser local storage from the old address will not automatically carry over.
- The guest save is **not silently uploaded**. To transfer it after signing in, choose **Import guest progress** in the Account panel; confirm the merge. Dates that exist in both locations take the guest entry.
- You can sign out and still use local guest mode. The browser stores session tokens to keep you signed in; avoid using this on public/shared devices.
- **Export Backup** creates a complete JSON file. In account mode, **Import Backup** merges days into the account; if dates overlap, the imported day replaces that date's record.
- The free Supabase project can pause after about one week of inactivity, so long-term availability is not guaranteed without checking their plan rules. Keep periodic exported backups.
- No fitness sensor or chess app integration is included. Skills grow from *self-reported activity*, not independently verified real-world changes.
- The spreadsheet version is separate and does not auto-synchronize with this web app.

## Character evolution

Every recorded minimum activity grants **1 attribute point** and hitting the daily target grants **2 attribute points** instead. Each 5 points adds one attribute level. All historical totals are recomputed from your saved activity logs, so editing a log updates the hero automatically.

| Habit | RPG stat | Hero effect |
|---|---|---|
| Workout | STR · Strength | Wider shoulders and stronger armour |
| Chess | INT · Intelligence | Scholarly glowing halo |
| Minecraft PvP | DEX · Dexterity | Speed trails and upgraded boots |
| Writing | CRE · Creativity | Magic quill |
| Friends | CHA · Charisma | Friendly companion lights |
| Reflection | WIS · Wisdom | Arcane aura and mystic mark |

## Privacy and deployment cautions

- Your database and Auth project are **yours**. The publicly visible `config.js` may contain only the **publishable** key (not secret/service-role). RLS is necessary and supplied by the SQL script.
- GitHub Pages is public web hosting: do not put journal entries, passwords, private backups, or exported save files in the repository.
- An account requires a valid email for signup; exercise and journal entries remain private in your own cloud project behind RLS.
- If the app displays a Supabase permissions or missing-table error, check that the SQL script ran in the same Supabase project as the URL and key.
