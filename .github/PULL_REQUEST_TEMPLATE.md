## What this changes
A short description of the change and why.

## Checklist
- [ ] No personal data / real credentials / absolute paths committed (placeholders only).
- [ ] Scripts stay ASCII-only (`scripts/*.ps1`, `scripts/*.sh`).
- [ ] If a skill was added/changed, it installs cleanly on **both** targets (`--target claude`
      and `--target codex`) with no `{{...}}` leftovers.
- [ ] Re-running the installer doesn't clobber an existing brain or duplicate the commands block.
- [ ] Docs updated if the behavior or command list changed.
