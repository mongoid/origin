source "http://rubygems.org"
gemspec

group :test do
  gem "activesupport", "~> 3.1"
  gem "i18n", "~> 0.6"
  gem "rspec", "~> 2.11"
  gem "tzinfo", "~> 0.3.22"

  unless ENV["CI"]
    gem "guard", "1.2.1"
    gem "guard-rspec", "~> 0.7"
  end
end

gem "rake"
