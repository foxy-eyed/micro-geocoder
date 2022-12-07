# frozen_string_literal: true

module AdsService
  module HTTP
    module API
      def update_ad(id, coordinates)
        request(:patch, "/ads/#{id}", { coordinates: coordinates })
      end
    end
  end
end
