require 'rails_helper'

RSpec.describe "User", type: :request do
  describe "GET /users" do
    it "returns a successful response" do
      get "/users", params: { page_no: 1 }
      expect(response).to have_http_status(200)
    end
  end

  # Create user method
  describe "POST /users" do
    context "with valid parameters" do
      let(:valid_params) { { user: { name: "Hari", phone_number: "9362310511", password: "1234567890Dh", role_id: 1 } } }

      it "returns a success response" do
        post "/users", params: valid_params
        expect(response).to have_http_status(201)
        expect(response.body).to include('Entry created successfully')
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { user: { name: "", phone_number: "1234567890", password: "", role_id: nil } } }
      
      it "returns a bad request response" do
        post "/users", params: invalid_params
        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)['errors']).to_not be_empty
      end
    end
  end
end