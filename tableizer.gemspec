# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tableizer/version'

Gem::Specification.new do |gem|
  gem.name          = "tableizer"
  gem.version       = Tableizer::VERSION
  # gem.add_dependency "put dependency here"
  gem.add_development_dependency 'rake'
  gem.add_development_dependency "bundler", "~> 1.0"
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'minitest_should'
  gem.add_development_dependency 'pry-nav'

  gem.authors       = ["Martin Chabot"]
  gem.email         = ["chabotm@gmail.com"]
  gem.description   = %q{Adds the ability to Enumerable to generate tables into different formats}
  gem.summary       = %q{Adds the ability to Enumerable to generate tables into different formats}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
