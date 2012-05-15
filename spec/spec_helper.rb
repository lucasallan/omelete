$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
$:.unshift File.expand_path('../../lib/omelete', __FILE__)
$:.unshift File.expand_path('../../lib/omelete/models', __FILE__)

require 'rspec'
require 'vcr'
require 'omelete'
require 'movie_page'
require 'detailed_page'
require 'movie'
require 'showtime'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name, :record => :new_episodes) { example.call }
  end
end