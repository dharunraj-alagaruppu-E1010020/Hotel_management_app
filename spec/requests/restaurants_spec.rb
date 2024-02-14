require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "GET /restaurants/:id" do
    context "when requesting a valid restaurant" do
      it "returns a successful response" do
        get "/restaurants/1"
        expect(response).to have_http_status(200)
      end
    end

    context "when requesting a non-existent restaurant" do
      it "returns a not found response" do
        get "/restaurants/999"
        expect(response).to have_http_status(404)
      end
    end

    # context "when requesting with missing parameters" do
    #   let(:blank_id) { { id: nil } }
    #   it "returns a bad request response" do
    #     get "/restaurants/nil", params: blank_id
    #     expect(response).to have_http_status(400)
    #   end
    # end

  end
end
