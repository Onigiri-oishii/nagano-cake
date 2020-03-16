class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.integer :product_id, null: false
      t.integer :order_id, null: false
      t.integer :production_status, null: false, default: 0
      t.integer :number, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
