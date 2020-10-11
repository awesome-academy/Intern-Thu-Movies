class Comment < ApplicationRecord
  COMMENT_PERMIT = :content
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, dependent: :destroy, as: :commentable

  validates :content, presence: true

  delegate :name, to: :user
end
