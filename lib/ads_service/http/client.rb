# frozen_string_literal: true

module AdsService
  module HTTP
    class Error < StandardError; end

    class Client
      include API

      attr_reader :connection

      def initialize(connection = nil)
        @connection = connection || build_connection
      end

      def request(verb, path, params = {})
        response = connection.send(verb, path, params)
        status = response.status
        body = response.body
        raise Error, "[Ads]: #{status} — #{body}" unless status == 200

        body
      rescue Faraday::Error => e
        raise Error, "[Ads]: #{e.message}"
      end

      private

      def build_connection
        Faraday.new(url: Settings.ads.url) do |conn|
          conn.request :retry, { retry_statuses: [500], interval: 0.05 }
          conn.request :json
          conn.request :json, content_type: "application/json"
        end
      end
    end
  end
end
