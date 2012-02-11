# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "minispade-rails/version"

Gem::Specification.new do |s|
  s.name        = "minispade-rails"
  s.version     = MinispadeRails::VERSION
  s.authors     = ["Keith Pitt"]
  s.email       = ["me@keithpitt.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "minispade-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rails", ["~> 3.1"]
end
