require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # let!(:address) {
  #   address = FactoryGirl.create(:address)
  # }

  # let!(:address_params) {
  #   address_params = { city: 'New York', zip_code: '10005', address: 'Wall street' }
  # }

  # describe 'admin\'s paths' do
  #   before(:each) do
  #     admin = FactoryGirl.create(:admin)
  #     allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
  #     allow(controller).to receive(:current_user).and_return(admin)
  #   end

  #   describe 'GET #index' do
  #     it 'responds with HTTP status 401' do
  #       get :index
  #       expect(response.status).to eq 401
  #     end

  #     it 'renders that this page is for users only' do
  #       get :index
  #       expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
  #     end
  #   end

  #   describe 'POST #create' do
  #     it 'responds with HTTP status 401' do
  #       post :create, address_params
  #       expect(response.status).to eq 401
  #     end

  #     it 'renders that this page is for users only' do
  #       post :create, address_params
  #       expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
  #     end
  #   end 
  # end

  # describe 'authenticated user\'s paths' do
  #   before(:each) do
  #     user = FactoryGirl.create(:user)
  #     allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  #     allow(controller).to receive(:current_user).and_return(user)
  #     user.addresses << address
  #   end

  #   describe 'GET index' do
  #     it 'responds with data concerning user\'s addresses' do
  #       get :index
  #       expect(JSON.parse(response.body).to_json).to have_content(address.to_json)
  #     end
  #   end
  # end

  # describe 'random visitor\'s paths' do
  #   before(:each) do
  #     allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
  #   end

  #   describe 'GET #index' do
  #     it 'responds with HTTP status 401' do        
  #       get :index
  #       expect(response.status).to eq 401
  #     end

  #     it 'renders that this page is for authorized users only' do
  #       get :index
  #       expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
  #     end
  #   end

  #   describe 'POST #create' do
  #     it 'does not create a new address' do
  #       expect { post :create, address_params }.to change(Address, :count).by(0)
  #     end

  #     it 'responds with HTTP status 401' do
  #       post :create, address_params
  #       expect(response.status).to eq 401
  #     end

  #     it 'renders that this page is for authorized users only' do
  #       post :create, address_params
  #       expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
  #     end
  #   end
  # end
end