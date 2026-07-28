# frozen_string_literal: true

require 'bundler/setup'
$LOAD_PATH.unshift(File.expand_path('../src', __dir__))

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
end
