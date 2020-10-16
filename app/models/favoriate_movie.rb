class FavoriateMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  enum typelike: {favoriate: 0, bookmark: 1}

  scope :by_movie_id, ->(movie_id){where movie_id: movie_id}
  scope :by_typelike_id, ->(typelike_id){where typelike: typelike_id}
end
