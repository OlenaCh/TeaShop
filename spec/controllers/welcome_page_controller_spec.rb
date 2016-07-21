require 'rails_helper'

RSpec.describe WelcomePageController, type: :controller do
  describe 'GET home' do
    it 'selects the correct template to render' do
      get :home
      expect(response).to render_template('welcome_page/home')
    end
  end
end