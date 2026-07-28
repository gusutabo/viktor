# Usage

## First use

When you start Viktor for the first time, it will ask for your information:

- name
- age
- height
- location

These details are saved to `logs/config.json` and reused in future runs.

## Daily flow

After the initial setup, Viktor asks:

- "How was your day?"

The answer is classified as `positive`, `negative`, or `neutral`.

## Main menu

The assistant offers the following options:

1. Daily status
2. Weekly report
3. Monthly report
4. Quit

### Daily status

Records the day's data:

- weight in kg
- hours of sleep
- whether you exercised (`Y` / `N`)
- number of meals

The data is saved to `logs/daily/YYYY-MM-DD.json`.

### Weekly report

Generates a report from the last 7 daily records. The report includes:

- average weight
- average sleep
- average meals
- exercise days
- predominant mood
- current BMI
- BMI category

The report is saved to `logs/weekly/YYYY-MM-DD.json`.

### Monthly report

Generates a report from the last 4 weekly reports. The report includes:

- weekly average weight
- weekly average sleep
- weekly average meals
- total exercise days
- predominant mood
- current BMI
- BMI evolution
- BMI trend (`increased`, `decreased`, `stable`)

The report is saved to `logs/monthly/YYYY-MM-DD.json`.
