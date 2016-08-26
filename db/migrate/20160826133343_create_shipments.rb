class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.belongs_to :order, index: true
      t.string :title, :null => false
      t.string :description
      t.float :price, :null => false, :default => '0.0'
      t.timestamps null: false
    end
  end
end
