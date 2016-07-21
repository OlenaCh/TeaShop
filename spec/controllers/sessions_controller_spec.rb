require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET new' do
    it 'selects the correct template to render' do
      get :new
      expect(response).to render_template('sessions/new')
    end
  end

  describe 'POST create' do
    let!(:user) { user = FactoryGirl.create :user }

    it 'calls method that performs db search' do
      expect(User).to receive(:find_by).with(email: 'irina_hom@ukr.net')
      post :create, session: { :email => 'irina_hom@ukr.net', :password => '800000' }
    end

    it 'redirects to user if user is found and authenticated' do
      expect(User).to receive(:find_by).with(email: 'irina_hom@ukr.net').and_return(user)
      post :create, session: { :email => 'irina_hom@ukr.net', :password => '800000' }
      expect(response).to redirect_to(user_path(user.id))
    end

    it 'renders new page if user is not found' do
      expect(User).to receive(:find_by).with(email: 'irina_hom@ukr.net').and_return(false)
      post :create, session: { :email => 'irina_hom@ukr.net', :password => '800000' }
      expect(response).to render_template('sessions/new')
    end

    it 'renders new page if user is found, but not authenticated' do
      expect(User).to receive(:find_by).with(email: 'irina_hom@ukr.net').and_return(user)
      post :create, session: { :email => 'irina_hom@ukr.net', :password => '990000' }
      expect(response).to render_template('sessions/new')
    end
  end
end