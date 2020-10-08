class RenameSourceMovieToFilm < ActiveRecord::Migration[6.0]
  def change
    rename_column :movies, :source_movie, :film
  end
end
