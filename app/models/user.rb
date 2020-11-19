class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email.regex
  USER_PERMIT = %i(name email password password_confirmation).freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :favoriate_movies, dependent: :destroy
  has_many :movies, through: :favoriate_movies

  has_many :comments, dependent: :destroy, as: :commentable

  has_many :rates, dependent: :destroy

  enum role: {normal: 0, premium: 1, admin: 2}

  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}

  validates :email, presence: true,
             length: {maximum: Settings.user.email.maximum},
             format: {with: VALID_EMAIL_REGEX},
             uniqueness: {case_sensitive: true}

  validates :password, presence: true,
             length: {minimum: Settings.user.password.minimum},
             allow_blank: true

  before_save :downcase_email

  def liked? movie, typelike
    favoriate_movies.by_movie_id(movie.id).by_typelike_id(typelike).exists?
  end

  def rated? movie
    rates.by_movie_id(movie.id).present?
  end

  def self.from_omniauth access_token
    data = access_token.info
    User.where(email: data["email"])
        .first_or_create(name: data["name"],
                        email: data["email"],
                        avatar: data["image"],
                        password: Devise.friendly_token[0, 20],
                        provider: access_token[:provider],
                        uid: access_token[:uid])
  end

  private

  def downcase_email
    email.downcase!
  end
end
