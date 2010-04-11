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

ActiveRecord::Schema.define(:version => 20100411222352) do

  create_table "appellation_translations", :force => true do |t|
    t.integer  "appellation_id"
    t.string   "locale"
    t.string   "sort_name"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appellation_translations", ["appellation_id"], :name => "index_appellation_translations_on_appellation_id"

  create_table "appellations", :force => true do |t|
    t.text     "notes"
    t.boolean  "publish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appellations", ["publish"], :name => "publish"

  create_table "calendar_types", :force => true do |t|
    t.string   "name"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "position"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["position"], :name => "index_categories_on_position"
  add_index "categories", ["publish"], :name => "index_categories_on_publish"

  create_table "categorizations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["item_id"], :name => "index_categorizations_on_item_id"

  create_table "category_translations", :force => true do |t|
    t.integer  "category_id"
    t.string   "locale"
    t.text     "description"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"

  create_table "collection_translations", :force => true do |t|
    t.integer  "collection_id"
    t.string   "locale"
    t.string   "caption"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sort_name"
  end

  add_index "collection_translations", ["collection_id"], :name => "index_collection_translations_on_collection_id"
  add_index "collection_translations", ["name"], :name => "index_collection_translations_name"
  add_index "collection_translations", ["sort_name"], :name => "index_collection_translations_on_sort_name"

  create_table "collections", :force => true do |t|
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state_province"
    t.string   "postal_code"
    t.string   "telephone"
    t.string   "email"
    t.string   "website"
    t.string   "contact"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "publish",        :default => true
  end

  add_index "collections", ["publish"], :name => "index_collections_on_publish"

  create_table "exhibition_translations", :force => true do |t|
    t.integer  "exhibition_id"
    t.string   "locale"
    t.text     "introduction"
    t.string   "author"
    t.text     "conclusion"
    t.string   "title"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "display_date",  :null => false
  end

  add_index "exhibition_translations", ["exhibition_id"], :name => "index_exhibition_translations_on_exhibition_id"
  add_index "exhibition_translations", ["title"], :name => "title"

  create_table "exhibitions", :force => true do |t|
    t.date     "date"
    t.boolean  "featured"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :default => 0, :null => false
  end

  add_index "exhibitions", ["featured"], :name => "featured"
  add_index "exhibitions", ["publish"], :name => "publish"

  create_table "formats", :force => true do |t|
    t.string   "name"
    t.string   "extension"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  add_index "item_translations", ["title"], :name => "title"

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
    t.integer  "period_id"
    t.integer  "category_id"
    t.string   "source_date"
    t.integer  "calendar_type_id"
  end

  add_index "items", ["accession_num"], :name => "accession_num", :unique => true
  add_index "items", ["category_id"], :name => "index_items_on_category_id"
  add_index "items", ["collection_id"], :name => "collection_id"
  add_index "items", ["olivia_id"], :name => "olivia_id"
  add_index "items", ["period_id"], :name => "index_items_on_period_id"
  add_index "items", ["publish"], :name => "publish"
  add_index "items", ["sort_date"], :name => "sort_date"

  create_table "media", :force => true do |t|
    t.integer  "position"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media", ["position"], :name => "index_media_on_position"
  add_index "media", ["publish"], :name => "index_media_on_publish"

  create_table "medium_translations", :force => true do |t|
    t.integer  "medium_id"
    t.string   "locale"
    t.text     "description"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medium_translations", ["medium_id"], :name => "index_medium_translations_on_medium_id"

  create_table "owner_translations", :force => true do |t|
    t.integer  "owner_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "owner_translations", ["owner_id"], :name => "index_owner_translations_on_owner_id"

  create_table "owners", :force => true do |t|
    t.string   "address"
    t.string   "address2"
    t.string   "state_province"
    t.string   "postal_code"
    t.string   "country"
    t.string   "telephone"
    t.string   "email"
    t.string   "url"
    t.string   "contact"
    t.text     "terms"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_translations", :force => true do |t|
    t.integer  "page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "author"
    t.text     "body"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "page_translations", ["page_id"], :name => "index_page_translations_on_page_id"
  add_index "page_translations", ["title"], :name => "index_page_translations_on_title"

  create_table "pages", :force => true do |t|
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["publish"], :name => "index_pages_on_publish"

  create_table "people", :force => true do |t|
    t.string   "loc_name"
    t.boolean  "major",      :default => false
    t.date     "dob"
    t.date     "dod"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.boolean  "publish",    :default => true
  end

  add_index "people", ["publish"], :name => "index_people_on_publish"

  create_table "period_translations", :force => true do |t|
    t.integer  "period_id"
    t.string   "locale"
    t.text     "description"
    t.string   "title"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "period_translations", ["period_id"], :name => "index_period_translations_on_period_id"

  create_table "periods", :force => true do |t|
    t.integer  "position"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start_year"
    t.integer  "end_year"
  end

  add_index "periods", ["position"], :name => "index_periods_on_position"
  add_index "periods", ["publish"], :name => "index_periods_on_publish"

  create_table "person_translations", :force => true do |t|
    t.integer  "person_id"
    t.string   "locale"
    t.text     "description"
    t.string   "sort_name"
    t.string   "vitals"
    t.string   "name"
    t.string   "birth_place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_translations", ["person_id"], :name => "index_person_translations_on_person_id"

  create_table "place_translations", :force => true do |t|
    t.integer  "place_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "place_translations", ["name"], :name => "index_place_translations_on_name"
  add_index "place_translations", ["place_id"], :name => "index_place_translations_on_place_id"

  create_table "places", :force => true do |t|
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "x"
    t.integer  "y"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "places", ["publish"], :name => "index_places_on_publish"

  create_table "relationships", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", :force => true do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translations", ["key"], :name => "index_translations_on_key"
  add_index "translations", ["locale", "key"], :name => "index_translations_on_locale_key", :unique => true
  add_index "translations", ["locale"], :name => "index_translations_on_locale"

end
