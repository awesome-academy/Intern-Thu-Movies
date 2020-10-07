class RenameBackgroundImageToBackground < ActiveRecord::Migration[6.0]
  def change
    rename_column :movies, :background_image, :background
  end
end
