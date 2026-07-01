# frozen_string_literal: true

require 'date'
require 'fileutils'

CONFIG_PATH = 'logs/config.json'.freeze

class Assistant
  def initialize(cli, storage, analyzer, health)
    @cli      = cli
    @storage  = storage
    @analyzer = analyzer
    @health   = health

    @date = Date.today
    @cfg  = @storage.load(CONFIG_PATH)
  end

  def greet
    if File.exist?(CONFIG_PATH)
      @cli.say("Hello, #{@cfg['name']}!")
    else
      first_run
    end

    mood = ask_mood
    loop { menu(mood) }
  end

  private

  def first_run
    @cli.say('First time here? Tell me a bit about yourself...')
    @cfg = {
      name: @cli.ask('What is your name?'),
      age: @cli.ask('How old are you?').to_i,
      height: @cli.ask('What is your height? (e.g. 1.75)').to_f,
      local: @cli.ask('Where are you from?')
    }
    @storage.save(CONFIG_PATH, @cfg)
  end

  def ask_mood
    mood = @analyzer.classify(@cli.ask('How was your day?'))

    case mood
    when 'positive' then @cli.say('Glad to hear that.')
    when 'negative' then @cli.say('Hope things get better.')
    else                 @cli.say('Got it.')
    end

    mood
  end

  def record_daily(mood)
    @storage.save("logs/daily/#{@date}.json", {
                    mood: mood,
                    weight: @cli.ask('What is your weight? (kg)').to_i,
                    sleep_h: @cli.ask('How many hours did you sleep?').to_i,
                    exercise: @cli.yes?('Did you work out today? [Y/N]'),
                    meal_c: @cli.ask('How many meals did you have today?').to_i
                  })
  end

  def weekly_report
    files = Dir.glob('logs/daily/*.json').sort.last(7)
    return @cli.say('No daily records found.') if files.empty?

    data = files.map { |f| @storage.load(f) }
    bmi  = @health.bmi(data.last['weight'], @cfg['height'])

    report = {
      average_weight: avg(data, 'weight'),
      average_sleep: avg(data, 'sleep_h'),
      meal_avg: avg(data, 'meal_c'),
      exercise_days: data.count { |d| d['exercise'] },
      predominant_mood: predominant(data.map { |d| d['mood'] }),
      bmi: bmi,
      bmi_category: @health.bmi_category(bmi)
    }

    @storage.save("logs/weekly/#{@date}.json", report)
    puts JSON.pretty_generate(report)
  end

  def monthly_report
    files = Dir.glob('logs/weekly/*.json').sort.last(4)
    return @cli.say('No weekly reports found.') if files.empty?

    data        = files.map { |f| @storage.load(f) }
    bmi_history = data.map { |d| d['bmi'].to_f }
    bmi_delta   = (bmi_history.last - bmi_history.first).round(2)

    report = {
      average_weight: avg(data, 'average_weight'),
      average_sleep: avg(data, 'average_sleep'),
      average_meals: avg(data, 'meal_avg'),
      total_exercise_days: data.sum { |d| d['exercise_days'].to_i },
      predominant_mood: predominant(data.map { |d| d['predominant_mood'] }),
      current_bmi: bmi_history.last,
      bmi_evolution: bmi_delta,
      bmi_trend: if bmi_delta.positive?
                   :increased
                 else
                   bmi_delta.negative? ? :decreased : :stable
                 end
    }

    @storage.save("logs/monthly/#{@date}.json", report)
    puts JSON.pretty_generate(report)
  end

  def avg(data, key)
    (data.sum { |d| d[key].to_f } / data.size).round(2)
  end

  def predominant(list)
    list.compact.tally.max_by { |_, n| n }&.first
  end

  def menu(mood)
    @cli.say('What would you like to do?')
    @cli.menu(
      ['Daily status', 'Weekly report', 'Monthly report', 'Quit'],
      {
        0 => -> { record_daily(mood) },
        1 => -> { weekly_report },
        2 => -> { monthly_report },
        3 => -> { exit }
      }
    )
  end
end
