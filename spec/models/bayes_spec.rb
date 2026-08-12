# frozen_string_literal: true

require 'spec_helper'
require 'models/bayes'

RSpec.describe Bayes do
  subject(:bayes) { described_class.new }

  describe '#classify' do
    it 'raises when no training data is available' do
      expect { bayes.classify('anything') }.to raise_error('No training data available')
    end

    it 'classifies text into the correct category' do
      bayes.train('positive', 'I love sunny days and feel good')
      bayes.train('negative', 'I feel sad and angry after a bad day')

      expect(bayes.classify('I feel good today')).to eq('positive')
      expect(bayes.classify('I am angry and sad')).to eq('negative')
    end
  end
end
