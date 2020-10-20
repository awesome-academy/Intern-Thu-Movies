class AddStatusToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :status, :integer, default: 0
    add_index :movies, :status
  end
end
