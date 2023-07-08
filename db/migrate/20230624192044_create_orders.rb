class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :product_name
      t.text :description
      t.float :price
      t.string :payment_terms
      t.date :delivery_date
      t.string :status
      t.string :image
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
