source "https://rubygems.org"
gemspec

group :test do
  gem "activesupport", "~> 4.0"
  gem "i18n", "~> 0.6"
  gem "rspec", "~> 3.4.0"
  gem "tzinfo", "~> 0.3.22"
  gem "json", "1.8.3"
  gem "listen", "2.10.1"

  if ENV["CI"]
    gem "coveralls", :require => false
  else
    gem "guard-rspec"
    gem "rb-fsevent"
  end
end

gem "rake"
