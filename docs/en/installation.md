# Installation

Follow these steps to set up the Viktor project.

## Clone the repository

```bash
git clone https://github.com/gusutabo/viktor.git
cd viktor
```

## Install dependencies

```bash
bundle install
```

## Run

```bash
bundle exec ruby src/main.rb
```

> Note: the main entry file is `src/main.rb`.

## Data file structure

- `logs/config.json` - user profile
- `logs/daily/YYYY-MM-DD.json` - daily records
- `logs/weekly/YYYY-MM-DD.json` - weekly reports
- `logs/monthly/YYYY-MM-DD.json` - monthly reports
- `models/day.json` - training data for the mood classifier
