require 'rails_helper'

# RSpec.describe Movie, type: :model do
#
#   describe 'find_similar_movies_by_director' do
#      let!(:movies) {  Movie.create([
#         { title: 'Star Wars',    rating: 'PG',
#           director: 'George Lucas', release_date: '1977-05-25' },
#         { title: 'Blade Runner',    rating: 'PG',
#           director: 'Ridley Scott', release_date: '1982-06-25' },
#         { title: 'Alien',    rating: 'R',
#           release_date: '1979-05-25' },
#         { title: 'THX-1138',    rating: 'R',
#           director: 'George Lucas', release_date: '1971-03-11' }]) }
#     it 'find movies by the same director' do
#       movie = Movie.first
#       movies = Movie.find_similar_movies_by_director movie.director
#       movies.each do |movie_result|
#         expect(movie_result.director).to eq(movie.director)
#       end
#     end
#     it 'find movies by the same director' do
#       movie = Movie.find_by_title('Alien')
#       movies = Movie.find_similar_movies_by_director movie.director
#       expect(movies).to be_empty
#     end
#   end
# end
