# frozen_string_literal: true

require 'spec_helper'
require 'models/health'

RSpec.describe Health do
  subject(:health) { described_class.new }

  describe '#bmi' do
    it 'calculates the body mass index from weight and height' do
      expect(health.bmi(70, 1.75)).to eq(22.86)
      expect(health.bmi(95, 1.80)).to eq(29.32)
    end
  end

  describe '#bmi_category' do
    it 'returns the correct BMI category for each range' do
      expect(health.bmi_category(17.5)).to eq(:underweight)
      expect(health.bmi_category(22.0)).to eq(:healthy)
      expect(health.bmi_category(27.0)).to eq(:overweight)
      expect(health.bmi_category(32.0)).to eq(:obese1)
      expect(health.bmi_category(37.0)).to eq(:obese2)
      expect(health.bmi_category(45.0)).to eq(:obese3)
    end
  end
end
