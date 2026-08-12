# Viktor Documentation

Viktor is a terminal companion that asks how your day went, records a few health
numbers, and turns them into weekly and monthly reports. Everything is stored as
plain JSON on your own machine.

Documentation is kept in two mirrored languages. Both cover the same ground, so
pick one and stay in it.

| Topic | English | Português |
| --- | --- | --- |
| What Viktor is and what it does | [overview](en/overview.md) | [visão geral](pt/overview.md) |
| Setting it up and running it | [installation](en/installation.md) | [instalação](pt/installation.md) |
| Day-to-day use, menus, saved files | [usage](en/usage.md) | [uso](pt/usage.md) |
| How the code is laid out | [architecture](en/architecture.md) | [arquitetura](pt/architecture.md) |
| The mood classifier | [classifier](en/classifier.md) | [classificador](pt/classifier.md) |
| Contributing and running the tests | [contributing](en/contributing.md) | [contribuição](pt/contributing.md) |

Visual identity — logo, palette, typography — lives in [brand](brand/README.md).

## Where to start

- **Just want to use it?** Read [installation](en/installation.md), then [usage](en/usage.md).
- **Want to change the code?** Read [architecture](en/architecture.md), then [contributing](en/contributing.md).
- **Want better mood detection?** Read [classifier](en/classifier.md) — it is mostly a matter of adding examples to `data/day.json`.

## Conventions used in these docs

- Paths are relative to the repository root.
- Commands assume you are in the repository root and have run `bundle install`.
- Category names (`positive`, `negative`, `neutral`) and JSON keys are written
  exactly as they appear on disk, in English, even in the Portuguese docs.
