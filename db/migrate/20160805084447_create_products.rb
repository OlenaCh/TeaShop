class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string     'title'
      t.string     'short_description'
      t.string     'long_description'
      t.float      'price'
      t.boolean    'exists', :default => true
      t.binary     'image'
      t.timestamps null: false
    end
  end
end
