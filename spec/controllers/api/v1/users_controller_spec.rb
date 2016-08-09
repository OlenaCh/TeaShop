require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # let!(:mixed_params) {
  #   {
  #       user: {
  #           id: 1000,
  #           name:   'User',
  #           nickname: 'User Nickname',
  #           zip_code: 79000,
  #           city: 'City',
  #           address: 'Address',
  #           email: 'user@email.com',
  #           password: '00000000'
  #       },
  #       format: :json
  #   }
  # }
  #
  # describe 'strong parameters' do
  #   context "when processing POST request with a mix of permitted and unpermitted parameters" do
  #     before(:each) do
  #       post :create, mixed_params
  #     end
  #
  #     it "will not set the value of unpermitted parameter" do
  #       expect(JSON.parse(response.body)["id"]).not_to eq(1000)
  #       expect(JSON.parse(response.body)["nickname"]).not_to match(/User Nickname/)
  #     end
  #
  #     it "a create will set the value of the permitted parameters" do
  #       expect(JSON.parse(response.body)["name"]).to match(/User/)
  #       expect(JSON.parse(response.body)["zip_code"]).to eq(79000)
  #       expect(JSON.parse(response.body)["city"]).to match(/City/)
  #       expect(JSON.parse(response.body)["address"]).to match(/Address/)
  #       expect(JSON.parse(response.body)["email"]).to match(/user@email.com/)
  #       expect(JSON.parse(response.body)["password"]).to match(/00000000/)
  #     end
  #   end
  # end
end