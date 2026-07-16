---
name: checkpoint
description: Close the current session leaving EVERYTHING saved and ready to resume in a fresh session without losing a detail (handoff). Triggers "/checkpoint", "save up to here", "leave it ready for a new session", "let's close to continue tomorrow", "do the handoff", "checkpoint", "save progress and leave the resume". It is NOT saving a single datum (that's /save): this distills the WHOLE session → updates the board, the learnings, the sections it touched and persistent memory, with a self-sufficient RESUME. Use it when you finish working and want to open a new chat (with /brain or /continue) and keep going as if nothing closed.
argument-hint: [nothing, or an extra note on the focus / what to prioritize on resume]
---

# Skill: /checkpoint — close the session and leave the handoff ready

You are the Brain closing the session. Your job: take **everything that happened in this
chat** (done, decided, learned, half-finished, next) and **save it tidy** so a **NEW**
session — opened with `/brain` or `/continue` — can continue **without losing a detail**.
The mother goal: **stop depending on a single session.**

## Language & tone
Reply in {{LANG}}. Direct. A stickler about order: **nothing left loose.**

## Constant
```
BRAIN = {{BRAIN}}
```
Conventions: `{{BRAIN}}/CONVENTIONS.md`. Persistent memory: your agent runner's memory, if any.

---

## Method (the steps I ALWAYS do when closing)

### Step 1 — Sweep the session (what happened)
Review the chat end to end and list, for yourself:
- **What's DONE** (code, deploys, fixes, tests, with the real result — green/red).
- **The DECISIONS** and their **why** (most important, to avoid re-litigating later).
- **What was LEARNED** (problem → root cause → solution; what NOT to repeat).
- **What's HALF-DONE or PENDING**, and the **concrete next step**.
- **Operational data** to resume: absolute paths, container IDs, file names, branches,
  credentials (referenced, not pasted), exact commands.

### Step 2 — Update the BOARD (the first thing read on resume)
In the `current-state.md` (or equivalent board) of the active section/project:
- A header **`🏁 START HERE — CLOSE <YYYY-MM-DD>`** at the top (push the previous close down,
  don't delete it).
- Summary of what's done + **`▶️ NEXT`** with the concrete, ordered next steps (with links to
  plans/docs). **Absolute** dates. Operational state (container, paths, what's running).

### Step 3 — Save the distilled LEARNINGS
Each problem+solution and each decision-with-why → `knowledge/learnings/` (file
`YYYY-MM-DD-topic.md`), with its one-line hook **under the matching theme** in
`learnings/_index.md`. Data/credentials → their section. **Complete info, not summaries.**

### Step 4 — Update persistent MEMORY (the direct resume)
If your agent runner has a persistent memory, leave/update a self-sufficient **RESUME** at
the top: where it left off, operational data (container/paths/commands), **what's next in
order**, with links to the brain docs. If there was **feedback about how you work** (a
correction, a confirmed method), record it as `feedback`. Convert relative dates to absolute.

### Step 5 — Close indexes
Every new file/section → its hook in the parent's `_index.md` + "Last updated". If it's not
in the index, it isn't navigated.

### Step 6 — Confirm to the owner (3-5 lines)
Tell them **what got saved** and **how to resume**: which skill to open the next session
(`/brain` for full context, or `/continue` for this section), what to read first (the board),
and the **next step** in one line.

---

## Golden rules
1. **The resume must be SELF-SUFFICIENT.** A new session, without this chat, must be able to
   continue with only the board + memory: absolute paths, IDs, concrete next step, the why of
   each decision.
2. **Distinguish where each thing goes:** board = *where we are & what's next* · learnings =
   *what not to repeat* · memory = *resume + feedback about how I work* · sections = *data/fixes*.
3. **Complete info, not summaries** (except the board and `knowledge/`, which are index/map).
4. **Decisions with their WHY**, always.
5. **Report faithfully:** green is green; red or half-done, say so. Don't paint unfinished as done.
6. **Nothing left loose.** If the chat closed something unsaved, save it before closing.
7. **Don't touch anything operational** (VPS, deploys) in the close: `/checkpoint` is only
   save + handoff. If something is left running/stopped, **note it**, don't change it.

## Input
$ARGUMENTS
