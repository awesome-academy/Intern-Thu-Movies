class CreateFavoriateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :favoriate_movies do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :type, default: 0

      t.timestamps
    end
  end
end
