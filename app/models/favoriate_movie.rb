class FavoriateMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  enum type: {like: 0, save: 1}
end
