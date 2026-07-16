# agents/ — the AI agents you run

> The AI agents that are part of your Brain (like the PM and Researcher skills), plus any
> custom agents you build. Definition and results per agent.

**Path:** agents/
**Last updated:** seeded on install

## Sections
- [pm/](./pm/) — your project manager agent's files (used by `/pm`).
- [researcher/](./researcher/) — your researcher agent's output (used by `/research`).
- [example-agent/](./example-agent/) — sample agent folder (copy it per real agent, then delete).

## The agent mold
Each agent folder holds its definition (what it does, its method) and a place for its
outputs/results (e.g. `results/` for a researcher, `reports/` for a monitor).
