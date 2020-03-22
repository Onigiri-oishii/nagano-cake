class RemoveWayFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :way, :string
  end
end
