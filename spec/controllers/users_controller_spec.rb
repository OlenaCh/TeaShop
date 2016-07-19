require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe '#show' do
    
    it 'redirects to user page' do
      user = FactoryGirl.create :user
      get :show, id: user.id
      expect(response).to render_template(:show)
    end
  end
  
  # describe '#search_directors' do
  #   let!(:movies) {  Movie.create([
  #         { title: 'Star Wars',    rating: 'PG',
  #           director: 'George Lucas', release_date: '1977-05-25' },
  #         { title: 'Blade Runner',    rating: 'PG',
  #           director: 'Ridley Scott', release_date: '1982-06-25' },
  #         { title: 'Alien',    rating: 'R',
  #           release_date: '1979-05-25' },
  #         { title: 'THX-1138',    rating: 'R',
  #           director: 'George Lucas', release_date: '1971-03-11' }]) }
  #
  #   it 'respond with movies when director present' do
  #     movie = Movie.first
  #     get :search_directors, id: movie.id
  #     expect(response).to render_template(:search_directors)
  #   end
  #
  #   it 'redirect to movies path when director absent' do
  #     movie = Movie.find_by_title('Alien')
  #     get :search_directors, id: movie.id
  #     expect(response).to redirect_to(movies_path)
  #   end
  # end
  #
  # describe '#index' do
  #   let!(:movies) {  Movie.create([
  #         { title: 'Star Wars',    rating: 'PG',
  #           director: 'George Lucas', release_date: '1977-05-25' },
  #         { title: 'Blade Runner',    rating: 'PG',
  #           director: 'Ridley Scott', release_date: '1982-06-25' },
  #         { title: 'Alien',    rating: 'R',
  #           release_date: '1979-05-25' },
  #         { title: 'THX-1138',    rating: 'R',
  #           director: 'George Lucas', release_date: '1971-03-11' }]) }
  #
  #   it 'assigns a sort variable' do
  #     get :index, "sort" => 'title'
  #     sort = "title"
  #     expect(sort).to match(/title/)
  #   end
  #
  #   it 'orders by release_date' do
  #     ordering = 'release_date'
  #     movies = Movie.all.order(ordering)
  #     expect(movies.first.title).to match(/THX-1138/)
  #   end
  #
  #   it 'selects by rating' do
  #     movies = Movie.where(rating: 'R')
  #     expect(movies.first.title).to match(/Alien/)
  #   end
  # end
  #
  # describe '#create' do
  #   it 'assigns a variable' do
  #     movie = Movie.create(title: '12 years a slave', rating: 'R', director: 'Steve McQueen',
  #                          release_date: '2013-08-30')
  #     expect(movie.title).to match(/12 years a slave/)
  #   end
  #
  #   it 'redirects to movies path after creation' do
  #     post :create, "movie" => { :title => "12 years a slave", :rating => "R",
  #                       :director => "Steve McQueen", :release_date => "2013-08-30" }
  #     expect(response).to redirect_to(movies_path)
  #     expect(flash[:notice]).to be_present
  #   end
  # end
  #
  # describe '#edit' do
  #   let!(:movies) {  Movie.create([
  #         { title: 'Star Wars',    rating: 'PG',
  #           director: 'George Lucas', release_date: '1977-05-25' },
  #         { title: 'Blade Runner',    rating: 'PG',
  #           director: 'Ridley Scott', release_date: '1982-06-25' }]) }
  #
  #   it 'finds a movie' do
  #     get :edit, id: 1
  #     movie = Movie.find(1)
  #     expect(movie.title).to match(/Star Wars/)
  #   end
  # end
  #
  # describe '#update' do
  #   let!(:movies) {  Movie.create([
  #         { title: 'Star Wars',    rating: 'PG',
  #           director: 'George Lucas', release_date: '1977-05-25' },
  #         { title: 'Blade Runner',    rating: 'PG',
  #           director: 'Ridley Scott', release_date: '1982-06-25' }]) }
  #
  #   it 'finds a movie' do
  #     id = 1
  #     movie = Movie.find(id)
  #     expect(movie).to eq(Movie.first)
  #   end
  #
  #   it 'updates the parameters of movie' do
  #     Movie.first.update_attributes!(title: '12 years a slave', rating: 'R',
  #           director: 'Steve McQueen', release_date: '2013-08-30')
  #     expect(Movie.first.title).to match(/12 years a slave/)
  #   end
  #
  #   it 'redirects to the movie path' do
  #   movie = Movie.first
  #   patch :update, id: movie, movie: { :title => "12 years a slave", :rating => "R",
  #                                     :director => "Steve McQueen", :release_date => "2013-08-30" }
  #   expect(response).to redirect_to(movie_path(Movie.first))
  #   expect(flash[:notice]).to be_present
  #   end
  # end
  #
  # describe '#destroy' do
  #   let!(:movies) {  Movie.create([
  #         { title: 'Star Wars',    rating: 'PG',
  #           director: 'George Lucas', release_date: '1977-05-25' },
  #         { title: 'Blade Runner',    rating: 'PG',
  #           director: 'Ridley Scott', release_date: '1982-06-25' }]) }
  #
  #   it 'destroys a movie' do
  #     movie = Movie.find(1)
  #     movie.destroy
  #     expect(Movie.first.title).to match(/Blade Runner/)
  #   end
  #
  #   it 'redirects correctly' do
  #     movie = Movie.first
  #     delete :destroy, id: movie.id
  #     expect(response).to redirect_to(movies_path)
  #     expect(flash[:notice]).to be_present
  #   end
  # end
  
end