class Movie < ApplicationRecord
  belongs_to :genre

  has_many :comments, dependent: :destroy

  has_many :favoriate_movies, dependent: :destroy
  has_many :users, through: :favoriate_movies

  has_many :cast_movies, dependent: :destroy
  has_many :casts, through: :cast_movies
end
