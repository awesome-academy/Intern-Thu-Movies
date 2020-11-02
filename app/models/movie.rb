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

  enum status: {lock_movie: 0, open: 1}

  validates :title, presence: true, length: {maximum: Settings.movie.title}
  validates :slug, presence: true, length: {maximum: Settings.movie.slug}
  validates :trailer, :image, :runtime, :status, presence: true
  validates :overview, length: {maximum: Settings.movie.overview}

  mount_uploader :image, ImageUploader
  mount_uploader :film, FilmUploader
  mount_uploader :background, BackgroundUploader

  delegate :genre_name, to: :genre

  ransack_alias :info_movie, :title_or_director_or_genre_genre_name

  def self.ransackable_attributes auth_object = nil
    if auth_object == :admin
      super
    else
      super & %w(info_movie)
    end
  end

  ransacker :created_at do
    Arel.sql("date(created_at)")
  end

  default_scope{where(status: Settings.movie.status_open)}
  scope :by_title, (lambda do |title|
    where("title LIKE ?", "%#{title}%") if title.present?
  end)
  scope :by_director, (lambda do |director|
    where("director LIKE ?", "%#{director}%") if director.present?
  end)
  scope :by_status, ->(status){where status: status if status.present?}
  scope :by_id, ->(id_movie){where id: id_movie}
  scope :ordered_by_title, (lambda do |order_param|
    order("title #{order_param}") if order_param.present?
  end)
  scope :ordered_by_view, ->{order(view: :desc)}
  scope :ordered_by_create, ->{order(created_at: :desc)}
  def check_score
    rates.average :score
  end

  def average_score
    rates.average(:score) * Settings.twenty
  end
end
