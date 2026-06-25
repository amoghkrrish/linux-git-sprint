# Git Undo Cheatsheet (Day8)

| Command | Effect | Use case |
|---------|--------|----------|
| `git reset --soft HEAD~1` | Undo commit, keep changes staged | Forgot a file |
| `git reset --mixed HEAD~1` | Undo commit, unstage, keep changes | Rewrite commit |
| `git reset --hard HEAD~1` | Undo commit, discard changes | Local mess, never pushed |
| `git revert HEAD` | New commit that undoes a commit | Undo pushed commit safely |
| `git stash -u -m "msg"` | Save uncommitted work (with untracked) | Switch context |
| `git stash pop` | Apply latest stash and drop it | Resume work |
| `git clean -fd` | Delete all untracked files/dirs | Clean up build artifacts |
