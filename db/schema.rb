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

ActiveRecord::Schema.define(version: 20141201033903) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "friend_requests", force: true do |t|
    t.integer  "requester_id"
    t.integer  "requestee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_requests", ["requester_id", "requestee_id"], name: "index_friend_requests_on_requester_id_and_requestee_id", unique: true

  create_table "friendings", force: true do |t|
    t.integer  "friender_id"
    t.integer  "friendee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "likable_id"
    t.string   "likable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likable_id", "likable_type", "user_id"], name: "index_likes_on_likable_id_and_likable_type_and_user_id", unique: true

  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "posts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "body"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id",          null: false
    t.integer  "day",              null: false
    t.integer  "month",            null: false
    t.integer  "year",             null: false
    t.string   "gender",           null: false
    t.string   "college"
    t.string   "hometown"
    t.string   "currently_lives"
    t.string   "telephone"
    t.text     "words_to_live_by"
    t.text     "about_me"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true

  create_table "users", force: true do |t|
    t.string   "first_name",           null: false
    t.string   "last_name",            null: false
    t.string   "email",                null: false
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_photo_id"
    t.integer  "cover_photo_id"
    t.string   "github_uid"
    t.string   "github_provider"
    t.datetime "github_token_expires"
    t.string   "github_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email"

end
