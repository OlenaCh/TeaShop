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
        expect(subject.current_user).to eq user
      end
    end

    # context 'with invalid attributes' do
    #   it 'not logged in user' do
    #     post :create, { email: '', password: user.password }
    #     expect(subject.current_user).to eq(nil)
    #     expect(JSON.parse(response.body)["errors"]).to eq sign_in_error
    #   end
    #
    #   it 'not logged in user' do
    #     post :create, { email: user.email, password: 'sdsfsfss' }
    #     expect(JSON.parse(response.body)["errors"]).to eq sign_in_error
    #   end
    #
    #   it 'not logged in user' do
    #     post :create, { email: '', password: '' }
    #     expect(response.status).to eq(401)
    #   end
    # end
  end

  # describe 'DELETE #destory' do
  #   before(:each) do
  #     post :create, { email: user.email, password: user.password }
  #
  #     @header = { "access-token" => response.header["access-token"],
  #                 "client" => response.header["client"],
  #                 "uid" => response.header["uid"] }
  #   end
  #
  #   context 'with existing user' do
  #     it 'signs out user' do
  #       delete :destroy, {}, @header
  #       #expect(response.status).to eq(200)
  #     end
  #   end
  # end
end
