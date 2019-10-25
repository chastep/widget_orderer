class LinkOrdersAndTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :type_id, :integer
    add_foreign_key :orders, :types, column: :type_id
    add_index :orders, :type_id
  end
end
