# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# transport
gem "bunny"
gem "faraday"
gem "faraday-retry"
gem "hanami-router", git: "https://github.com/hanami/router.git", tag: "v2.0.0.beta4"
gem "puma"
gem "rack"

# business logic
gem "config"
gem "dry-monads"

# other
gem "rack-ougai"
gem "rack-request-id"
gem "rake"

group :test, :development do
  gem "amazing_print"
  gem "rubocop", require: false
  gem "rubocop-rspec"
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "simplecov", require: false
end
