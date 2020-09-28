class CastMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :cast
end
