class DropCastMovieTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :cast_movies
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
