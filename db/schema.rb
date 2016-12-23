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

ActiveRecord::Schema.define(version: 20161223163812) do

  create_table "events", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "group_id",   limit: 4
    t.boolean  "raffled"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "events", ["group_id"], name: "index_events_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "user_events", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "pair_id",    limit: 4
  end

  add_index "user_events", ["event_id"], name: "index_user_events_on_event_id", using: :btree
  add_index "user_events", ["pair_id"], name: "index_user_events_on_pair_id", using: :btree
  add_index "user_events", ["user_id"], name: "index_user_events_on_user_id", using: :btree

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "group_id",    limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "invite_flag",           default: false
  end

  add_index "user_groups", ["group_id"], name: "index_user_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "events", "groups"
  add_foreign_key "groups", "users"
  add_foreign_key "user_events", "events"
  add_foreign_key "user_events", "users"
  add_foreign_key "user_events", "users", column: "pair_id"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
