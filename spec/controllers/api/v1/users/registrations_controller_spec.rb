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

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect { post :create, user_params }.to change(User, :count).by(1)
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

# it 'redirects to user\' page if user is saved' do
#   allow(@user).to receive(:save).and_return(true)
#   post :create, "user" => { name: 'Iryna Homlyak', zip_code: '79005', city: 'Lviv',
#                             address: 'Masaryka str., 3', email: 'irina_hom@ukr.net', password: '800000' }
#   expect(response).to redirect_to(root_url)
# end

# #     it 'calls the model method that performs search' do
# #       expect(User).to receive(:find).with("#{user.id}")
# #       get :show, id: user.id
# #     end
# #
# #     it 'selects the correct template to render' do
# #       User.stub(:find, id: user.id)
# #       get :show, id: user.id
# #       expect(response).to render_template('users/show')
# #     end
# #   end
# #
# #   describe 'GET new' do
# #     it 'creates a model instance @user' do
# #       user = User.new
# #       get :new
# #       expect(assigns(:user)).to be_a_new(User)
# #     end