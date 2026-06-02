# Viktor

A quiet daily companion for your health.

> [!NOTE]
> This project started while I was reading Muito Mais Que Emagrecer, from the Sorria collection with Marcio Atalla. The book got me thinking about how much those small daily choices matter — sleep, food, mood, exercise — and I wanted a simple way to keep track of them.

## Requirements

- Ruby 3.0+
- Bundler

## Installation

Clone the repository and install the dependencies:

```bash
git clone https://github.com/gusutabo/viktor.git
cd viktor
bundle install
```

## Getting Started

Run Viktor with:

```bash
ruby viktor.rb
```

The first time you run it, Viktor will introduce itself and ask a few questions to set up your profile:

```
VIKTOR: First time here? Tell me a bit about yourself...
VIKTOR: What is your name?
>>> Gustavo
VIKTOR: How old are you?
>>> 22
VIKTOR: What is your height? (e.g. 1.75)
>>> 1.80
VIKTOR: Where are you from?
>>> Brazil
```

Your profile is saved to `logs/config.json` and reused in every future session.

## Daily Session

Every session starts with Viktor asking how your day went:

```
VIKTOR: How was your day?
>>> felt really good today
VIKTOR: Glad to hear that.
VIKTOR: What would you like to do?
[0] Daily status
[1] Weekly report
[2] Monthly report
[3] Quit
```

Your response is automatically classified as `positive`, `negative`, or `neutral` using a Naive Bayes model trained on `models/day.json`. The classifier supports both English and Portuguese input.

## Available Actions

### Daily Status

Logs your health data for the day:

- Weight (kg)
- Hours of sleep
- Whether you worked out (`Y` / `N`)
- Number of meals

Records are saved to `logs/daily/YYYY-MM-DD.json`.

### Weekly Report

Summarizes the last 7 daily records:

| Metric | Description |
|--------|-------------|
| Average weight | Mean weight over the period |
| Average sleep | Mean hours of sleep |
| Average meals | Mean number of meals |
| Exercise days | Days you worked out |
| Predominant mood | Most frequent mood classification |
| BMI | Calculated from your latest weight and height |
| BMI category | See table below |

Saved to `logs/weekly/YYYY-MM-DD.json`.

### Monthly Report

Summarizes the last 4 weekly reports:

| Metric | Description |
|--------|-------------|
| Average weight | Mean across weekly averages |
| Average sleep | Mean across weekly averages |
| Average meals | Mean across weekly averages |
| Total exercise days | Sum across all weeks |
| Predominant mood | Most frequent mood across weeks |
| Current BMI | BMI from the most recent week |
| BMI evolution | Change from first to last week |
| BMI trend | `increased`, `decreased`, or `stable` |

Saved to `logs/monthly/YYYY-MM-DD.json`.

## BMI Categories

| BMI Range | Category |
|-----------|----------|
| < 18.5 | underweight |
| 18.5 – 24.9 | healthy |
| 25.0 – 29.9 | overweight |
| 30.0 – 34.9 | obese_1 |
| 35.0 – 39.9 | obese_2 |
| ≥ 40.0 | obese_3 |

## Training Data

The sentiment classifier is trained from `models/day.json`. Each entry needs a `text` (the phrase) and a `category` (`positive`, `negative`, or `neutral`):

```json
[
  { "text": "today was amazing", "category": "positive" },
  { "text": "foi um dia horrível", "category": "negative" },
  { "text": "just a normal day", "category": "neutral" }
]
```

The more examples you add, the better the classifier gets — especially for phrases you actually use day-to-day.

## Contributing

Contributions are welcome! Here's how to get started:

1. Fork the repository
2. Create a branch for your feature (`git checkout -b feature/my-feature`)
3. Make your changes and commit them (`git commit -m 'Add my feature'`)
4. Push to your branch (`git push origin feature/my-feature`)
5. Open a Pull Request

Please keep the code simple and consistent with the existing style.

## License

This project is intended for educational and personal use.