class CreateOrderLists < ActiveRecord::Migration
  def change
    create_table :order_lists do |t|
      t.belongs_to :item, index: true
      t.belongs_to :order, index: true
      t.timestamps null: false
    end
  end
end
