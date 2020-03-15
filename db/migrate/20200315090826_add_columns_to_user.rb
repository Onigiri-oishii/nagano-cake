class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string, null: false, default: ""
    add_column :users, :lastname, :string, null: false, default: ""
    add_column :users, :firstname_kana, :string, null: false, default: ""
    add_column :users, :lastname_kana, :string, null: false, default: ""
    add_column :users, :postal, :string, null: false, default: ""
    add_column :users, :address, :string, null: false, default: ""
    add_column :users, :telephone, :string, null: false, default: ""
    add_column :users, :status, :boolean, null: false, default: true
  end
end
