class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.float 'shipment', :default => 0.0
      t.float 'subtotal', :default => 0.0
      t.float 'grand_total', :default => 0.0
      t.string 'status', :default => 'In process'
      t.timestamps null: false
    end
  end
end
