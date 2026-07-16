# Using Central Brain with Codex

Claude Code has native skills (slash-commands in `~/.claude/skills/`). Codex doesn't — it
reads an `AGENTS.md` file. Central Brain bridges the gap so you get the same experience.

## What the Codex install does

Running the installer with `--target codex`:

1. **Seeds your brain** into the folder you chose (same as Claude Code).
2. **Writes each skill as a prompt file** under `<brain>/.commands/` — e.g.
   `save.md`, `continue.md`, `gate.md`. These are the exact same instructions, just
   published as plain prompts instead of native skills.
3. **Wires them into `<brain>/AGENTS.md`** by appending a "Commands" section that lists
   each command with its trigger phrases.

## How you use it

Open your **brain folder** with Codex (not the template repo — the brain is where you
work). Codex reads `AGENTS.md`, which tells it:

- It is your Brain agent (identity + method).
- Which commands exist and when to use them.

Then you just talk naturally. When you say *"save this"* or *"/save"*, the agent loads
`.commands/save.md` and follows it. Same for `continue`, `checkpoint`, `contract`, `gate`,
`pm`, `research`, and `brain` itself.

## Tips

- If your Codex setup supports custom prompt/command files directly, point it at
  `<brain>/.commands/`.
- The commands are portable markdown — they work in any agent runner that can load a
  prompt file. The `AGENTS.md` "Commands" section is the index.
- Keep the template repo around only for updates; your day-to-day happens in the brain
  folder.

## Switching or using both

You can install both targets against the same brain — run the installer once with
`--target claude` and once with `--target codex`. The brain is shared; each agent gets its
own way of invoking the commands.
