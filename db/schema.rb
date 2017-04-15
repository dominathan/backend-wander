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

ActiveRecord::Schema.define(version: 20170415204519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_comments_on_place_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_favorites_on_place_id", using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.string   "friendable_type"
    t.integer  "friendable_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blocker_id"
    t.integer  "status"
    t.index ["friend_id"], name: "friend_id_ix", using: :btree
  end

  create_table "group_places", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_places_on_group_id", using: :btree
    t.index ["place_id"], name: "index_group_places_on_place_id", using: :btree
  end

  create_table "group_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "pending"
    t.boolean  "accepted"
    t.index ["group_id"], name: "index_group_users_on_group_id", using: :btree
    t.index ["user_id"], name: "index_group_users_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.boolean  "private"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "place_id"
    t.index ["place_id"], name: "index_images_on_place_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "friend_id"
    t.index ["place_id"], name: "index_likes_on_place_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "place_types", force: :cascade do |t|
    t.integer  "type_id"
    t.integer  "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_place_types_on_place_id", using: :btree
    t.index ["type_id"], name: "index_place_types_on_type_id", using: :btree
  end

  create_table "place_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_place_users_on_place_id", using: :btree
    t.index ["user_id"], name: "index_place_users_on_user_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.string   "google_id"
    t.string   "google_place_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "city"
    t.string   "country"
    t.jsonb    "data"
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "birthday"
    t.string   "photo_url"
    t.string   "email"
    t.string   "gender"
    t.string   "facebook_id"
    t.string   "refresh_token"
    t.string   "access_token"
    t.string   "id_token"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "expert",          default: false
    t.string   "expert_blog_log"
  end

  add_foreign_key "comments", "places"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "places"
  add_foreign_key "favorites", "users"
  add_foreign_key "group_places", "groups"
  add_foreign_key "group_places", "places"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "likes", "places"
  add_foreign_key "likes", "users"
  add_foreign_key "place_types", "places"
  add_foreign_key "place_types", "types"
  add_foreign_key "place_users", "places"
  add_foreign_key "place_users", "users"
end
