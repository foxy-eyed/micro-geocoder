# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# business logic
gem "config"

# other
gem "rake"

group :test, :development do
  gem "rubocop", require: false
  gem "rubocop-rspec"
end

group :test do
  gem "rspec"
  gem "simplecov", require: false
end
