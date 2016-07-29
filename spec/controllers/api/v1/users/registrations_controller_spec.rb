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

      it 'responds with HTTP status 200' do
        post :create, user_params
        expect(response.status).to eq 200
      end
    end

    context 'with invalid params: already used or missing email' do
      it 'does not create a new user' do
        expect { post :create, user_params.merge({email: user.email}) }.to change(User, :count).by(0)
      end

      # it 'responds with HTTP status 403' do
      #   post :create, user_params.merge({email: ''})
      #   expect(response.status).to eq 403
      # end
    end

    # it 'redirects to user\' page if user is saved' do
    #   allow(@user).to receive(:save).and_return(true)
    #   post :create, "user" => { name: 'Iryna Homlyak', zip_code: '79005', city: 'Lviv',
    #                             address: 'Masaryka str., 3', email: 'irina_hom@ukr.net', password: '800000' }
    #   expect(response).to redirect_to(root_url)
    # end
  end
end

# RSpec.describe UsersController, type: :controller do
# #   describe 'GET show' do
# #     let! (:user) {
# #       user = FactoryGirl.create :user
# #     }
# #
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
# #
# #     it 'selects the correct template to render' do
# #       get :new
# #       expect(response).to render_template('users/new')
# #     end
# #   end
# #
# #   describe 'POST create' do
# #     # let!(:user) { user = FactoryGirl.create :user }
# #
# #     it 'redirects to user\' page if user is saved' do
# #       allow(@user).to receive(:save).and_return(true)
# #       post :create, "user" => { name: 'Iryna Homlyak', zip_code: '79005', city: 'Lviv',
# #                                 address: 'Masaryka str., 3', email: 'irina_hom@ukr.net', password: '800000' }
# #       expect(response).to redirect_to(root_url)
# #     end
# #
# #     # it 'renders \'new\' page if user is not saved' do
# #     #   allow(@user).to receive(:save).and_return(nil)
# #     #   post :create, "user" => { name: 'Iryna Homlyak', zip_code: '79005', city: 'Lviv',
# #     #                             address: 'Masaryka str., 3', email: 'irina_hom@ukr.net', password: '800000' }
# #     #   expect(response).to render_template('users/new')
# #     #   expect(flash[:error]).to be_present
# #     # end
# #   end
#
# # describe '#create' do
# #   it 'assigns a variable' do
# #     movie = Movie.create(title: '12 years a slave', rating: 'R', director: 'Steve McQueen',
# #                          release_date: '2013-08-30')
# #     expect(movie.title).to match(/12 years a slave/)
# #   end
# #
# #   it 'redirects to movies path after creation' do
# #     post :create, "movie" => { :title => "12 years a slave", :rating => "R",
# #                       :director => "Steve McQueen", :release_date => "2013-08-30" }
# #     expect(response).to redirect_to(movies_path)
# #     expect(flash[:notice]).to be_present
# #   end
# # end
# #
# # describe '#edit' do
# #   let!(:movies) {  Movie.create([
# #         { title: 'Star Wars',    rating: 'PG',
# #           director: 'George Lucas', release_date: '1977-05-25' },
# #         { title: 'Blade Runner',    rating: 'PG',
# #           director: 'Ridley Scott', release_date: '1982-06-25' }]) }
# #
# #   it 'finds a movie' do
# #     get :edit, id: 1
# #     movie = Movie.find(1)
# #     expect(movie.title).to match(/Star Wars/)
# #   end
# # end
# #
# # describe '#update' do
# #   let!(:movies) {  Movie.create([
# #         { title: 'Star Wars',    rating: 'PG',
# #           director: 'George Lucas', release_date: '1977-05-25' },
# #         { title: 'Blade Runner',    rating: 'PG',
# #           director: 'Ridley Scott', release_date: '1982-06-25' }]) }
# #
# #   it 'finds a movie' do
# #     id = 1
# #     movie = Movie.find(id)
# #     expect(movie).to eq(Movie.first)
# #   end
# #
# #   it 'updates the parameters of movie' do
# #     Movie.first.update_attributes!(title: '12 years a slave', rating: 'R',
# #           director: 'Steve McQueen', release_date: '2013-08-30')
# #     expect(Movie.first.title).to match(/12 years a slave/)
# #   end
# #
# #   it 'redirects to the movie path' do
# #   movie = Movie.first
# #   patch :update, id: movie, movie: { :title => "12 years a slave", :rating => "R",
# #                                     :director => "Steve McQueen", :release_date => "2013-08-30" }
# #   expect(response).to redirect_to(movie_path(Movie.first))
# #   expect(flash[:notice]).to be_present
# #   end
# # end
# #
# # describe '#destroy' do
# #   let!(:movies) {  Movie.create([
# #         { title: 'Star Wars',    rating: 'PG',
# #           director: 'George Lucas', release_date: '1977-05-25' },
# #         { title: 'Blade Runner',    rating: 'PG',
# #           director: 'Ridley Scott', release_date: '1982-06-25' }]) }
# #
# #   it 'destroys a movie' do
# #     movie = Movie.find(1)
# #     movie.destroy
# #     expect(Movie.first.title).to match(/Blade Runner/)
# #   end
# #
# #   it 'redirects correctly' do
# #     movie = Movie.first
# #     delete :destroy, id: movie.id
# #     expect(response).to redirect_to(movies_path)
# #     expect(flash[:notice]).to be_present
# #   end
# # end
#
# end