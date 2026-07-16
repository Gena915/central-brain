# Brain conventions

Rules for how the brain is organized and written. The `/continue` and `/save` skills and
the root `CLAUDE.md`/`AGENTS.md` depend on these. If the conventions change, update them
here.

---

## 1. Anatomy of a section

A **section** is a folder. It can contain:

- **`_index.md`** (required) — the section's "map": what it is + the list of children
  (sub-sections and content files) with a one-line hook each. It is the ONLY thing the
  skills read to navigate fast without opening everything.
- **Sub-sections** — child folders (each with its own `_index.md`).
- **Content files** — the `.md` files with the real info.

## 2. The `_index.md` is the menu

When a skill navigates, it reads the current folder's `_index.md` and shows you the
children. So **the `_index.md` must always reflect what's in the folder**. The `/save`
skill updates the `_index.md` every time it creates a new child.

**Rule:** an inline link in the body (e.g. `see [CONVENTIONS.md](./CONVENTIONS.md)`) does
**not** replace the formal entry in the children list. Every file or folder that lives in
the directory must appear as an item under `## Sections` or `## Content`, even if already
referenced elsewhere. Inline links are navigation; the children list is the inventory.

Template for `_index.md`:

```markdown
# <Section name>

> <what this section is — 1 or 2 lines>

**Path:** <relative path from brain root>
**Last updated:** YYYY-MM-DD

## Sections
- [<child>/](./<child>/) — <1-line hook>

## Content
- [<file>.md](./<file>.md) — <1-line hook>

## Suggested (not yet created)
- <name> — <why it might go here>
```

## 3. Content files: COMPLETE info, not summaries

Hard rule: **not summarized info — info as if it were in the chat itself; good, complete
info.** A content file must leave a future agent (or you) able to **continue as if the
chat had never closed**: context, decisions, reasons, numbers, credential-references, what
is pending. Don't summarize to save space.

Template for a content file:

```markdown
# <Topic title>

**Section:** work/acme/collections
**Date:** YYYY-MM-DD
**Tags:** <keywords for search>

## Context
<everything needed to understand this, assuming no prior memory>

## Current state
<where the thing is today>

## Decisions made
<what was decided and WHY>

## Pending / next steps
- [ ] ...

## Detail / transcript
<the long, complete info: steps, commands, data, whatever>
```

## 4. File names

- Folders and files in `kebab-case`, no accents, in your language.
- Content files may carry a date prefix if chronological:
  `2026-05-30-setup-collections.md`. If they are "living" (updated over time), no date:
  `current-state.md`.

## 5. Credentials

Sensitive credentials do **not** go in plaintext in the versioned brain. They go in
`<section>/.secrets/` (gitignored) or you reference where they live (e.g. "SSH key in
`~/.ssh/`"). In the content you leave the **pointer**, not the secret.

## 6. Nothing left loose

If a chat closes a topic, makes a decision, or learns something, **it must end up saved in
its section**. The root identity requires offering `/save` before closing. If it fits no
existing section, create a new one — but don't leave it floating.
