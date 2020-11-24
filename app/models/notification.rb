class Notification < ApplicationRecord
  belongs_to :user

  enum status: {unread: 0, read: 1}

  delegate :email, to: :user
  scope :ordered_by_create, ->{order(created_at: :desc)}
end
