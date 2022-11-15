# frozen_string_literal: true

RSpec.describe AdsService::HTTP::Client do
  include ExternalRequestHelpers

  describe "#update_ad" do
    subject(:client) { described_class.new(connection) }

    let(:id) { 1 }
    let(:coordinates) { { "latitude" => 13.13, "longitude" => 12.12 } }

    let(:headers) { { "Content-Type" => "application/json" } }

    before do
      stubs.patch("/ads/#{id}") { [status, headers, body.to_json] }
    end

    context "with success request" do
      let(:status) { 200 }
      let(:body) { { "data" => { "type" => "ads", "id" => 1, "attributes" => coordinates } } }

      it "returns updated ads object" do
        result = client.update_ad(id, coordinates)
        expect(result).to eq(body)
      end
    end

    context "with failure request" do
      let(:status) { 422 }
      let(:body) { { "errors" => { "coordinates" => { "longitude" => ["is missing"] } } } }

      it "raises error" do
        expect { client.update_ad(id, coordinates) }.to raise_exception(AdsService::HTTP::Error)
      end
    end

    context "with faraday connection error" do
      before do
        allow(client.connection).to receive(:patch).and_raise(Faraday::Error, "Connection failed")
      end

      it "raises error" do
        expect { client.update_ad(id, coordinates) }.to raise_exception(AdsService::HTTP::Error,
                                                                        "[Ads]: Connection failed")
      end
    end
  end
end
