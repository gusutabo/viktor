# frozen_string_literal: true

require 'spec_helper'
require 'services/storage'
require 'tmpdir'

RSpec.describe Storage do
  subject(:storage) { described_class.new }

  around do |example|
    Dir.mktmpdir do |dir|
      @tmpdir = dir
      example.run
    end
  end

  describe '#save and #load' do
    it 'writes JSON to disk and reads it back' do
      path = File.join(@tmpdir, 'test.json')
      data = { 'foo' => 'bar', 'num' => 42 }

      storage.save(path, data)
      expect(storage.load(path)).to eq(data)
    end

    it 'returns an empty hash when loading a missing file' do
      expect(storage.load(File.join(@tmpdir, 'missing.json'))).to eq({})
    end
  end
end
