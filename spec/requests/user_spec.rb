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
      # let(:invalid_params) { FactoryBot.attributes_for(:user, name: "") }
      
      it "returns a bad request response" do
        post "/users", params: invalid_params
        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)['errors']).to_not be_empty
        # puts response.inspect
      end
    end

    context "Valid user object using factorygirl build" do
      it 'has a valid factory' do
        user_obj = FactoryGirl.build(:user)
        expect(user_obj).to be_valid
      end
    end

    context "Valid user object using factorygirl create" do
      it 'has a valid factory' do
        user_obj = FactoryGirl.create(:user)
        expect(user_obj).to be_valid
      end
    end
  end
end

# model level
describe Role do
  describe '#check' do 
    it 'returns should be true' do
      expect(Role.check()).to be true
    end
  end
end
