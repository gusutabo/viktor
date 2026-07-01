# frozen_string_literal: false

require_relative 'view/cli'
require_relative 'controller/assistant'
require_relative 'model/health'
require_relative 'services/analyzer'
require_relative 'services/storage'

if __FILE__ == $PROGRAM_NAME
  cli      = Cli.new
  storage  = Storage.new
  analyzer = SentimentAnalyzer.new('models/day.json')
  health   = Health.new

  Assistant.new(cli, storage, analyzer, health).greet
end
