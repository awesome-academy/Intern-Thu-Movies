class CreateCasts < ActiveRecord::Migration[6.0]
  def change
    create_table :casts do |t|
      t.string :cast_name
      t.date :birthday
      t.string :birthplace

      t.timestamps
    end
  end
end
