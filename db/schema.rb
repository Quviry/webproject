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

ActiveRecord::Schema[7.0].define(version: 2023_02_07_155147) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "episode_id", null: false
    t.integer "comment_id"
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["episode_id"], name: "index_comments_on_episode_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "schedule_date"
    t.text "description"
    t.boolean "nsfw", default: false, null: false
    t.boolean "comments_enabled", default: true, null: false
    t.integer "series_id", null: false
    t.string "type", null: false
    t.integer "scene", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
    t.integer "views_count", default: 0
    t.integer "comments_count", default: 0
    t.index ["series_id"], name: "index_episodes_on_series_id"
    t.index ["title", "series_id"], name: "index_episodes_on_title_and_series_id", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_genres_on_title", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "episode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_likes_on_episode_id"
    t.index ["user_id", "episode_id"], name: "index_likes_on_user_id_and_episode_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "profile_activators", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_profile_activators_on_code", unique: true
    t.index ["user_id"], name: "index_profile_activators_on_user_id", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "display_name"
    t.string "location"
    t.string "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["display_name"], name: "index_profiles_on_display_name", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "type", null: false
    t.string "title", default: "", null: false
    t.string "url", default: "", null: false
    t.text "description"
    t.integer "genre_id", null: false
    t.integer "likes_count"
    t.integer "views_count"
    t.integer "comments_count"
    t.integer "user_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_series_on_genre_id"
    t.index ["title"], name: "index_series_on_title", unique: true
    t.index ["url"], name: "index_series_on_url", unique: true
    t.index ["user_id"], name: "index_series_on_user_id"
  end

  create_table "series_genres", id: false, force: :cascade do |t|
    t.integer "series_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["series_id", "genre_id"], name: "index_series_genres_on_series_id_and_genre_id", unique: true
  end

  create_table "series_tags", id: false, force: :cascade do |t|
    t.integer "series_id", null: false
    t.integer "tag_id", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id"
    t.string "start_sign_in_ip"
    t.string "current_sign_in_ip"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "series_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["series_id"], name: "index_subscriptions_on_series_id"
    t.index ["user_id", "series_id"], name: "index_subscriptions_on_user_id_and_series_id", unique: true
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_tags_on_title", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "login"
    t.boolean "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "views", force: :cascade do |t|
    t.integer "user_id"
    t.integer "episode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_views_on_episode_id"
    t.index ["user_id"], name: "index_views_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "episodes", "series"
end
