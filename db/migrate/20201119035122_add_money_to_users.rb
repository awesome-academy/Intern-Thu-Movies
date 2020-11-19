class AddMoneyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :money, :integer, default: 0
  end
end
