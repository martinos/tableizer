# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tableizer/version"

Gem::Specification.new do |s|
  s.name        = "tableizer"
  s.version     = Tableizer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martin Chabot"]
  s.email       = ["chabotm@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Converts Ruby objects into tables}
  s.description = %q{Converts Ruby objects into tables}

  s.rubyforge_project = "tableizer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
