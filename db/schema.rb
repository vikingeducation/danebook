# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151102212838) do

  create_table "genders", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name", limit: 32
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "genders", ["name"], name: "index_genders_on_name"
  add_index "genders", ["short_name"], name: "index_genders_on_short_name"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "gender_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["birthday"], name: "index_users_on_birthday"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["first_name"], name: "index_users_on_first_name"
  add_index "users", ["gender_id"], name: "index_users_on_gender_id"
  add_index "users", ["last_name"], name: "index_users_on_last_name"

end
