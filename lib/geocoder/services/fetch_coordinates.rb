# frozen_string_literal: true

module Geocoder
  module Services
    class FetchCoordinates
      include Dry::Monads[:result, :do]

      CITY_REGEX = /\A[[:alpha:]]+([\s\-]?[[:alpha:]]+)*\z/

      attr_reader :repository

      def initialize(repository: Geocoder::Repositories::Coordinates.new)
        @repository = repository
      end

      def call(params)
        params = yield validate(params)
        coordinates = repository.find(params[:city])
        return Failure([:not_found, "Cannot locate '#{params[:city]}'"]) unless coordinates

        Success(coordinates)
      end

      private

      def validate(params)
        if params[:city] && CITY_REGEX.match?(params[:city])
          Success(params)
        else
          Failure([:unprocessable_entity, { city: "Invalid city" }])
        end
      end
    end
  end
end
