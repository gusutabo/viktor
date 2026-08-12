# Mood Classifier

Viktor classifies your answer to *"How was your day?"* as `positive`, `negative`,
or `neutral`, using a Naive Bayes model trained at startup from a JSON file.

## Relevant files

| File | Role |
| --- | --- |
| `src/services/analyzer.rb` | Loads the training file, exposes `classify(text)` |
| `src/models/bayes.rb` | The Naive Bayes implementation |
| `data/day.json` | Training examples |
| `spec/services/analyzer_spec.rb`, `spec/models/bayes_spec.rb` | Tests |

## How it works

1. **Sanitize** — the text is lowercased and every non-alphanumeric character
   (except whitespace) is removed. Accents survive, since `\p{Alnum}` is
   Unicode-aware: `incrível` stays one token.
2. **Tokenize** — the text is split on `\p{Alnum}+`, giving a plain bag of words.
   Order is ignored, and so is any word not seen during training.
3. **Score** — each category gets `log(prior) + Σ log(likelihood(word))`, summed
   in log space to avoid underflow on long sentences.
4. **Pick** — the highest-scoring category wins.

Where:

- `prior(category)` = documents in that category ÷ total documents
- `likelihood(word, category)` = `(count + 1) / (words in category + vocabulary size)`

The `+1` is Laplace smoothing: it keeps an unseen word from zeroing out a whole
category. A completely unknown sentence falls back to the priors, so the category
with the most training examples wins by default.

## Training data

`data/day.json` is a list of objects with two fields:

- `text` — an example sentence
- `category` — `positive`, `negative`, or `neutral`

```json
[
  { "text": "hoje foi um dia incrível, me sinto muito bem", "category": "positive" },
  { "text": "estou exausto e desanimado", "category": "negative" },
  { "text": "just a normal day", "category": "neutral" }
]
```

It ships with 92 examples across the three categories, in Portuguese and English,
which is why Viktor understands either language.

## Improving accuracy

Add examples in your own words. Phrases you actually type are worth far more than
generic ones.

1. Append entries to `data/day.json`, keeping the categories balanced — an
   oversized category wins ties through its prior.
2. Prefer short, natural sentences over long ones; each word contributes equally.
3. Restart Viktor. Training happens once, in the constructor, so a running
   session will not see your edits.

To try a different dataset without touching the default, point `main.rb` at
another file — `SentimentAnalyzer.new('data/day.json')` takes any path.

## Known limits

- Bag of words: *"not a good day"* and *"a good day"* look nearly identical, since
  negation is just another token.
- No stemming: `cansado` and `cansada` are unrelated tokens, and each needs its
  own examples.
- Mixed languages in one sentence work, but only for words present in training.
- `classify` raises `No training data available` if the model was never trained,
  which in practice means an empty or unreadable training file.
