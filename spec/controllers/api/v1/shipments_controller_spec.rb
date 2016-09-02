require 'rails_helper'

RSpec.describe Api::V1::ShipmentsController, type: :controller do
  let!(:shipment) {
    shipment = FactoryGirl.create(:shipment)
  }
  
  describe 'authenticated user\'s paths' do
    before(:each) do
      user = FactoryGirl.create(:user)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET index' do
      it 'renders all shipments in database' do
        get :index        
        expect(JSON.parse(response.body).to_json).to have_content(shipment.to_json)
      end
    end    
  end

  describe 'random visitor\'s paths' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe 'GET #index' do
      it 'responds with HTTP status 401' do
        get :index
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        get :index
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end
  end
end