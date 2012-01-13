# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "origin/version"

Gem::Specification.new do |s|
  s.name        = "origin"
  s.version     = Origin::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Durran Jordan"]
  s.email       = ["durran@gmail.com"]
  s.homepage    = "http://mongoid.org"
  s.summary     = "Simple DSL for MongoDB query generation"
  s.description = "Origin is a simple DSL for generating MongoDB selectors and options"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = "origin"

  s.add_development_dependency("rspec", ["~> 2.6"])
  s.add_development_dependency("guard-rspec", ["~> 0.6"])

  s.files = Dir.glob("lib/**/*") + %w(Rakefile)
  s.require_path = 'lib'
end
