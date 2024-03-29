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

ActiveRecord::Schema[7.1].define(version: 2024_02_12_140304) do
  create_table "restaurants", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
    t.time "available_start_time"
    t.time "available_end_time"
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "roles", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "table_bookings", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "table_restaurant_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restaurant_id"
    t.boolean "cancellation", default: false
    t.index ["table_restaurant_id"], name: "index_table_bookings_on_table_restaurant_id"
    t.index ["user_id"], name: "index_table_bookings_on_user_id"
  end

  create_table "table_restaurants", charset: "utf8mb3", force: :cascade do |t|
    t.integer "table_number"
    t.integer "no_of_chairs"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
    t.index ["restaurant_id"], name: "index_table_restaurants_on_restaurant_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "password"
    t.boolean "is_active"
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "restaurants", "users"
  add_foreign_key "table_bookings", "table_restaurants"
  add_foreign_key "table_bookings", "users"
  add_foreign_key "table_restaurants", "restaurants"
  add_foreign_key "users", "roles"
end
