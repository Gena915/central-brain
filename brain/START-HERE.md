# 👋 Welcome, {{NAME}} — start here

This is **your brain**. It lives at `{{BRAIN}}` and it's yours forever. From now on your AI
agent treats it as a real second memory: it reads from it before acting, and writes back to
it after. The more you feed it, the more it feels like *your* assistant.

This file is your 5-minute tour. Read it once, then delete it or keep it — your call.

---

## The one habit that makes this work

**Save early, save often.** Every time you close a topic, make a decision, or learn
something, say:

```
/save
```

Your Brain will propose exactly where it goes and file it complete. That's the whole trick:
nothing important ever lives only in a chat that will disappear. If you only remember one
command, remember `/save`.

At the end of a work session, do a `/checkpoint` — it packs up everything so a brand-new
chat can continue as if nothing closed.

---

## Your commands (say `/name` in Claude Code, or the name in Codex)

| Command | Use it to… |
|---|---|
| `/brain` | Wake your Brain and load the map of everything you know. Start here every session. |
| `/save` | Save what just happened, tidy, in the right place. **Your core habit.** |
| `/continue` | Resume a topic with full context, as if you never closed the chat. |
| `/checkpoint` | Close a session leaving a self-sufficient handoff. |
| `/contract` | Turn a fuzzy task into a small, verifiable plan before building. |
| `/gate` | Adversarially verify finished work before trusting it. |
| `/pm` | Turn meeting notes into tasks; track your team. |
| `/research` | Research a topic (brain first, web last) and leave a sourced note. |

Full guide with examples: [the skills reference](https://github.com/Gena915/central-brain/blob/HEAD/docs/skills.md).

---

## Your first 15 minutes

1. **Tell your Brain who you are.** Open [`personal/profile.md`](./personal/profile.md) and
   fill it in — how you work, your main projects, your preferences. This is what makes the
   Brain *yours*. (Or just tell your Brain in chat and say `/save`.)
2. **Delete the example molds.** `work/example-client/` and `agents/example-agent/` are just
   there to show the shape. Copy them for your real clients/agents, then remove the samples.
3. **List your tools.** Edit [`tools/models.md`](./tools/models.md) with the AI models you
   actually use, so your Brain routes tasks well.
4. **Save your first real thing.** Next time you decide or learn something, say `/save` and
   watch it get filed. That's the loop.

---

## How your brain is organized

Seven buckets, each with an `_index.md` map so your Brain navigates fast:

```
knowledge/   your manual + map · methods · learnings   (consulted before acting)
work/        your employer & clients (one repeatable "client mold" each)
personal/    you: profile · data · todos · projects
ideas/       raw ideas to explore later
tools/       which models / tools / stack you use
agents/      the AI agents you run
workspaces/  raw code & projects you build
```

The rules for how things are written and filed live in
[`CONVENTIONS.md`](./CONVENTIONS.md). You rarely need to read them — the skills follow them
for you.

Welcome aboard. Type `/brain` and let's go.
