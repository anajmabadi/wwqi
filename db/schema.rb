# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100319201556) do

  create_table "item_translations", :force => true do |t|
    t.integer  "item_id"
    t.string   "locale"
    t.string   "display_date"
    t.text     "description"
    t.string   "title"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_translations", ["item_id"], :name => "index_item_translations_on_item_id"

  create_table "items", :force => true do |t|
    t.string   "accession_num"
    t.string   "olivia_id"
    t.string   "urn"
    t.integer  "creator_id"
    t.integer  "owner_id"
    t.integer  "collection_id"
    t.integer  "pages"
    t.integer  "format_id"
    t.date     "sort_date"
    t.string   "dimensions"
    t.text     "notes"
    t.integer  "place_id"
    t.boolean  "publish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
