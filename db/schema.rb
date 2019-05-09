# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_05_071128) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "colors", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "val", null: false
  end

  create_table "comments", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false, unsigned: true
    t.integer "game_id", null: false, unsigned: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["game_id"], name: "game_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "games", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "color_id", unsigned: true
    t.integer "user_id", unsigned: true
    t.text "pinnings"
    t.string "tags", limit: 250
    t.boolean "competition"
    t.string "cache_reactions_counts", limit: 250
    t.datetime "created_at", null: false
    t.index ["color_id"], name: "color_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "organizations", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "city"
    t.string "home_page"
    t.string "logo_image"
  end

  create_table "reactions", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false, unsigned: true
    t.integer "game_id", null: false, unsigned: true
    t.string "name", limit: 100
    t.index ["game_id"], name: "game_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "users", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "manager"
    t.datetime "updated_at"
  end

  create_table "wp_commentmeta", primary_key: "meta_id", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "comment_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", size: :long
    t.index ["comment_id"], name: "comment_id"
    t.index ["meta_key"], name: "meta_key", length: 191
  end

  create_table "wp_comments", primary_key: "comment_ID", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "comment_post_ID", default: 0, null: false, unsigned: true
    t.text "comment_author", size: :tiny, null: false
    t.string "comment_author_email", limit: 100, default: "", null: false
    t.string "comment_author_url", limit: 200, default: "", null: false
    t.string "comment_author_IP", limit: 100, default: "", null: false
    t.datetime "comment_date", null: false
    t.datetime "comment_date_gmt", null: false
    t.text "comment_content", null: false
    t.integer "comment_karma", default: 0, null: false
    t.string "comment_approved", limit: 20, default: "1", null: false
    t.string "comment_agent", default: "", null: false
    t.string "comment_type", limit: 20, default: "", null: false
    t.bigint "comment_parent", default: 0, null: false, unsigned: true
    t.bigint "user_id", default: 0, null: false, unsigned: true
    t.index ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt"
    t.index ["comment_author_email"], name: "comment_author_email", length: 10
    t.index ["comment_date_gmt"], name: "comment_date_gmt"
    t.index ["comment_parent"], name: "comment_parent"
    t.index ["comment_post_ID"], name: "comment_post_ID"
  end

  create_table "wp_links", primary_key: "link_id", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "link_url", default: "", null: false
    t.string "link_name", default: "", null: false
    t.string "link_image", default: "", null: false
    t.string "link_target", limit: 25, default: "", null: false
    t.string "link_description", default: "", null: false
    t.string "link_visible", limit: 20, default: "Y", null: false
    t.bigint "link_owner", default: 1, null: false, unsigned: true
    t.integer "link_rating", default: 0, null: false
    t.datetime "link_updated", null: false
    t.string "link_rel", default: "", null: false
    t.text "link_notes", size: :medium, null: false
    t.string "link_rss", default: "", null: false
    t.index ["link_visible"], name: "link_visible"
  end

  create_table "wp_options", primary_key: "option_id", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "option_name", limit: 191, default: "", null: false
    t.text "option_value", size: :long, null: false
    t.string "autoload", limit: 20, default: "yes", null: false
    t.index ["option_name"], name: "option_name", unique: true
  end

  create_table "wp_postmeta", primary_key: "meta_id", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "post_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", size: :long
    t.index ["meta_key"], name: "meta_key", length: 191
    t.index ["post_id"], name: "post_id"
  end

  create_table "wp_posts", primary_key: "ID", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "post_author", default: 0, null: false, unsigned: true
    t.datetime "post_date", null: false
    t.datetime "post_date_gmt", null: false
    t.text "post_content", size: :long, null: false
    t.text "post_title", null: false
    t.text "post_excerpt", null: false
    t.string "post_status", limit: 20, default: "publish", null: false
    t.string "comment_status", limit: 20, default: "open", null: false
    t.string "ping_status", limit: 20, default: "open", null: false
    t.string "post_password", default: "", null: false
    t.string "post_name", limit: 200, default: "", null: false
    t.text "to_ping", null: false
    t.text "pinged", null: false
    t.datetime "post_modified", null: false
    t.datetime "post_modified_gmt", null: false
    t.text "post_content_filtered", size: :long, null: false
    t.bigint "post_parent", default: 0, null: false, unsigned: true
    t.string "guid", default: "", null: false
    t.integer "menu_order", default: 0, null: false
    t.string "post_type", limit: 20, default: "post", null: false
    t.string "post_mime_type", limit: 100, default: "", null: false
    t.bigint "comment_count", default: 0, null: false
    t.index ["post_author"], name: "post_author"
    t.index ["post_name"], name: "post_name", length: 191
    t.index ["post_parent"], name: "post_parent"
    t.index ["post_type", "post_status", "post_date", "ID"], name: "type_status_date"
  end

  create_table "wp_term_relationships", primary_key: ["object_id", "term_taxonomy_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "object_id", default: 0, null: false, unsigned: true
    t.bigint "term_taxonomy_id", default: 0, null: false, unsigned: true
    t.integer "term_order", default: 0, null: false
    t.index ["term_taxonomy_id"], name: "term_taxonomy_id"
  end

  create_table "wp_term_taxonomy", primary_key: "term_taxonomy_id", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "term_id", default: 0, null: false, unsigned: true
    t.string "taxonomy", limit: 32, default: "", null: false
    t.text "description", size: :long, null: false
    t.bigint "parent", default: 0, null: false, unsigned: true
    t.bigint "count", default: 0, null: false
    t.index ["taxonomy"], name: "taxonomy"
    t.index ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true
  end

  create_table "wp_termmeta", primary_key: "meta_id", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "term_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", size: :long
    t.index ["meta_key"], name: "meta_key", length: 191
    t.index ["term_id"], name: "term_id"
  end

  create_table "wp_terms", primary_key: "term_id", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 200, default: "", null: false
    t.string "slug", limit: 200, default: "", null: false
    t.bigint "term_group", default: 0, null: false
    t.index ["name"], name: "name", length: 191
    t.index ["slug"], name: "slug", length: 191
  end

  create_table "wp_usermeta", primary_key: "umeta_id", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "user_id", default: 0, null: false, unsigned: true
    t.string "meta_key"
    t.text "meta_value", size: :long
    t.index ["meta_key"], name: "meta_key", length: 191
    t.index ["user_id"], name: "user_id"
  end

  create_table "wp_users", primary_key: "ID", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "user_login", limit: 60, default: "", null: false
    t.string "user_pass", default: "", null: false
    t.string "user_nicename", limit: 50, default: "", null: false
    t.string "user_email", limit: 100, default: "", null: false
    t.string "user_url", limit: 100, default: "", null: false
    t.datetime "user_registered", null: false
    t.string "user_activation_key", default: "", null: false
    t.integer "user_status", default: 0, null: false
    t.string "display_name", limit: 250, default: "", null: false
    t.index ["user_email"], name: "user_email"
    t.index ["user_login"], name: "user_login_key"
    t.index ["user_nicename"], name: "user_nicename"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "games", name: "comment_game_id_k"
  add_foreign_key "comments", "users", name: "comment_user_id_k"
  add_foreign_key "games", "colors", name: "game_color_id_k"
  add_foreign_key "games", "users", name: "game_user_id_k"
  add_foreign_key "reactions", "games", name: "reaction_game_id_k"
  add_foreign_key "reactions", "users", name: "reaction_user_id_k"
end
