# frozen_string_literal: true

module HTTP
  module Actions
    class FetchCoordinates
      include Dry::Monads[:result]

      def call(env)
        result = Geocoder::Services::FetchCoordinates.new.call(env["router.params"])
        case result
        in Success[coordinates]
          [200, headers, json(coordinates)]
        in Failure[:unprocessable_entity, errors]
          [422, headers, json(errors: errors)]
        in Failure[:not_found, error]
          [404, headers, json(error: error)]
        end
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
