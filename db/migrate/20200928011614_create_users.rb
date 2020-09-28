class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :avatar_url
      t.integer :role, default: 0
      t.boolean :activated, default: false
      t.timestamps
    end
  end
end
