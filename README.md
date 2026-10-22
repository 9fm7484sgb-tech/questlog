# Questlog Online — Your Life RPG

A free, browser-based, phone-and-desktop life RPG with character stats based on writing, chess, fitness, friendships, reflection, and Minecraft PvP.

## Play

After GitHub Pages is enabled, this repository will be published at:

`https://9fm7484sgb-tech.github.io/questlog/`

**Deployment is not yet confirmed live.** GitHub Pages must first be turned on in this repository's Settings > Pages.

The game can also open as `index.html` on a Windows computer, with offline guest saves only.

## First-time GitHub upload

If this repository is still empty, on [the Questlog repository](https://github.com/9fm7484sgb-tech/questlog) use the **uploading an existing file** link in Quick setup. Otherwise select **Add file > Upload files**.

1. Unzip `questlog_github_upload.zip` on your computer.
2. Open the extracted folder and select **all seven files inside**, rather than uploading the ZIP itself or putting the files into a nested folder.
3. Upload/commit those files to the **main** branch. `index.html` must be directly in the repository root.
4. Open **Settings > Pages**. Select **Deploy from a branch**, branch **main**, folder **/(root)**, then **Save**.
5. Once Pages reports deployment, open `https://9fm7484sgb-tech.github.io/questlog/` on your computer or iPhone.

## Optional cloud accounts and sync (separate setup)

The hosted game works immediately in **guest mode** with local browser saving. **Cross-device accounts and cloud sync are not active until configured**:

1. Create your own **Supabase Free** project.
2. In its SQL Editor, run `supabase_setup.sql`. That creates personal tables with Row Level Security (RLS).
3. Edit `config.js` with the project's HTTPS URL and its **publishable key** only. NEVER add its secret key, service-role key, or database password.
4. Commit the updated `config.js` to the repository.
5. In Supabase Authentication, enable email/password sign-in with email confirmation. Set Site URL to `https://9fm7484sgb-tech.github.io/questlog/`, and add it to the redirect allowlist if required.
6. In the game, open **Save & Settings** to create an account and sign in on both devices.

Refer to `SETUP.md` for detailed instructions, backup procedures, offline behavior, and the policy for simultaneous edits.

**Security:** This repository and all GitHub Pages files are PUBLIC. Never commit journal entries, private backups, passwords, OAuth tokens, or private API keys. Supabase auth protects the personal records when SQL/RLS are configured correctly.

## Later updates

Changes to the `main` branch are published automatically by Pages. This does NOT mean ChatGPT can currently push: the connected GitHub integration returned an HTTP 403 permissions error while trying to write. Granting suitable repository write access or manually committing changes is required.
