---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git reset:*), Bash(git add:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(git rebase:*)
description: Create a git commit
---

# resetting staged

`!git reset HEAD .`

## Context

Current branch: !`git branch --show-current`

Current git status:
<status>
!`git status`
</status>

Recent commits:
<log>
!`git log --oneline -10`
</log>

## Your task

Based on the local changes:

* If the local changes are one logical unit of work, create a single commit.
* If there are multiple unrelated units of work, split them into separate granular commits (up to 5). Do this automatically without asking - just proceed with the granular commits.

## Reminders

* write a good commit message with excellent first line, bullet point list in summary.
* Under no circumstances commit binaries or large (1mb+) files, please stop the process and warn of those first and wait for me to decide what to do.
* Do not mention claude or any ai in the commit message.
