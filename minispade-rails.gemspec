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

  s.add_development_dependency "rails", ["~> 3.1"]

  s.files = %w(README.md) + Dir["lib/**/*", "vendor/assets/**/*"]

  s.require_paths = ["lib"]
end
