# Usage

```bash
bundle exec ruby src/main.rb
```

## First run

With no `logs/config.json` present, Viktor asks four questions:

| Question | Saved as | Type |
| --- | --- | --- |
| What is your name? | `name` | text |
| How old are you? | `age` | whole number |
| What is your height? (e.g. 1.75) | `height` | metres, decimal |
| Where are you from? | `local` | text |

The answers go to `logs/config.json` and are reused on every later run. Height is
stored in metres because BMI is computed as `weight / height²` — entering `175`
instead of `1.75` will produce nonsense BMI values.

```json
{
  "name": "Ana",
  "age": 31,
  "height": 1.68,
  "local": "Recife"
}
```

On later runs Viktor skips these questions and greets you by name instead.

## The mood question

Right after the greeting, Viktor asks **"How was your day?"** and classifies your
answer, then replies accordingly:

| Classification | Reply |
| --- | --- |
| `positive` | Glad to hear that. |
| `negative` | Hope things get better. |
| `neutral` | Got it. |

Answer in English or Portuguese — the shipped training data covers both. The
question is asked **once per session**, and that single result is the mood
attached to any daily record you save afterwards. See [classifier](classifier.md).

## Main menu

```
[0] Daily status
[1] Weekly report
[2] Monthly report
[3] Quit
```

Type the number and press Enter. Anything else prints `Invalid option.` and the
menu repeats. The menu keeps looping until you choose **Quit**.

### Daily status

Records today's numbers:

| Question | Key | Type |
| --- | --- | --- |
| What is your weight? (kg) | `weight` | whole number |
| How many hours did you sleep? | `sleep_h` | whole number |
| Did you work out today? [Y/N] | `exercise` | `true` / `false` |
| How many meals did you have today? | `meal_c` | whole number |

Saved to `logs/daily/YYYY-MM-DD.json`, along with the session's mood:

```json
{
  "mood": "positive",
  "weight": 72,
  "sleep_h": 7,
  "exercise": true,
  "meal_c": 3
}
```

Notes on the input handling:

- Weight and sleep are read as whole numbers — `72.4` is stored as `72`.
- Only `y` and `yes` (any capitalisation) count as yes; anything else is `false`.
- Running it twice on the same day overwrites that day's file.

### Weekly report

Built from the **7 most recent** files in `logs/daily/`, chosen by filename order.
It does not check that they are consecutive days — with gaps, "the last week" is
simply the last seven records that exist. With no daily records, it prints
`No daily records found.`

| Key | Meaning |
| --- | --- |
| `average_weight` | Mean weight across the records |
| `average_sleep` | Mean hours of sleep |
| `meal_avg` | Mean number of meals |
| `exercise_days` | How many of the records had `exercise: true` |
| `predominant_mood` | Most frequent mood |
| `bmi` | BMI from the **most recent** weight and your configured height |
| `bmi_category` | See the table below |

```json
{
  "average_weight": 72.14,
  "average_sleep": 7.29,
  "meal_avg": 3.0,
  "exercise_days": 4,
  "predominant_mood": "positive",
  "bmi": 25.55,
  "bmi_category": "overweight"
}
```

Printed to the screen and saved to `logs/weekly/YYYY-MM-DD.json`. Averages are
rounded to two decimals.

### Monthly report

Built from the **4 most recent** files in `logs/weekly/` — so generate weekly
reports first, otherwise it prints `No weekly reports found.`

| Key | Meaning |
| --- | --- |
| `average_weight` | Mean of the weekly average weights |
| `average_sleep` | Mean of the weekly average sleep |
| `average_meals` | Mean of the weekly meal averages |
| `total_exercise_days` | Sum of exercise days across the weeks |
| `predominant_mood` | Most frequent weekly predominant mood |
| `current_bmi` | BMI from the most recent weekly report |
| `bmi_evolution` | Newest BMI minus oldest, rounded to two decimals |
| `bmi_trend` | `increased`, `decreased`, or `stable` |

```json
{
  "average_weight": 72.4,
  "average_sleep": 7.1,
  "average_meals": 3.02,
  "total_exercise_days": 15,
  "predominant_mood": "positive",
  "current_bmi": 25.55,
  "bmi_evolution": -0.31,
  "bmi_trend": "decreased"
}
```

Saved to `logs/monthly/YYYY-MM-DD.json`.

## BMI categories

BMI is `weight / height²` with weight in kilograms and height in metres.

| BMI | Category |
| --- | --- |
| below 18.5 | `underweight` |
| 18.5 – 24.9 | `healthy` |
| 25 – 29.9 | `overweight` |
| 30 – 34.9 | `obese1` |
| 35 – 39.9 | `obese2` |
| 40 and above | `obese3` |

These are population-level ranges, not a diagnosis.

## Editing your data

Every file is readable JSON. Fix a typo in a weight, correct your height in
`logs/config.json`, or delete a bad day — Viktor will pick up the change on the
next report. Keep the field names and the `YYYY-MM-DD.json` filenames intact.
