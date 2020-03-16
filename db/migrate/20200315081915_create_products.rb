class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genres_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :no_tax, null: false
      t.string :image_id
      t.boolean :sale_status, null: false, default: true

      t.timestamps
    end
  end
end
