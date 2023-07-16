# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_10_204536) do
  create_table "clients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number", limit: 20, null: false
    t.string "email", limit: 100, null: false
    t.string "address", limit: 300
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_count"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["phone_number"], name: "index_clients_on_phone_number", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email"
    t.index ["phone_number"], name: "index_customers_on_phone_number"
  end

  create_table "orders", force: :cascade do |t|
    t.string "product_name"
    t.text "description"
    t.float "price"
    t.string "payment_terms"
    t.date "delivery_date"
    t.string "status"
    t.string "image"
    t.integer "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "product_name"
    t.text "description", limit: 500, null: false
    t.float "price"
    t.string "payment_terms"
    t.date "delivery_date"
    t.string "status"
    t.string "image"
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.integer "total"
    t.index ["client_id"], name: "index_purchases_on_client_id"
  end

  add_foreign_key "orders", "customers"
  add_foreign_key "purchases", "clients"
end
