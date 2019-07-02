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

ActiveRecord::Schema.define(version: 20190629153322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "benefits", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_benefits_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "benefit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["benefit_id"], name: "index_contracts_on_benefit_id"
    t.index ["project_id"], name: "index_contracts_on_project_id"
  end

  create_table "donations", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.integer "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_donations_on_project_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "estimated_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_requirements_on_project_id"
    t.index ["user_id"], name: "index_requirements_on_user_id"
  end

  create_table "user_benefits", force: :cascade do |t|
    t.bigint "benefit_id"
    t.bigint "user_id"
    t.string "coupon_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["benefit_id"], name: "index_user_benefits_on_benefit_id"
    t.index ["user_id"], name: "index_user_benefits_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "user_type", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "description"
    t.string "rut"
    t.string "address"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "validation_file_name"
    t.string "validation_content_type"
    t.integer "validation_file_size"
    t.datetime "validation_updated_at"
    t.string "compromise_file_name"
    t.string "compromise_content_type"
    t.integer "compromise_file_size"
    t.datetime "compromise_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "benefits", "users"
  add_foreign_key "contracts", "benefits"
  add_foreign_key "contracts", "projects"
  add_foreign_key "donations", "projects"
  add_foreign_key "donations", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "requirements", "projects"
  add_foreign_key "requirements", "users"
  add_foreign_key "user_benefits", "benefits"
  add_foreign_key "user_benefits", "users"
end
