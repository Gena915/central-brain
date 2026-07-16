# The skills — what each one is for and how to use it

Central Brain ships with 8 skills. After install they work as slash-commands in Claude Code
(`/save`) and as named prompt-commands in Codex (`save`). Here's exactly what each does,
when to reach for it, and how to use it.

> Rule of thumb: **`/brain` to start, `/save` and `/checkpoint` to never lose anything,
> `/continue` to pick back up, `/contract` + `/gate` to do serious work well.**

---

## 🧠 `/brain` — wake your Brain
**For:** starting any session. It loads the map of everything you know and becomes your fast
general assistant — it can answer, do the task, or hand off to another skill.

**When:** open a new chat in any folder and type `/brain`. It reads your brain's index and
your to-dos, surfaces anything overdue, and is ready.

**How:**
```
/brain
/brain how did we solve the login bug for the acme client?
```
It consults your brain *before* answering, so it uses what you already know instead of
guessing.

---

## 💾 `/save` — save this, tidy
**For:** capturing what just happened so it's never lost. The single most important habit.

**When:** the moment a topic closes, a decision is made, or you learn something. Don't wait.

**How:**
```
/save
/save what we decided about the pricing model
```
It proposes one concrete destination (`section/file`) and you confirm with a yes. It saves
**complete** info (not a summary) and keeps the folder index up to date. Nothing left loose.

---

## ▶️ `/continue` — pick back up
**For:** resuming a topic with full context, as if the last session never closed.

**When:** you come back to a project days later and need everything loaded, not re-explained.

**How:**
```
/continue
/continue acme collections
```
It walks you down to the exact section and loads all of it into the chat, then anchors you:
"here's where we left off, here's what's pending."

---

## 🏁 `/checkpoint` — close the session, leave a handoff
**For:** ending a work session so a *brand-new* chat can continue without losing a detail.

**When:** you're done for the day, or the chat is getting long and you want a clean restart.

**How:**
```
/checkpoint
```
It distills the whole session — what's done, decided, learned, and what's next — into your
board, your learnings, and (if available) persistent memory, with a self-sufficient RESUME.
Next time you `/brain` or `/continue`, you're exactly where you left off.

---

## 📝 `/contract` — plan before you build
**For:** turning a fuzzy task into a small, verifiable plan *before* touching anything.

**When:** any non-trivial task, especially with a cheaper/faster model that shouldn't improvise.

**How:**
```
/contract migrate the auth flow to the new API
```
It reads the real files first, then produces a numbered plan where every step has an
**observable expected result** — so the work can be checked step by step.

---

## ✅ `/gate` — verify before calling it done
**For:** adversarially judging finished work against 5 criteria (meets the contract,
root-cause not a patch, doesn't break anything, no hallucination, minimal-LLM).

**When:** before you trust an important change. Best run by a *different* model than the one
that built it.

**How:**
```
/gate the last change we made
```
It returns `READY` or `BLOCKED` with file:line evidence per criterion. Any ❌ means fix and
re-run. This is what raises quality when you work with cheaper models.

---

## 📋 `/pm` — your project manager
**For:** turning call transcripts into concrete tasks per person, tracking them, and drafting
the message to your team.

**When:** after a meeting, or whenever you want the state of everything pending.

**How:**
```
/pm            (paste a transcript, or ask "what's pending?")
```
First run, it asks you a few things (teammates, your message format) and saves them, so it
gets sharper every time.

---

## 🔎 `/research` — your researcher
**For:** researching a topic — checking your brain first, the web last — and leaving a sourced
report you can act on.

**When:** you need to learn something (a library, a tool's latest version) without polluting
the main chat.

**How:**
```
/research best way to run WhatsApp automation in 2026
```
It saves a dated report with sources under `agents/researcher/results/` and proposes what's
worth distilling into your `tools/` or `knowledge/`.

---

## Adding your own

These 8 are a starting kit, not a limit. To add a skill, drop a
`skills/<name>/SKILL.md` with the right frontmatter and re-run the installer — see
[customize.md](customize.md#adding-your-own-skill).
