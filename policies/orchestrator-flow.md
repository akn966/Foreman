# Orchestrator execution flow

## New task flow
1. Parse the request.
2. Determine task name, branch, and worktree.
3. Register the task in local state.
4. Create the worktree.
5. Delegate implementation to a worker.
6. Run validation/build in that worktree.
7. Review git status and diff.
8. Commit and push when needed.
9. Create or update a PR.
10. Persist build result and PR URL back to task state.

## Resume task flow
1. Read task registry.
2. Match the task by name, branch, worktree, or subsystem.
3. Reuse the same worktree and branch.
4. Update task status to active.
5. Delegate another worker iteration.
6. Rebuild, push, and update the same PR when possible.
