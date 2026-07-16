# Example Client — credentials (pointers only)

**Section:** work/example-client
**Date:** seeded on install
**Tags:** example, client, credentials

> ⚠️ Never store plaintext secrets in the versioned brain. Store the **pointer** to where
> the secret actually lives, or keep the secret in a gitignored `.secrets/` folder.

## Where the secrets live
- Server SSH key: `~/.ssh/<key-name>` (not committed).
- Admin panel: URL + which password manager entry holds the login.
- API keys: which `.env` / vault they live in.

## .secrets/ (gitignored)
If you must keep a secret file locally, put it in `work/example-client/.secrets/` — it's
excluded by `.gitignore` and never leaves your machine.
