class AddFieldsToPurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :quantity, :integer, default: 1 #set the default value of quantity to 1.
    add_column :purchases, :total, :integer


    reversible do |dir| #The reversible block is used to execute an SQL statement to update the total column based on the existing price and quantity values.
      dir.up do
        execute <<~SQL
          UPDATE purchases
          SET total = price * quantity
        SQL
      end
    end
  end
end
