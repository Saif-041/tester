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

ActiveRecord::Schema[7.0].define(version: 2022_08_29_221034) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drops", force: :cascade do |t|
    t.string "reward_type", default: "Dollar"
    t.float "reward_amount", default: 0.0
    t.boolean "is_active", default: false
    t.float "longitude"
    t.float "latitude"
    t.datetime "time_to_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "message_heading"
    t.text "message_details"
    t.bigint "user_id", null: false
    t.boolean "is_resolved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "ngos", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "polls", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ngo_id_1_id"
    t.bigint "ngo_id_2_id"
    t.bigint "ngo_id_3_id"
    t.bigint "ngo_id_4_id"
    t.integer "ngo_1_votes", default: 0
    t.integer "ngo_2_votes", default: 0
    t.integer "ngo_3_votes", default: 0
    t.integer "ngo_4_votes", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expire_time", default: "2022-08-29 22:12:58"
    t.index ["ngo_id_1_id"], name: "index_polls_on_ngo_id_1_id"
    t.index ["ngo_id_2_id"], name: "index_polls_on_ngo_id_2_id"
    t.index ["ngo_id_3_id"], name: "index_polls_on_ngo_id_3_id"
    t.index ["ngo_id_4_id"], name: "index_polls_on_ngo_id_4_id"
    t.index ["user_id"], name: "index_polls_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "vote_casted", default: false
    t.string "country", default: ""
    t.string "city", default: ""
    t.string "name", default: ""
    t.string "role", default: "unpaid"
    t.float "total_collections", default: 0.0
    t.boolean "payment_status", default: false
    t.datetime "payment_date"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "feedbacks", "users"
  add_foreign_key "polls", "ngos", column: "ngo_id_1_id"
  add_foreign_key "polls", "ngos", column: "ngo_id_2_id"
  add_foreign_key "polls", "ngos", column: "ngo_id_3_id"
  add_foreign_key "polls", "ngos", column: "ngo_id_4_id"
  add_foreign_key "polls", "users"
end
