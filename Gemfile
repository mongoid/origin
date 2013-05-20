source "http://rubygems.org"
gemspec

group :test do
  gem "activesupport", "~> 3.1"
  gem "i18n", "~> 0.6"
  gem "rspec", "~> 2.13"
  gem "tzinfo", "~> 0.3.22"

  if ENV["CI"]
    gem "coveralls", :require => false
  else
    gem "guard-rspec"
    gem "rb-fsevent"
  end
end

gem "rake"
