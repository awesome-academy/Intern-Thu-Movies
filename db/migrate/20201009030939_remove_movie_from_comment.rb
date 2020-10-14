class RemoveMovieFromComment < ActiveRecord::Migration[6.0]
  def change
    remove_reference :comments, :movie, null: false, foreign_key: true
  end
end
