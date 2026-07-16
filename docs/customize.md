# Customize your brain

Central Brain ships as a skeleton. It becomes *yours* the moment you fill it in.

## First 10 minutes

1. **Fill `personal/profile.md`.** Who you are, how you like to work, your main projects.
   The Brain reads this to match your style — the more honest, the better it feels.
2. **Delete the `example-*` folders.** `work/example-client/` and `agents/example-agent/`
   are just molds. Copy them for your real clients/agents, then remove the samples.
3. **Set your models.** Edit `tools/models.md` with the models you actually use and what
   each is best for, so the Brain routes tasks well.
4. **Add your first real content.** Next time you close a topic, say `/save` and let the
   Brain file it. Watch it keep the `_index.md` current.

## Adding your own skill

1. Create `skills/<your-skill>/SKILL.md` with frontmatter:
   ```markdown
   ---
   name: your-skill
   description: What it does + trigger phrases (this is how the agent knows when to use it).
   argument-hint: [what to pass, or nothing]
   ---
   # Skill: /your-skill — ...
   Reply in {{LANG}}. Your brain is at {{BRAIN}}.
   ...instructions...
   ```
2. Use the placeholders `{{BRAIN}}`, `{{NAME}}`, `{{LANG}}` anywhere — the installer
   resolves them.
3. Re-run the installer to publish it.

## Changing the bucket structure

The 7 buckets are a strong default, not a law. If you add or rename a bucket:
- Update `brain/_index.md` (the root map).
- Give the new folder an `_index.md` following `brain/CONVENTIONS.md`.
- Mention it in `brain/CLAUDE.md` / `brain/AGENTS.md` so the Brain knows it exists.

## Keeping secrets out of git

Never commit plaintext secrets. Put secret files in a `.secrets/` folder anywhere in the
brain (it's gitignored), or store the pointer to where the secret lives (a password
manager entry, an `~/.ssh/` key). See `brain/CONVENTIONS.md` §5.

## Sharing your brain across machines

Your brain is just a folder. Put it in a private git repo, a synced drive, or a cloud
folder — then point the installer at that path on each machine. The public Central Brain repo
stays the template; your private brain stays yours.
