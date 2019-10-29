class AddStateToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :status, :string, null: false, default: 'pending'
  end
end
