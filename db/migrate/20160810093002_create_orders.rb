class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.belongs_to :shipment
      t.belongs_to :address
      t.float 'subtotal', :default => 0.0, null: false
      t.float 'grand_total', :default => 0.0, null: false
      t.string 'status', :default => 'Pending', null: false
      t.timestamps null: false
    end
  end
end
