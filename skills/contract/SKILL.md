---
name: contract
description: Turn a fuzzy task into an executable contract (a plan in small, verifiable steps) BEFORE executing. Triggers "/contract", "plan out", "break down this task", "plan before starting". It's piece 1 of the universal harness — used at the start of any non-trivial task, especially when running on a cheaper API model, so the model doesn't have to plan on its own. The gate later verifies against this contract.
argument-hint: [the task you want to break down]
---

# Skill: /contract — build the task contract (piece 1 of the harness)

You turn the request into an **executable, verifiable contract** BEFORE touching anything.
This hands the model (especially a cheap API one) the plan, so it doesn't improvise or
hallucinate.

## When to use
At the start of **any non-trivial task**. If it's an obvious one-liner, skip it.

## What you do
1. **Read the real thing first.** Don't plan from memory: open the files/paths the task
   touches and verify names, fields, existing patterns. No inventing paths/APIs/params.
2. **Fill the contract** with this exact structure:

```markdown
# Task contract
## Objective (1 sentence)
## Context / inputs
## Steps (small, numbered) → each with an observable **expected result**
## Success criteria (checklist of observable conditions)
## What NOT to do (out of scope)
## Risks / irreversible steps
```

3. **Golden rule for steps:** each step has an **observable expected result** (so the gate
   can verify it one by one). Small steps > big steps.
4. **Show the contract** and:
   - If ≤5 steps and no risk → proceed and execute.
   - If >5 steps or anything destructive/ambiguous → **wait for the owner's OK** first.
5. Keep the contract (in the chat, or a file if the task is big): `/gate` will use it as the
   acceptance criteria.

## Language & tone
Reply in {{LANG}}, direct, no filler. The contract is concrete, not literature.

## Input
$ARGUMENTS
