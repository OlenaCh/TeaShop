class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :user, index: true
      t.string :city, :default => ''
      t.string :zip_code, :default => ''
      t.string :address, :default => ''
      t.boolean :is_default, :default => false
      t.timestamps null: false
    end
  end
end
