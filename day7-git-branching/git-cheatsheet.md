# Git Cheat Sheet (from Day7)

## Branching
- Create & switch: `git checkout -b branch-name`
- Switch: `git checkout branch-name`
- List branches: `git branch`

## Merging
- Merge branch into current: `git merge branch-name`
- Abort merge: `git merge --abort`
- After resolving conflict: `git add <file>` then `git commit`

## Stash
- Save changes: `git stash`
- List stashes: `git stash list`
- Apply latest: `git stash pop`

## Log
- Compact history: `git log --oneline --graph`
