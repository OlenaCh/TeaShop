require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) {
    user = FactoryGirl.create(:user)
  }

  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_user).and_return(admin)
    end

    describe 'GET #show' do
      it 'responds with HTTP status 401' do
        get :show, id: user.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for users only' do
        get :show, id: user.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Users only."]}).to_json
      end
    end

    describe 'DELETE #detroy' do
      it 'responds with HTTP status 200' do
        delete :destroy, id: user.id
        expect(response.status).to eq 200
      end

      it 'renders that user was deleted' do
        delete :destroy, id: user.id
        expect(JSON.parse(response.body).to_json).to have_content('User deleted successfully!')
      end
    end 
  end

  describe 'authenticated user\'s paths' do
    before(:each) do
      user = FactoryGirl.create(:user)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET #show' do
      it 'responds with HTTP status 200' do
        get :show, id: user.id
        expect(response.status).to eq 200
      end
    end

    describe 'DELETE #detroy' do
      it 'responds with HTTP status 401' do
        delete :destroy, id: user.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for admins only' do
        delete :destroy, id: user.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Admins only."]}).to_json
      end
    end 
  end

  describe 'random visitor\'s paths' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe 'GET #show' do
      it 'responds with HTTP status 401' do
        get :show, id: user.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        get :show, id: user.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end

    describe 'DELETE #detroy' do
      it 'responds with HTTP status 401' do
        delete :destroy, id: user.id
        expect(response.status).to eq 401
      end

      it 'renders that this page is for authorized users only' do
        delete :destroy, id: user.id
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end
    end 
  end
end