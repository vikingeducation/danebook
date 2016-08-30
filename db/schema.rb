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

ActiveRecord::Schema.define(version: 20160827170909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "address_1"
    t.string   "address_2"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree

  create_table "birthdays", force: :cascade do |t|
    t.integer  "profile_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.date     "date_object", default: '1986-08-20'
  end

  add_index "birthdays", ["profile_id"], name: "index_birthdays_on_profile_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "likes_count",      default: 0
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contact_infos", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contact_infos", ["profile_id"], name: "index_contact_infos_on_profile_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "hometowns", force: :cascade do |t|
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hometowns", ["profile_id"], name: "index_hometowns_on_profile_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "likes", ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.binary   "data"
    t.string   "filename"
    t.string   "mime_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "likes_count"
  end

  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "likes_count", default: 0
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "profile_photos", force: :cascade do |t|
    t.integer  "profile_id", null: false
    t.integer  "photo_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profile_photos", ["photo_id"], name: "index_profile_photos_on_photo_id", using: :btree
  add_index "profile_photos", ["profile_id"], name: "index_profile_photos_on_profile_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "words"
    t.string   "about"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.string   "college"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "residences", force: :cascade do |t|
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "residences", ["profile_id"], name: "index_residences_on_profile_id", using: :btree

  create_table "testings", force: :cascade do |t|
    t.string   "name"
    t.string   "forest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "testings", ["forest"], name: "index_testings_on_forest", using: :btree

  create_table "timelines", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "activation_digest"
    t.boolean  "activated",           default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "friendable_id"
    t.string   "friendable_type"
    t.integer  "timeline_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["friendable_type", "friendable_id"], name: "index_users_on_friendable_type_and_friendable_id", using: :btree
  add_index "users", ["timeline_id"], name: "index_users_on_timeline_id", using: :btree

  add_foreign_key "birthdays", "profiles"
  add_foreign_key "comments", "users"
  add_foreign_key "contact_infos", "profiles"
  add_foreign_key "hometowns", "profiles"
  add_foreign_key "likes", "users"
  add_foreign_key "photos", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "profile_photos", "photos"
  add_foreign_key "profile_photos", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "residences", "profiles"
  add_foreign_key "users", "timelines"
end
