source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt", "3.1.12"
gem "bootstrap-sass", "3.3.7"
gem "bootstrap-will_paginate", "1.0.0"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "faker", "~> 1.7.3"
gem "figaro"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-ui-rails", "5.0.5"
gem "puma", "~> 3.12"
gem "rails", "~> 5.0.7", ">= 5.0.7.2"
gem "rails-ujs"
gem "sass-rails", "~> 5.0"
gem "sqlite3", "~> 1.3.7"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "will_paginate", "3.1.6"

group :development, :test do
  gem "byebug", platform: :mri
  gem "rubocop", "~> 0.54.0", require: false
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test do
  gem "capybara", "3.28.0"
  gem "guard", "2.15.0"
  gem "guard-minitest", "2.4.6"
  gem "minitest"
  gem "minitest-reporters", "1.3.8"
  gem "rails-controller-testing", "1.0.4"
  gem "selenium-webdriver", "3.142.4"
  gem "webdrivers", "4.1.2"
end

group :production do
  gem "pg", "1.1.4"
end
