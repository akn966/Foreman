# Foreman

## English

Foreman is a plugin-first orchestration package for Factory Droid.

It turns the main chat into a repository orchestrator that can inspect a repo, split work into independent streams, propose a plan, and launch real worker subagents for execution.

Canonical repository:
- `https://github.com/akncx/Foreman`

## What this plugin provides

- `/foreman` slash entrypoint
- a reusable `foreman` orchestration skill
- a `foreman` droid for coordination
- a `worker` droid for delegated execution

## Operating model

- main chat = orchestrator
- `worker` subagents = executors
- one independent workstream usually maps to one branch and one worktree
- repository inspection happens locally through Droid tools, not web fetch
- runtime state, if needed, lives in the target repo under `.foreman/`

## Example

```text
/foreman Refactor A, B, C
```

Expected behavior:

1. inspect the current repository
2. split the request into workstreams where safe
3. propose a concise plan
4. after confirmation, create branch/worktree strategy
5. launch `worker` subagents through `Task`
6. aggregate results and run validation

## Repository layout

- `.factory-plugin/marketplace.json` — single-plugin marketplace manifest
- `.factory-plugin/plugin.json` — plugin manifest
- `skills/foreman/SKILL.md` — orchestration logic
- `droids/foreman.md` — coordinator droid
- `droids/worker.md` — execution droid

## Local development

Install from the local directory:

```bash
droid plugin marketplace add .
droid plugin install foreman@Foreman
```

Then invoke:

```text
/foreman <your request>
```

## Install from GitHub marketplace source

This repository is published as a single-plugin marketplace.

Register the repository as a marketplace source:

```bash
droid plugin marketplace add https://github.com/akncx/Foreman
```

Install the plugin:

```bash
droid plugin install foreman@Foreman
```

Update later with:

```bash
droid plugin update foreman@Foreman
```

## Design constraints

- no dependency on repository scripts
- no bundled bootstrap state
- no web fetch for local repository understanding
- orchestration logic lives in the plugin assets themselves

## Marketplace readiness checklist

- plugin manifest with required metadata
- installable root plugin layout
- reusable skill in `skills/`
- custom droids in `droids/`
- no machine-specific scripts or local bootstrap dependencies

---

## Русский

Foreman — это plugin-first пакет оркестрации для Factory Droid.

Он превращает основной чат в оркестратор репозитория: агент исследует проект, разбивает задачу на независимые потоки работы, предлагает план и запускает реальные worker-subagent’ы для выполнения.

Канонический репозиторий:
- `https://github.com/akncx/Foreman`

## Что даёт этот плагин

- slash-entrypoint `/foreman`
- переиспользуемый orchestration skill `foreman`
- droid `foreman` для координации
- droid `worker` для делегированного выполнения

## Модель работы

- основной чат = оркестратор
- `worker` subagent’ы = исполнители
- один независимый workstream обычно соответствует одной ветке и одному worktree
- исследование репозитория происходит локально через инструменты Droid, а не через web fetch
- runtime state при необходимости хранится в целевом репозитории в `.foreman/`

## Пример

```text
/foreman Refactor A, B, C
```

Ожидаемое поведение:

1. исследовать текущий репозиторий
2. разбить запрос на workstream’ы, если это безопасно
3. предложить краткий план
4. после подтверждения определить стратегию branch/worktree
5. запустить `worker` subagent’ов через `Task`
6. собрать результаты и прогнать валидацию

## Структура репозитория

- `.factory-plugin/marketplace.json` — manifest single-plugin marketplace
- `.factory-plugin/plugin.json` — manifest плагина
- `skills/foreman/SKILL.md` — orchestration logic
- `droids/foreman.md` — coordinating droid
- `droids/worker.md` — execution droid

## Локальная разработка

Установка из локальной директории:

```bash
droid plugin marketplace add .
droid plugin install foreman@Foreman
```

Затем вызов:

```text
/foreman <ваш запрос>
```

## Установка из GitHub marketplace source

Этот репозиторий опубликован как single-plugin marketplace.

Добавьте репозиторий как marketplace source:

```bash
droid plugin marketplace add https://github.com/akncx/Foreman
```

Установите плагин:

```bash
droid plugin install foreman@Foreman
```

Позже обновляйте так:

```bash
droid plugin update foreman@Foreman
```

## Ограничения дизайна

- нет зависимости от repository scripts
- нет встроенного bootstrap state
- нет web fetch для понимания локального репозитория
- вся orchestration logic живёт внутри assets самого плагина

## Checklist готовности к marketplace

- plugin manifest с нужными metadata
- installable root plugin layout
- переиспользуемый skill в `skills/`
- custom droids в `droids/`
- нет machine-specific scripts или локальных bootstrap dependencies
