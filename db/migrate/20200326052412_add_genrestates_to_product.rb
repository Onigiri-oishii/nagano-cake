class AddGenrestatesToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :genre_status, :boolean
  end
end
