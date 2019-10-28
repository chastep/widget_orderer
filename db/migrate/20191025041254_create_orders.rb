class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :uuid, null: false, unique: true
      t.integer :quantity, null: false
      t.string :color, null: false
      t.datetime :deliver_by, null: false

      t.timestamps
    end
  end
end
