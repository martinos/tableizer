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
  gem.add_development_dependency "bundler", "~> 1.0"
  gem.add_development_dependency 'pry-rails'
  gem.add_development_dependency 'pry-nav'
  gem.add_development_dependency 'pry-doc'
  gem.add_development_dependency 'pry-stack_explorer'
  gem.add_development_dependency 'pry-remote'
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-minitest"
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'ruby_gntp'
  gem.add_development_dependency 'ruby-prof'
  gem.add_development_dependency 'debugger'
  gem.authors       = ["Martin Chabot"]
  gem.email         = ["chabotm@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
