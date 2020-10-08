class RenameImageUrlToImage < ActiveRecord::Migration[6.0]
  def change
      rename_column :movies, :image_url, :image
  end
end
