class AddCurrentOrderToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_order, :integer, default: 0, null: false, unique: true
  end
end
