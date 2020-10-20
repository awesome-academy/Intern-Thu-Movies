class Movie < ApplicationRecord
  MOVIE_PERMIT = [:title, :image, :trailer, :background, :slug, :film,
                  :overview, :trailer, :release_date,
                  :runtime, :director, :genre_id].freeze
  belongs_to :genre

  has_many :comments, dependent: :destroy, as: :commentable

  has_many :favoriate_movies, dependent: :destroy
  has_many :users, through: :favoriate_movies

  has_many :cast_movies, dependent: :destroy
  has_many :casts, through: :cast_movies

  has_many :rates, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.movie.title}
  validates :slug, presence: true, length: {maximum: Settings.movie.slug}
  validates :trailer, presence: true
  validates :overview, length: {maximum: Settings.movie.overview}
  validates :runtime, presence: true

  mount_uploader :image, ImageUploader
  mount_uploader :film, FilmUploader
  mount_uploader :background, BackgroundUploader

  delegate :genre_name, to: :genre

  scope :by_title, ->(title){where("title LIKE ?", "%#{title}%")}
  scope :by_id, ->(id_movie){where id: id_movie}

  def check_score
    rates.average :score
  end

  def average_score
    rates.average(:score) * Settings.twenty
  end
end
