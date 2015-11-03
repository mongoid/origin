source "https://rubygems.org"
gemspec

group :test do
  gem "activesupport", "~> 4.0"
  gem "i18n", "~> 0.6"
  gem "rspec", "~> 3.1.0"
  gem "tzinfo", "~> 0.3.22"

  if ENV["CI"]
    gem "coveralls", :require => false
  else
    gem "guard-rspec"
    gem "rb-fsevent"
  end
end

gem "rake"
