class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.string :product_name
      t.text :description, null: false, limit: 500
      t.float :price
      t.string :payment_terms
      t.date :delivery_date
      t.string :status
      t.string :image
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
