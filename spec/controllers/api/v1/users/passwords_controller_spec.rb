require 'rails_helper'

RSpec.describe Api::V1::Users::PasswordsController, type: :controller do
  let!(:user) {
    user = FactoryGirl.create(:user)
  }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'authenticated user' do
    describe 'POST #create' do
      it 'sends password reset instructions' do
        expect { post :create, email: user.email, redirect_url: 'test.com' }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end

      it 'renders success' do
        post :create, email: user.email, redirect_url: 'test.com'
        expect(JSON.parse(response.body)["success"]).to eq true
      end
    end

    describe 'PUT #update' do
      before(:each) do
        post :create, email: user.email, redirect_url: 'test.com'
      end

      it 'renders error if no password provided' do
        put :update, email: user.email
        expect(JSON.parse(response.body)).to eq "success" => false, "errors" => [I18n.t("devise_token_auth.passwords.missing_passwords")]
      end

      it 'renders error if password unconfirmed' do
        put :update, email: user.email, password: 'aaa66666', password_confirmation: 'bbb66666'
        expect(JSON.parse(response.body)).to eq "success" => false, "errors" => {"password_confirmation"=>["doesn't match Password"], "full_messages"=>["Password confirmation doesn't match Password"]}
      end

      it 'renders error if password unconfirmed' do
        put :update, email: user.email, password: '66666666', password_confirmation: '66666666'
        expect(JSON.parse(response.body)["success"]).to eq true
      end
    end
  end

  describe 'not authenticated user' do
    describe 'POST #create' do
      it 'does not send password reset instructions' do
        expect { post :create, email: 'malicious@email.com', redirect_url: 'test.com' }.to change(ActionMailer::Base.deliveries, :count).by(0)
      end

      it 'renders error' do
        post :create, email: 'malicious@email.com', redirect_url: 'test.com'
        expect(JSON.parse(response.body).to_json).to eq ({ :errors => ["Authorized users only."]}).to_json
      end

      it 'responds with HTTP status 401' do
        post :create, email: 'malicious@email.com', redirect_url: 'test.com'
        expect(response.status).to eq 401
      end
    end

    describe 'PUT #update' do
      it 'renders error' do
        put :update, email: 'malicious@email.com'
        expect(JSON.parse(response.body)).to eq "success" => false, "errors" => ["Unauthorized"]
      end
    end
  end
end