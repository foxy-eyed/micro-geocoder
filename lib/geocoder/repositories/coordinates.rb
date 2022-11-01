# frozen_string_literal: true

require "csv"

module Geocoder
  module Repositories
    class Coordinates
      def initialize(csv = File.join(File.expand_path("..", __dir__), "data/city.csv"))
        @csv = csv
      end

      def find(city)
        data[city]
      end

      private

      def data
        @data ||= load_data!
      end

      def load_data!
        @data = CSV.read(@csv, headers: true).inject({}) do |result, row|
          city = row["city"]
          result[city] = {
            latitude: row["geo_lat"].to_f,
            longitude: row["geo_lon"].to_f
          }
          result
        end
      end
    end
  end
end
