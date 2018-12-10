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

ActiveRecord::Schema.define(version: 20181117002204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.text     "body",             default: " ", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

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
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "friender_id"
    t.integer  "friendee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["friendee_id"], name: "index_friendships_on_friendee_id", using: :btree
    t.index ["friender_id", "friendee_id"], name: "index_friendships_on_friender_id_and_friendee_id", unique: true, using: :btree
    t.index ["friender_id"], name: "index_friendships_on_friender_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.string   "likable_type"
    t.integer  "likable_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["user_id"], name: "index_photos_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["updated_at"], name: "index_posts_on_updated_at", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.citext   "first_name",       null: false
    t.citext   "last_name",        null: false
    t.date     "birthday",         null: false
    t.string   "college"
    t.string   "hometown"
    t.string   "current_town"
    t.string   "telephone"
    t.text     "words_to_live_by"
    t.text     "about_me"
    t.string   "gender"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "profile_photo_id"
    t.integer  "cover_photo_id"
    t.index ["first_name"], name: "index_profiles_on_first_name", using: :btree
    t.index ["last_name"], name: "index_profiles_on_last_name", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.string   "auth_token",                      null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "unsubscribe",     default: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "users"
end
