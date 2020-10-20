class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.string :score
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.timestamps
    end
  end
end
