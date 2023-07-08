class AddOrderCountToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :order_count, :integer
  end
end
