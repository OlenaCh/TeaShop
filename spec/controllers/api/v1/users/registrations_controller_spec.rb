require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :controller do

  let!(:user_params) {
    user_params = FactoryGirl.attributes_for(:user)
  }

  let!(:user) {
    user = FactoryGirl.create(:user)
  }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect { post :create, user_params }.to change(User, :count).by(1)
      end

      it 'creates a new address' do
        expect { post :create, user_params.merge({city: 'Lviv', zip_code: '79000', address: 'Lviv'}) }.to change(Address, :count).by(1)
      end

      it 'sends confirmation instructions' do
        expect { post :create, user_params }.to change(ActionMailer::Base.deliveries, :count).by(1)
      end

      it 'responds with HTTP status 200' do
        post :create, user_params
        expect(response.status).to eq 200
      end
    end

    context 'with invalid params' do
      context 'with duplicated email' do
        it 'does not create a new user' do
          expect { post :create, user_params.merge({email: user.email}) }.to change(User, :count).by(0)
        end

        it 'does not create a new address' do
          expect { post :create, user_params.merge({city: 'Lviv', zip_code: '79000'}) }.to change(Address, :count).by(0)
        end

        it 'does not send confirmation instructions' do
          expect { post :create, user_params.merge({email: user.email}) }.to change(ActionMailer::Base.deliveries, :count).by(0)
        end

        it 'responds with HTTP status 422' do
          post :create, user_params.merge({email: user.email})
          expect(response.status).to eq 422
        end
      end

      context 'with missing email' do
        it 'does not create a new user' do
          expect { post :create, user_params.merge({email: ''}) }.to change(User, :count).by(0)
        end

        it 'does not send confirmation instructions' do
          expect { post :create, user_params.merge({email: ''}) }.to change(ActionMailer::Base.deliveries, :count).by(0)
        end

        it 'responds with HTTP status 422' do
          post :create, user_params.merge({email: ''})
          expect(response.status).to eq 422
        end
      end

      context 'with missing password' do
        it 'does not create a new user' do
          expect { post :create, user_params.merge({password: ''}) }.to change(User, :count).by(0)
        end

        it 'does not send confirmation instructions' do
          expect { post :create, user_params.merge({password: ''}) }.to change(ActionMailer::Base.deliveries, :count).by(0)
        end

        it 'responds with HTTP status 422' do
          post :create, user_params.merge({password: ''})
          expect(response.status).to eq 422
        end
      end
    end
  end
end