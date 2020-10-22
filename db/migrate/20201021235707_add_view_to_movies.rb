class AddViewToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :view, :integer, default: 0
    add_index :movies, :view
  end
end
