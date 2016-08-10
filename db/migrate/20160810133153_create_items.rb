class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :product, index: true
      t.integer 'amount', :default => 0
      t.timestamps null: false
    end
  end
end
