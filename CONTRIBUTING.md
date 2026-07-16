# Contributing to Central Brain

Thanks for wanting to make Central Brain better. It's a small, dependency-free project, so
contributing is easy.

## Ways to help

- **New skills.** A well-scoped skill that many people would use (a reviewer, a planner, a
  daily standup helper). See below.
- **Install robustness.** Make the installer work on more shells/environments.
- **Docs.** Clearer onboarding, examples, translations.
- **Bug reports.** Something didn't install or a skill behaved wrong — open an issue.

## Ground rules

- **No personal data.** This is a public template. Never commit real names, credentials,
  clients, or absolute paths from your own brain. Use the `{{BRAIN}}` / `{{NAME}}` /
  `{{LANG}}` placeholders.
- **ASCII in scripts.** Keep `scripts/*.ps1` and `scripts/*.sh` ASCII-only (no em-dashes or
  smart quotes) so Windows PowerShell 5.1 parses them without a BOM.
- **Skills are self-contained.** Each skill is one `skills/<name>/SKILL.md` with frontmatter
  (`name`, `description`, `argument-hint`) and clear step-by-step instructions.
- **Keep it portable.** Anything that works in one agent should have a path to the other
  (Claude Code and Codex).

## Adding a skill

1. Create `skills/<your-skill>/SKILL.md`:
   ```markdown
   ---
   name: your-skill
   description: What it does + the trigger phrases the agent should recognize.
   argument-hint: [what to pass, or nothing]
   ---
   # Skill: /your-skill — ...
   Reply in {{LANG}}. The brain is at {{BRAIN}}.
   ...clear, numbered instructions...
   ```
2. Use the placeholders — the installer resolves them per user.
3. Test both targets: `bash scripts/install.sh --brain /tmp/test-brain --name Test --lang English --target claude`
   (and `--target codex`), then verify the skill installed with no leftover `{{...}}`.
4. Open a PR describing what the skill does and when to use it.

## Testing your change

Run the installer against a throwaway brain and a throwaway `HOME`, and confirm:
- All skills install / all commands publish.
- No `{{BRAIN}}` / `{{NAME}}` / `{{LANG}}` leftovers in the output.
- Re-running doesn't clobber an existing brain or duplicate the commands block.

That's it. Thanks for helping.
