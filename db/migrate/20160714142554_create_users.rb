class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     'name'
      t.string     'email'
      t.string     'password'
      t.boolean    'admin'
      t.boolean    'activated',         default: false
      t.datetime   'activated_at'
      t.timestamps null: false
    end
  end
end
