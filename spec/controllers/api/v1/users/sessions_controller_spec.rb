require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do

  let!(:user) {
    user = FactoryGirl.create(:user)
  }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'logs in user' do
        post :create, { email: user.email, password: user.password }
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        expect(subject.current_user).to eq user
      end
    end

    context 'with unconfirmed email' do
      it 'does not log in' do
        post :create, { email: user.email, password: user.password }
        allow(request.env['warden']).to receive(:authenticate!).and_return(nil)
        expect(JSON.parse(response.body)["success"]).to eq false
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        user.confirm
      end

      it 'does not log in without email' do
        post :create, { email: '', password: user.password }
        expect(subject.current_user).to eq(nil)
        expect(JSON.parse(response.body)).to eq "errors" => [I18n.t("devise_token_auth.sessions.bad_credentials")]
      end

      it 'does not log in without password' do
        post :create, { email: user.email, password: '' }
        expect(JSON.parse(response.body)).to eq "errors" => [I18n.t("devise_token_auth.sessions.bad_credentials")]
      end

      it 'does not log in with wrong password' do
        post :create, { email: user.email, password: 'aaaaraaaa' }
        expect(JSON.parse(response.body)).to eq "errors" => [I18n.t("devise_token_auth.sessions.bad_credentials")]
      end
    end
  end

  describe 'DELETE #destory' do
    before(:each) do
      post :create, { email: user.email, password: user.password }
      @header = { "access-token" => response.header["access-token"],
                  "client" => response.header["client"],
                  "uid" => response.header["uid"] }
    end

    context 'with existing user' do
      it 'logs out user' do
        delete :destroy, {}, @header
      end
    end
  end
end
