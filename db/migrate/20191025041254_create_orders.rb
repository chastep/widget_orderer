class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :quantity, null: false
      t.string :color, null: false
      t.date :deliver_by, null: false

      t.timestamps
    end
  end
end
