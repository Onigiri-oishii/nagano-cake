class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      
      t.integer :order_status, null: false, default: 0

      t.string :way, null: false
      t.integer :fee, null: false, default: 800
      t.integer :total_products, null: false
      t.integer :total_pay, null: false
      t.string :address, null: false
      t.string :postal, null: false
      t.string :telephone, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
