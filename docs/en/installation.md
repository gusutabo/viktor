# Installation

## Requirements

- Ruby 3.0 or higher
- Bundler

Check what you have:

```bash
ruby -v
bundle -v
```

If Bundler is missing: `gem install bundler`.

## Clone the repository

```bash
git clone https://github.com/gusutabo/viktor.git
cd viktor
```

## Install dependencies

```bash
bundle install
```

The only dependency is RSpec, used by the test suite. Viktor itself runs on the
Ruby standard library.

## Run

```bash
bundle exec ruby src/main.rb
```

Run it from the repository root. Paths such as `data/day.json` and `logs/` are
resolved relative to the working directory, so starting it from elsewhere will
fail to find the training data.

## Run the tests

```bash
bundle exec rspec
```

## Repository layout

```
viktor/
├── src/            application code
│   ├── main.rb
│   ├── controllers/
│   ├── models/
│   ├── services/
│   └── views/
├── spec/           RSpec tests, mirroring src/
├── data/
│   └── day.json    training data for the mood classifier
├── docs/           this documentation (en/ and pt/)
├── assets/         logo and brand files
└── logs/           your records, created on first run (git-ignored)
```

## Files Viktor writes

Everything Viktor produces lives under `logs/`, and none of it is committed:

| Path | Contents |
| --- | --- |
| `logs/config.json` | Your profile: name, age, height, location |
| `logs/daily/YYYY-MM-DD.json` | One record per day |
| `logs/weekly/YYYY-MM-DD.json` | Weekly report, dated when generated |
| `logs/monthly/YYYY-MM-DD.json` | Monthly report, dated when generated |

Directories are created automatically on first write.

## Starting over

Delete the profile to trigger the first-run questions again:

```bash
rm logs/config.json
```

Delete `logs/` entirely to erase all history. There is no undo.
