class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email.regex
  USER_PERMIT = %i(name email password password_confirmation).freeze

  has_many :favoriate_movies, dependent: :destroy
  has_many :movies, through: :favoriate_movies

  has_many :comments, dependent: :destroy, as: :commentable

  enum role: {user: 0, admin: 1}

  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}

  validates :email, presence: true,
             length: {maximum: Settings.user.email.maximum},
             format: {with: VALID_EMAIL_REGEX}, uniqueness: true

  validates :password, presence: true,
             length: {minimum: Settings.user.password.minimum}

  before_save :downcase_email

  has_secure_password

  def liked? movie, typelike
    FavoriateMovie.by_movie_id(movie.id).by_typelike_id(typelike).exists?
  end

  private

  def downcase_email
    email.downcase!
  end
end
