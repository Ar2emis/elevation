# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_26_090114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exports", force: :cascade do |t|
    t.string "code", null: false
    t.integer "amount", null: false
    t.bigint "grain_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grain_type_id"], name: "index_exports_on_grain_type_id"
  end

  create_table "grain_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "storages", force: :cascade do |t|
    t.string "name", null: false
    t.integer "capacity", null: false
    t.integer "fullness", default: 0, null: false
    t.bigint "grain_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grain_type_id"], name: "index_storages_on_grain_type_id"
  end

  create_table "supplies", force: :cascade do |t|
    t.string "code", null: false
    t.integer "weight", null: false
    t.bigint "grain_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grain_type_id"], name: "index_supplies_on_grain_type_id"
  end

  create_table "temporary_storages", force: :cascade do |t|
    t.integer "amount", default: 0
    t.bigint "grain_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grain_type_id"], name: "index_temporary_storages_on_grain_type_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "from", null: false
    t.string "to", null: false
    t.integer "amount", null: false
    t.bigint "grain_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grain_type_id"], name: "index_transactions_on_grain_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "exports", "grain_types"
  add_foreign_key "storages", "grain_types"
  add_foreign_key "supplies", "grain_types"
  add_foreign_key "temporary_storages", "grain_types"
  add_foreign_key "transactions", "grain_types"
end
