# Mood Classifier

Viktor uses a Naive Bayes classifier to categorize the user's daily input into `positive`, `negative`, or `neutral`.

## Relevant files

- `src/services/analyzer.rb` - loads the training file and exposes `classify(text)`
- `src/models/bayes.rb` - implements the Naive Bayes classifier
- `models/day.json` - training data for the classifier

## How the classifier works

1. The text is sanitized to lowercase and non-alphanumeric characters are removed.
2. Each word is tokenized by the regex `\p{Alnum}+`.
3. The model computes posterior probability for each category using Laplace smoothing.
4. The category with the highest score is returned.

## Training format

The file `models/day.json` should contain a list of JSON objects with fields:

- `text` - sample phrase
- `category` - `positive`, `negative`, or `neutral`

Example:

```json
[
  { "text": "today was amazing", "category": "positive" },
  { "text": "foi um dia horrível", "category": "negative" },
  { "text": "just a normal day", "category": "neutral" }
]
```

## Extensions

Adding more examples to `models/day.json` improves classifier accuracy, especially for the user's natural language style.
