# Overview

Viktor is a quiet daily assistant for tracking your health. It asks how your day
went, records your weight, sleep, exercise, and meals, and turns those records
into weekly and monthly reports.

It runs entirely in your terminal. There is no account, no network access, and no
database — every record is a JSON file under `logs/`, which is git-ignored.

## What a session looks like

1. Viktor greets you (first run asks for name, age, height, and location).
2. It asks *"How was your day?"* and classifies your answer as `positive`,
   `negative`, or `neutral`.
3. It shows a menu: record today's numbers, print a weekly report, print a
   monthly report, or quit.
4. The menu loops until you choose **Quit**.

Full walkthrough in [usage](usage.md).

## Features

- Daily tracking of mood, weight, sleep hours, exercise, and meal count
- Mood classification with a Naive Bayes model trained on `data/day.json`
- Weekly report: averages over the last 7 daily records, plus BMI and its category
- Monthly report: averages over the last 4 weekly reports, plus BMI trend
- Plain JSON storage you can read, edit, back up, or delete by hand
- Training data ships with both English and Portuguese examples

## Requirements

- Ruby 3.0 or higher
- Bundler

## Main files

| File | Responsibility |
| --- | --- |
| `src/main.rb` | Entry point; builds the objects and starts the assistant |
| `src/controllers/assistant.rb` | Execution flow, menu, report generation |
| `src/views/cli.rb` | Terminal input and output |
| `src/services/analyzer.rb` | Loads training data, exposes `classify(text)` |
| `src/models/bayes.rb` | The Naive Bayes algorithm itself |
| `src/models/health.rb` | BMI calculation and category |
| `src/services/storage.rb` | JSON read and write |
| `data/day.json` | Training examples for the mood classifier |

How these fit together: [architecture](architecture.md).

## What Viktor is not

- Not medical advice. BMI categories follow the usual WHO ranges and say nothing
  about an individual.
- Not multi-user. One profile per checkout, in `logs/config.json`.
- Not synced anywhere. If you delete `logs/`, the history is gone.
