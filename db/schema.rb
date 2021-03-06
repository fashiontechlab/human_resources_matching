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

ActiveRecord::Schema.define(version: 2022_01_27_043516) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "released_at", null: false
    t.datetime "expired_at"
    t.boolean "member_only", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.integer "member_id", null: false
    t.string "title", null: false
    t.text "body"
    t.datetime "posted_at", null: false
    t.string "status", default: "draft", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ryokan_id"
    t.index ["member_id"], name: "index_entries_on_member_id"
    t.index ["ryokan_id"], name: "index_entries_on_ryokan_id"
  end

  create_table "entry_images", force: :cascade do |t|
    t.integer "entry_id"
    t.string "alt_text", default: "", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_id"], name: "index_entry_images_on_entry_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.string "full_name"
    t.string "email"
    t.integer "sex", default: 1, null: false
    t.boolean "administrator", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "kana_name"
    t.string "mobile"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "schedule_id"
    t.integer "ryokan_id"
    t.datetime "start_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ryokan_id"], name: "index_reservations_on_ryokan_id"
    t.index ["schedule_id"], name: "index_reservations_on_schedule_id"
  end

  create_table "ryokans", force: :cascade do |t|
    t.string "name", null: false
    t.string "full_name", null: false
    t.string "kana_name"
    t.string "manager", null: false
    t.string "password_digest"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telephone"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.string "workday"
    t.datetime "start"
    t.datetime "end"
    t.integer "member_id"
    t.boolean "status", default: true, null: false
    t.boolean "approval_status", default: false, null: false
    t.integer "ryokan_id"
    t.datetime "hope_start"
    t.datetime "hope_end"
    t.datetime "afternoon_start"
    t.datetime "afternoon_end"
    t.datetime "hope_afternoon_start"
    t.datetime "hope_afternoon_end"
    t.datetime "confirm_afternoon_start"
    t.datetime "confirm_afternoon_end"
    t.datetime "confirm_start"
    t.datetime "confirm_end"
    t.string "amount"
    t.boolean "work_complete_status", default: false, null: false
    t.string "ryokan_amount"
    t.string "profit"
    t.string "total_ryokan_amount"
    t.string "system_cost"
    t.index ["member_id"], name: "index_schedules_on_member_id"
    t.index ["ryokan_id"], name: "index_schedules_on_ryokan_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "name"
    t.string "kana_name"
    t.integer "mobile"
    t.string "email"
    t.integer "sex", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "entry_id", null: false
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_id"], name: "index_votes_on_entry_id"
    t.index ["member_id"], name: "index_votes_on_member_id"
  end

end
