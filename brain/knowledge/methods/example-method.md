# Example method — the task harness (delete or adapt)

**Section:** knowledge/methods
**Date:** seeded on install
**Tags:** example, method, harness, quality

## Context
This is a sample `methods/` file so you can see the mold. Replace it with your own proven
methods. A method file captures *how you do a kind of work well*, once, so no agent ever
has to re-derive it.

## The method: contract → build → gate
A lightweight quality harness that pairs with the `/contract` and `/gate` skills:

1. **Contract first.** For any non-trivial task, turn the fuzzy ask into a checklist of
   small, observable steps before touching anything (`/contract`).
2. **Build** against the contract.
3. **Gate.** Judge the finished work adversarially against 5 criteria — meets the contract,
   root-cause (not a patch), doesn't break anything, no hallucination, minimal-LLM — with
   file:line evidence, and return READY or BLOCKED (`/gate`).

**Golden rule:** the one who verifies is never the one who built. Run the gate in a
separate session or model when it matters.

## Why it's here
So the Brain reaches for a proven flow instead of improvising, especially on important or
irreversible work.
