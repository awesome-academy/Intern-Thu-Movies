class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :image_url
      t.string :background_image
      t.string :slug
      t.text :overview
      t.string :source_movie
      t.string :trailer
      t.date :release_date
      t.string :runtime
      t.string :director

      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
