# frozen_string_literal: true

module HTTP
  module Actions
    class FetchCoordinates
      def call(env)
        coordinates = Geocoder::Services::FetchCoordinates.new.call(env["router.params"])
        [200, headers, json(coordinates)]
      end

      private

      def headers
        { "Content-Type" => "application/json" }
      end

      def json(object)
        [JSON.generate(object)]
      end
    end
  end
end
