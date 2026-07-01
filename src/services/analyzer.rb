# frozen_string_literal: true

require 'json'

require_relative '../model/bayes'

class SentimentAnalyzer
  def initialize(training_file)
    @classifier = Bayes.new

    JSON.parse(File.read(training_file)).each do |row|
      @classifier.train(
        row['category'],
        sanitize(row['text'])
      )
    end
  end

  def classify(text)
    @classifier.classify(
      sanitize(text)
    )
  end

  private

  def sanitize(text)
    text.downcase.gsub(/[^\p{Alnum}\s]/, '')
  end
end
