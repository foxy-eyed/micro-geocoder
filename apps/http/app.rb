# frozen_string_literal: true

module HTTP
  class App
    def self.instance
      @instance ||= Hanami::Router.new do
        scope "v1" do
          post "/", to: HTTP::Actions::FetchCoordinates.new
        end
      end
    end
  end
end
