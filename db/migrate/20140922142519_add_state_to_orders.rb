class AddStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string, default: "new"
  end
end
