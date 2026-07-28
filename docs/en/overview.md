# Overview

Viktor is a quiet daily assistant for tracking your health. It records how you felt, your weight, sleep, exercise, and meals, then generates weekly and monthly reports.

## Features

- Daily health tracking
- Mood classification into `positive`, `negative`, or `neutral`
- Weekly report with averages and BMI category
- Monthly report with BMI trend
- JSON-based storage
- Supports input in English and Portuguese

## Requirements

- Ruby 3.0 or higher
- Bundler

## Main files

- `src/main.rb` - application entry point
- `src/controllers/assistant.rb` - execution flow and menu logic
- `src/views/cli.rb` - user input/output
- `src/services/analyzer.rb` - mood classifier interface
- `src/models/bayes.rb` - Naive Bayes algorithm
- `src/models/health.rb` - BMI calculation and category
- `src/services/storage.rb` - JSON read/write
