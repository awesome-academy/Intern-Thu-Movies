class AddAvatarToCasts < ActiveRecord::Migration[6.0]
  def change
    add_column :casts, :avatar, :string
  end
end
