# Git Rebase & Cherry‑pick Cheatsheet

## Rebase (squash commits)
- Start interactive rebase for last N commits: `git rebase -i HEAD~N`
- In editor, change `pick` to `squash` (or `s`) for commits to combine.
- Save, then edit the combined commit message.
- If conflicts occur: resolve, `git add`, then `git rebase --continue`.

## Cherry‑pick (apply a specific commit)
- `git cherry-pick <commit-hash>`
- Or from a branch: `git cherry-pick <branch-name>` (picks its tip).
- If conflict: resolve, `git add`, then `git cherry-pick --continue`.
