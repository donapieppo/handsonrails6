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
    t.string "pinnings_image", limit: 200
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "games", name: "comment_game_id_k"
  add_foreign_key "comments", "users", name: "comment_user_id_k"
  add_foreign_key "games", "colors", name: "game_color_id_k"
  add_foreign_key "games", "users", name: "game_user_id_k"
  add_foreign_key "reactions", "games", name: "reaction_game_id_k"
  add_foreign_key "reactions", "users", name: "reaction_user_id_k"
end
