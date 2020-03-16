class CreateReceivers < ActiveRecord::Migration[5.2]
  def change
    create_table :receivers do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.string :postal, null: false

      t.timestamps
    end
  end
end
