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

ActiveRecord::Schema.define(version: 20160224031110) do

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"

  create_table "friendings", force: :cascade do |t|
    t.integer  "friender_id", null: false
    t.integer  "friend_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "friendings", ["friender_id", "friend_id"], name: "index_friendings_on_friender_id_and_friend_id", unique: true

  create_table "likes", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "likes", ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "birthday"
    t.string   "hometown"
    t.string   "current_location"
    t.string   "school"
    t.string   "motto"
    t.text     "about"
    t.string   "telephone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "gender"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "avatar_id"
    t.integer  "cover_photo_id"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true

end
