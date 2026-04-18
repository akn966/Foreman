# AGENTS.md

Operational guidance for agents working in this project with Foreman.

## Orchestration model

- main controller: `foreman`
- worker executor: `worker`
- one task branch = one worktree
- one worker = one assigned worktree

## Core rules

- builds and validation must run in the target project worktree
- follow-up bugfixes should reuse the original task branch and worktree when possible
- task state should be tracked through the Foreman task registry
- orchestration logic belongs to the controller; implementation belongs to workers

## Expected workflow

1. User talks to the controller in chat.
2. The controller decides whether to create or reuse a task.
3. The controller allocates branch/worktree.
4. A worker executes the task in the assigned worktree.
5. The controller runs validation/build in that worktree.
6. The controller manages commit/push/PR flow.
7. If a bug is reported later, the controller resumes the same task context.

## Foreman source

Canonical source:
- `https://github.com/akncx/Foreman`
