class Cast < ApplicationRecord
  has_many :cast_movies, dependent: :destroy
  has_many :movies, through: :cast_movies
end
