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

ActiveRecord::Schema.define(version: 20131114185409) do

  create_table "products", force: true do |t|
    t.integer  "lcbo_id"
    t.string   "name"
    t.integer  "price_in_cents"
    t.string   "primary_category"
    t.string   "secondary_category"
    t.string   "origin"
    t.integer  "price_per_liter_of_alcohol_in_cents"
    t.string   "producer_name"
    t.string   "image_thumb_url"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
