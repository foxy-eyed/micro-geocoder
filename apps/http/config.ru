# frozen_string_literal: true

require "hanami/middleware/body_parser"
require_relative "../../config/environment"
require_relative "../../config/boot"

use Rack::Reloader if ENV["RACK_ENV"] == "development"
use Hanami::Middleware::BodyParser, :json

run HTTP::App.instance
