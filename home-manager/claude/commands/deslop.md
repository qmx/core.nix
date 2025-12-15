---
allowed-tools: Bash(git diff:*), Bash(git log:*), Bash(git branch:*), Read, Edit, Glob, Grep
description: Remove AI code slop
---

# Remove AI code slop

Check the diff against main and remove all AI-generated slop introduced in this branch.

## Context

Current branch: !`git branch --show-current`
Main branch: !`git rev-parse --abbrev-ref origin/HEAD 2>/dev/null | sed 's|origin/||' || echo "main"`

Changes in this branch:
<diff>
!`git diff $(git merge-base HEAD origin/main)..HEAD --stat`
</diff>

## What to remove

- Extra comments that a human wouldn't add or are inconsistent with the rest of the file
- Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted/validated codepaths)
- Casts to `any` to get around type issues
- Any other style that is inconsistent with the file

## Process

1. Review the diff of changed files in this branch
2. For each file, check the surrounding code style and patterns
3. Remove slop that doesn't match the codebase conventions
4. Report at the end with only a 1-3 sentence summary of what you changed
