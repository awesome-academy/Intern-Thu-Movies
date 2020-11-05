class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email.regex
  USER_PERMIT = %i(name email password password_confirmation).freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favoriate_movies, dependent: :destroy
  has_many :movies, through: :favoriate_movies

  has_many :comments, dependent: :destroy, as: :commentable

  has_many :rates, dependent: :destroy

  enum role: {user: 0, admin: 1}

  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}

  validates :email, presence: true,
             length: {maximum: Settings.user.email.maximum},
             format: {with: VALID_EMAIL_REGEX}, uniqueness: true

  validates :password, presence: true,
             length: {minimum: Settings.user.password.minimum}

  before_save :downcase_email

  def liked? movie, typelike
    favoriate_movies.by_movie_id(movie.id).by_typelike_id(typelike).exists?
  end

  def rated? movie
    rates.by_movie_id(movie.id).present?
  end

  private

  def downcase_email
    email.downcase!
  end
end
