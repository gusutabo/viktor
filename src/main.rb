# frozen_string_literal: false

require_relative 'views/cli'
require_relative 'controllers/assistant'
require_relative 'models/health'
require_relative 'services/analyzer'
require_relative 'services/storage'

if __FILE__ == $PROGRAM_NAME
  cli      = Cli.new
  storage  = Storage.new
  analyzer = SentimentAnalyzer.new('data/day.json')
  health   = Health.new

  Assistant.new(cli, storage, analyzer, health).greet
end
