# frozen_string_literal: true

module Geocoder
  module Services
    class FetchCoordinates
      attr_reader :repository

      def initialize(repository: Geocoder::Repositories::Coordinates.new)
        @repository = repository
      end

      def call(params)
        repository.find(params[:city])
      end
    end
  end
end
