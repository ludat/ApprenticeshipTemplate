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

ActiveRecord::Schema.define(version: 20160914194504) do

  create_table "books", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "isbn",       null: false
    t.integer  "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_books", force: :cascade do |t|
    t.integer  "cart_id",                null: false
    t.integer  "book_id",                null: false
    t.integer  "amount",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cart_sessions", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "last_operated_at"
  end

  add_index "cart_sessions", ["cart_id"], name: "index_cart_sessions_on_cart_id"
  add_index "cart_sessions", ["user_id"], name: "index_cart_sessions_on_user_id"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number",          null: false
    t.date     "expiration_date", null: false
    t.integer  "user_id",         null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id"

  create_table "sales", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sales", ["book_id"], name: "index_sales_on_book_id"
  add_index "sales", ["user_id"], name: "index_sales_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",   null: false
    t.string   "password",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
