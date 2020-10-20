class Rate < ApplicationRecord
  RATE_PERMIT = %i(movie_id user_id score).freeze

  belongs_to :user
  belongs_to :movie

  scope :by_movie_id, ->(movie_id){where movie_id: movie_id}
end
