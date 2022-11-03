# frozen_string_literal: true

RSpec.describe "Fetch coordinates", type: :request do
  subject(:fetch_coordinates) { post "/v1/coordinates", **params }

  context "with valid params" do
    let(:params) { { city: "Самара" } }

    it "responds with success" do
      fetch_coordinates

      expect(response_status).to eq(200)
      expect(response_json).to eq("latitude" => 53.1950306, "longitude" => 50.1069518)
    end
  end

  context "with unknown location" do
    let(:params) { { city: "Париж" } }

    it "responds with 404" do
      fetch_coordinates

      expect(response_status).to eq(404)
      expect(response_json["error"]).to eq("Cannot locate 'Париж'")
    end
  end

  context "with invalid params" do
    let(:params) { { city: "" } }

    it "responds with 422" do
      fetch_coordinates

      expect(response_status).to eq(422)
      expect(response_json["errors"]).to eq("city" => "Invalid city")
    end
  end
end
