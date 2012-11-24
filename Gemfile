source "http://rubygems.org"
gemspec

group :test do
  gem "activesupport", "~> 3.1"
  gem "i18n", "~> 0.6"
  gem "rspec", "~> 2.11"
  gem "tzinfo", "~> 0.3.22"

  unless ENV["CI"]
    gem "guard-rspec"
    gem "rb-fsevent", "~> 0.9.1"
  end
end

gem "rake"
