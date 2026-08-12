# Architecture

Viktor separates interface, flow control, domain logic, and persistence. Each
class does one thing and receives its collaborators from outside, which is what
makes the suite in `spec/` easy to write.

## Flow

```
main.rb
  builds Cli, Storage, SentimentAnalyzer, Health
  └── Assistant#greet
        ├── Cli            asks and prints
        ├── SentimentAnalyzer → Bayes    classifies the day
        ├── Health                       BMI and category
        └── Storage                      reads and writes JSON in logs/
```

`Assistant` is the only class that knows the sequence of steps. `Cli` knows
nothing about health, `Health` knows nothing about files, and `Storage` knows
nothing about what it is storing.

## `src/main.rb`

Entry point, guarded by `if __FILE__ == $PROGRAM_NAME`. It builds the four
collaborators, injects them into `Assistant`, and calls `greet`. The training
file path (`data/day.json`) is wired in here.

## `src/controllers/assistant.rb`

Owns the application flow.

- `greet` — greets you, or runs the first-run questions; asks the mood, then loops the menu
- `first_run` — collects the profile and saves `logs/config.json`
- `ask_mood` — classifies the answer and responds in kind
- `record_daily(mood)` — writes `logs/daily/YYYY-MM-DD.json`
- `weekly_report` — aggregates the last 7 daily files
- `monthly_report` — aggregates the last 4 weekly files
- `avg`, `predominant` — small aggregation helpers

The date comes from `Date.today`, captured when `Assistant` is constructed, and
is used for every filename written in that session. `CONFIG_PATH` is a top-level
constant, so the profile location is fixed at `logs/config.json`.

## `src/views/cli.rb`

The only class that touches `stdin` and `stdout`.

- `ask(msg)` — prints a prompt, returns the trimmed answer
- `say(msg)` — prints a `VIKTOR:` line
- `yes?(msg)` — true for `y` or `yes`
- `menu(options, actions)` — numbers the options and calls the matching lambda

Colour is emitted only when stdout is a TTY, `NO_COLOR` is unset, and `TERM` is
not `dumb`, so piping the output to a file gives plain text.

## `src/services/analyzer.rb`

Wraps `Bayes` behind a small interface.

- `new(training_file)` — reads the JSON, sanitizes each example, trains the model
- `classify(text)` — sanitizes and delegates
- `sanitize(text)` — lowercases and strips non-alphanumeric characters

Training happens once, in the constructor, at startup.

## `src/models/bayes.rb`

The algorithm, with no knowledge of moods or files.

- `train(category, text)` — counts documents, words per category, and vocabulary
- `classify(text)` — highest posterior score wins; raises if never trained
- Scores are summed in log space; likelihoods use Laplace smoothing

Details in [classifier](classifier.md).

## `src/models/health.rb`

- `bmi(weight, height)` — `weight / height²`, rounded to two decimals
- `bmi_category(bmi)` — a symbol from `:underweight` to `:obese3`

Pure functions: no state, no I/O.

## `src/services/storage.rb`

- `save(path, data)` — creates the parent directory, writes pretty-printed JSON
- `load(path)` — parses the file, or returns `{}` when it does not exist

Because `load` returns an empty hash for a missing file, callers can start with
no data on disk without special-casing it.

## Conventions

- JSON is written with symbol keys and read back with string keys, so records are
  read as `record['weight']`, never `record[:weight]`.
- Symbols such as `:healthy` and `:increased` serialize as plain strings.
- Files are named `YYYY-MM-DD.json`, which sorts chronologically — the reports
  rely on that when they take `.sort.last(7)`.
