# Architecture

Viktor is organized into simple layers that separate interface, business logic, and persistence.

## `src/main.rb`

- Initializes the main components
- Creates `Cli`, `Storage`, `SentimentAnalyzer`, and `Health`
- Starts the assistant with `Assistant.new(...).greet`

## `src/controllers/assistant.rb`

- Controls the application flow
- Manages menu and report execution
- Loads and saves configuration
- Uses `Storage` to persist JSON
- Uses `Health` to compute BMI
- Uses `SentimentAnalyzer` to classify mood

## `src/views/cli.rb`

- Handles user input and output via terminal
- Displays prompts and menus
- Interprets `Y/N` responses

## `src/services/analyzer.rb`

- Reads the `models/day.json` file
- Trains the Naive Bayes classifier
- Sanitizes and classifies user text

## `src/models/bayes.rb`

- Implements the Naive Bayes classifier
- Uses simple tokenization and Laplace smoothing
- Computes probabilities from training data

## `src/models/health.rb`

- Calculates BMI: weight / height²
- Returns BMI category based on defined ranges

## `src/services/storage.rb`

- Saves data in formatted JSON
- Loads data if the file exists
- Creates required directories automatically
