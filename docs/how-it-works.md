# How Central Brain works

## The three parts

1. **The auto-adapters** — `CLAUDE.md` (Claude Code) and `AGENTS.md` (Codex) at the repo
   root. Your agent reads the right one automatically when it opens the folder. On a fresh
   clone they run onboarding; once installed, they make the agent *become your Brain*.

2. **The skills** — `skills/*/SKILL.md`. Each is a self-contained command (`/brain`,
   `/save`, `/continue`, `/checkpoint`, `/contract`, `/gate`, `/pm`, `/research`) written
   with placeholders so it can be personalized on install.

3. **The brain skeleton** — `brain/`. An empty, structured second brain: 7 buckets, each
   with an `_index.md` map, plus `CLAUDE.md`/`AGENTS.md` (your Brain identity) and
   `CONVENTIONS.md` (the rules). The installer copies this to a folder you choose and fills
   in your name/language/path.

## The install flow

```
open repo → agent reads CLAUDE.md / AGENTS.md
          → is .central-brain/config.json present?
             ├── yes → become the Brain (read <brain>/CLAUDE.md, follow it)
             └── no  → onboarding:
                       ask name + language + brain path
                       run scripts/install.(sh|ps1)
                          1. seed brain/ → <brain path>  (resolve {{BRAIN}}/{{NAME}}/{{LANG}})
                          2. publish skills:
                               claude → ~/.claude/skills/<name>/SKILL.md
                               codex  → <brain>/.commands/<name>.md + AGENTS.md section
                          3. write .central-brain/config.json  (so setup never runs again)
```

## Placeholders

Every skill and brain file carries three placeholders the installer replaces:

| Placeholder | Becomes |
|---|---|
| `{{BRAIN}}` | the absolute path to your brain folder |
| `{{NAME}}` | how the Brain addresses you |
| `{{LANG}}` | the language the Brain replies in |

The skill's published folder name comes from the `name:` field in its frontmatter (so the
`researcher/` source becomes the `/research` command).

## Manual install (no shell)

If neither Bash nor PowerShell is available, do it by hand:

1. **Seed the brain.** Copy everything under `brain/` into a new folder outside this repo
   (e.g. `../my-brain/`). In every `.md` file, replace `{{BRAIN}}` with that folder's
   absolute path, `{{NAME}}` with your name, and `{{LANG}}` with your language.

2. **Publish the skills.**
   - **Claude Code:** for each `skills/<x>/SKILL.md`, read its `name:` field, then copy it
     to `~/.claude/skills/<name>/SKILL.md` and replace the same three placeholders.
   - **Codex:** copy each `skills/<x>/SKILL.md` to `<brain>/.commands/<name>.md` (placeholders
     replaced), and add a "Commands" section to `<brain>/AGENTS.md` listing each command.

3. **Mark it installed.** Create `.central-brain/config.json` at the repo root:
   ```json
   { "name": "Alex", "lang": "English", "brain": "/abs/path/my-brain", "target": "claude", "installed": true }
   ```

4. **Restart your agent** and type `/brain`.

## Updating later

Pull the latest repo and re-run the installer. It **won't overwrite your brain** if it's
already seeded (it checks for `<brain>/_index.md`); it only refreshes the published skills.
To update your brain's structure manually, diff `brain/` against your seeded copy.

## Skill name collisions (Claude Code)

The commands install into your **global** `~/.claude/skills/` under their plain names
(`brain`, `save`, `continue`, `checkpoint`, `contract`, `gate`, `pm`, `research`). If you
already have a skill with one of those names, back it up first or rename the conflicting
`skills/<name>/` folder in your clone before installing (the published command takes the
`name:` from the frontmatter, so rename that field too).

## Uninstall

Central Brain doesn't run any background process — removing it is just deleting files:

- **The commands:** delete the installed skill folders from `~/.claude/skills/` (Claude Code)
  or the `<brain>/.commands/` files and the "Installed commands" section in
  `<brain>/AGENTS.md` (Codex).
- **The setup gate:** delete `.central-brain/config.json` in the repo (so onboarding can run
  again).
- **Your brain:** it's your data — keep it, move it, or delete the folder. Nothing else
  references it.
