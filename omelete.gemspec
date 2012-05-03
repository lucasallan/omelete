# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omelete/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mauricio Voto"]
  gem.email         = ["mauriciovoto@gmail.com"]
  gem.description   = %q{Ruby web crawler to access omelete informations}
  gem.summary       = %q{Ruby web crawler to access omelete informations}
  gem.homepage      = ""

  gem.files         = Dir['lib/**/*.rb']
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omelete"
  gem.require_paths = ["lib"]
  gem.version       = Omelete::VERSION
  
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'nokogiri'
  gem.add_development_dependency 'mechanize'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock', '1.8.0'
end