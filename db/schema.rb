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

ActiveRecord::Schema.define(version: 2023_05_31_110550) do

  create_table "doors", force: :cascade do |t|
    t.boolean "is_sliding", default: false, null: false
    t.integer "vehicle_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_doors_on_vehicle_id"
  end

  create_table "part_statuses", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parts", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicle_parts", force: :cascade do |t|
    t.integer "vehicle_id"
    t.integer "part_id"
    t.integer "part_status_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["part_id"], name: "index_vehicle_parts_on_part_id"
    t.index ["part_status_id"], name: "index_vehicle_parts_on_part_status_id"
    t.index ["vehicle_id"], name: "index_vehicle_parts_on_vehicle_id"
  end

  create_table "vehicle_type_parts", force: :cascade do |t|
    t.integer "vehicle_type_id"
    t.integer "part_id"
    t.integer "part_status_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["part_id"], name: "index_vehicle_type_parts_on_part_id"
    t.index ["part_status_id"], name: "index_vehicle_type_parts_on_part_status_id"
    t.index ["vehicle_type_id"], name: "index_vehicle_type_parts_on_vehicle_type_id"
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.text "name"
    t.boolean "has_doors", default: true, null: false
    t.boolean "has_sliding_doors", default: false, null: false
    t.boolean "has_seat", default: false, null: false
    t.integer "door_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.text "nickname", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "mileage"
    t.text "promotion_id"
    t.text "registration_id"
  end

end
