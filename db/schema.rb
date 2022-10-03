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

ActiveRecord::Schema[7.0].define(version: 2022_10_02_035643) do
  create_table "gcds", force: :cascade do |t|
    t.string "vin", null: false
    t.integer "fuel", null: false
    t.integer "odometer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vin"], name: "index_gcds_on_vin", unique: true
  end

  create_table "ignite_locations", force: :cascade do |t|
    t.string "vin", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vin"], name: "index_ignite_locations_on_vin", unique: true
  end

  create_table "vehicle_profiles", force: :cascade do |t|
    t.string "vin", null: false
    t.integer "year", null: false
    t.string "model", null: false
    t.string "brand", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vin"], name: "index_vehicle_profiles_on_vin", unique: true
  end

end
