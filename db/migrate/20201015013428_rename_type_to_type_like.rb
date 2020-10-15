class RenameTypeToTypeLike < ActiveRecord::Migration[6.0]
  def change
    rename_column :favoriate_movies, :type, :typelike
  end
end
