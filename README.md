<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./assets/logo.svg">
  <img alt="Viktor" src="./assets/logo-light.svg" width="380">
</picture>

# Viktor

A quiet daily companion for your health.

Viktor asks how your day went, records your weight, sleep, exercise, and meals,
and turns them into weekly and monthly reports. It runs in your terminal and
keeps everything in plain JSON files on your machine.

> [!NOTE]
> Full documentation is in [`docs/`](docs/README.md), mirrored in English and Portuguese.

## Requirements

- Ruby 3.0+
- Bundler

## Installation

```bash
git clone https://github.com/gusutabo/viktor.git
cd viktor
bundle install
```

## Run

```bash
bundle exec ruby src/main.rb
```

Run it from the repository root — `data/` and `logs/` are resolved relative to the
working directory.

## Tests

```bash
bundle exec rspec
```

## Notes

- First-run setup saves your profile to `logs/config.json`.
- Daily, weekly, and monthly records are stored in `logs/`, which is git-ignored.
- Mood classification is a Naive Bayes model trained on `data/day.json`, with
  examples in both English and Portuguese.

## Documentation

| | English | Português |
| --- | --- | --- |
| Overview | [overview](docs/en/overview.md) | [visão geral](docs/pt/overview.md) |
| Installation | [installation](docs/en/installation.md) | [instalação](docs/pt/installation.md) |
| Usage | [usage](docs/en/usage.md) | [uso](docs/pt/usage.md) |
| Architecture | [architecture](docs/en/architecture.md) | [arquitetura](docs/pt/architecture.md) |
| Classifier | [classifier](docs/en/classifier.md) | [classificador](docs/pt/classifier.md) |
| Contributing | [contributing](docs/en/contributing.md) | [contribuição](docs/pt/contributing.md) |
