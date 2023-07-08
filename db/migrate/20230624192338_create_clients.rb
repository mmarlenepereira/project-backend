class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number, null: false, limit: 20
      t.string :email, null: false, limit: 100
      t.string :address, limit: 300

      t.timestamps
    end

    add_index :clients, :phone_number, unique: true
    add_index :clients, :email, unique: true
  end
end
