# Viktor

A quiet daily companion for your health.

> [!NOTE]
> Full project documentation is available in `[docs/](./docs/)` with separate English and Portuguese folders.

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

## Notes

- First-run setup saves your profile to `logs/config.json`.
- Daily, weekly, and monthly data are stored in `logs/`.
- Mood classification is handled by a Naive Bayes model trained on `models/day.json`.

For detailed usage, architecture, and contribution guidelines, see `docs/README.md`.
