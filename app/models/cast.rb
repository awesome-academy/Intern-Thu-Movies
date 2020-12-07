class Cast < ApplicationRecord
  CAST_PERMIT = %i(id cast_name birthday birthplace avatar _destroy).freeze
  belongs_to :movie

  validates :cast_name, :birthday, :birthplace, presence: true

  mount_uploader :avatar, AvatarUploader
end
