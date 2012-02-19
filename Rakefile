require "bundler"
Bundler.setup

require "rake"
require "rspec"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "origin/version"

task :gem => :build
task :build do
  system "gem build origin.gemspec"
end

task :install => :build do
  system "sudo gem install origin-#{Origin::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{Origin::VERSION} -m 'Tagging #{Origin::VERSION}'"
  system "git push --tags"
  system "gem push origin-#{Origin::VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

RSpec::Core::RakeTask.new("spec:progress") do |spec|
  spec.rspec_opts = %w(--format progress)
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
