# frozen_string_literal: true

require 'spec_helper'
require 'json'
require 'services/analyzer'
require 'tempfile'

RSpec.describe SentimentAnalyzer do
  let(:training_file) { Tempfile.new(['training', '.json']) }

  before do
    training_data = [
      { 'category' => 'positive', 'text' => 'great wonderful excellent' },
      { 'category' => 'negative', 'text' => 'bad awful terrible' }
    ]

    training_file.write(training_data.to_json)
    training_file.close
  end

  after do
    training_file.unlink
  end

  subject(:analyzer) { described_class.new(training_file.path) }

  describe '#classify' do
    it 'returns positive for positive sentiments' do
      expect(analyzer.classify('My day was wonderful and great!')).to eq('positive')
    end

    it 'returns negative for negative sentiments' do
      expect(analyzer.classify('That was an awful and terrible experience.')).to eq('negative')
    end
  end
end
