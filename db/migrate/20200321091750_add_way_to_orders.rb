class AddWayToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :way, :integer, null: false, default: 0
  end
end
