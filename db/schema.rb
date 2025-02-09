# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_16_201724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interests", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "product_id", null: false
    t.integer "score", null: false
    t.index ["product_id"], name: "index_interests_on_product_id"
    t.index ["user_id", "product_id"], name: "index_interests_on_user_id_and_product_id", unique: true
  end

  create_table "products", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "category", null: false
  end

end
