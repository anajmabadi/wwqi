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

ActiveRecord::Schema.define(:version => 20100528143828) do

  create_table "appearance_translations", :force => true do |t|
    t.integer  "appearance_id"
    t.string   "locale"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appearance_translations", ["appearance_id"], :name => "index_appearance_translations_on_appearance_id"

  create_table "appearances", :force => true do |t|
    t.integer  "item_id"
    t.integer  "person_id"
    t.boolean  "publish",    :default => true
    t.integer  "position",   :default => 0
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appearances", ["item_id"], :name => "index_appearances_on_item_id"
  add_index "appearances", ["person_id"], :name => "index_appearances_on_person_id"
  add_index "appearances", ["position"], :name => "index_appearances_on_position"
  add_index "appearances", ["publish"], :name => "index_appearances_on_publish"

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

  create_table "classifications", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "item_id"
    t.boolean  "publish",    :default => true, :null => false
    t.integer  "position",   :default => 0,    :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classifications", ["item_id", "subject_id"], :name => "index_classifications_on_item_id_and_subject_id", :unique => true
  add_index "classifications", ["item_id"], :name => "index_classifications_on_item_id"
  add_index "classifications", ["position"], :name => "index_classifications_on_position"
  add_index "classifications", ["publish"], :name => "index_classifications_on_publish"
  add_index "classifications", ["subject_id"], :name => "index_classifications_on_subject_id"

  create_table "clip_translations", :force => true do |t|
    t.integer  "clip_id"
    t.string   "locale"
    t.text     "caption"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clip_translations", ["clip_id"], :name => "index_clip_translations_on_clip_id"

  create_table "clip_types", :force => true do |t|
    t.string   "name"
    t.string   "extension"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clip_types", ["publish"], :name => "index_clip_types_on_publish"

  create_table "clips", :force => true do |t|
    t.integer  "item_id",                        :null => false
    t.integer  "clip_type_id",                   :null => false
    t.boolean  "publish",      :default => true, :null => false
    t.text     "notes"
    t.date     "recorded_on"
    t.integer  "position",     :default => 0,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clips", ["clip_type_id"], :name => "index_clips_on_clip_type_id"
  add_index "clips", ["item_id"], :name => "index_clips_on_item_id"
  add_index "clips", ["position"], :name => "index_clips_on_position"
  add_index "clips", ["publish"], :name => "index_clips_on_publish"

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

  create_table "image_translations", :force => true do |t|
    t.integer  "image_id"
    t.string   "locale"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_translations", ["image_id"], :name => "index_image_translations_on_image_id"

  create_table "images", :force => true do |t|
    t.integer  "item_id"
    t.string   "file_name"
    t.string   "dimensions"
    t.boolean  "verso"
    t.integer  "position"
    t.text     "notes"
    t.boolean  "publish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["item_id"], :name => "index_images_on_item_id"
  add_index "images", ["position"], :name => "index_images_on_position"
  add_index "images", ["publish"], :name => "index_images_on_publish"

  create_table "import", :force => true do |t|
    t.integer "item_id",                                  :null => false
    t.string  "accession_num",                            :null => false
    t.string  "file_name",                                :null => false
    t.integer "position",              :default => 1,     :null => false
    t.string  "title",                                    :null => false
    t.string  "title_fa",                                 :null => false
    t.integer "category_id",                              :null => false
    t.string  "material_type",                            :null => false
    t.string  "material_type_fa",                         :null => false
    t.string  "dimensions",                               :null => false
    t.boolean "verso",                 :default => false, :null => false
    t.boolean "bound",                 :default => false, :null => false
    t.integer "pages",                 :default => 1,     :null => false
    t.boolean "circa",                 :default => false, :null => false
    t.integer "calendar_type_id",      :default => 2,     :null => false
    t.string  "source_date",                              :null => false
    t.string  "islamic_date",                             :null => false
    t.string  "persian_date",                             :null => false
    t.string  "gregorian_date",                           :null => false
    t.integer "creator_id",                               :null => false
    t.string  "creator_label",                            :null => false
    t.string  "creator_label_fa",                         :null => false
    t.integer "place_id",                                 :null => false
    t.string  "place_created",                            :null => false
    t.string  "place_created_fa",                         :null => false
    t.string  "description",                              :null => false
    t.binary  "description_fa",                           :null => false
    t.string  "credit",                                   :null => false
    t.string  "credit_fa",                                :null => false
    t.string  "subject_names",                            :null => false
    t.string  "subject_names_fa",                         :null => false
    t.string  "subject_keywords",                         :null => false
    t.string  "subject_keywords_fa",                      :null => false
    t.text    "notes",                                    :null => false
    t.text    "notes_fa",                                 :null => false
    t.integer "corrections_additions",                    :null => false
    t.integer "collection_id",         :default => 12,    :null => false
  end

  create_table "import_people", :force => true do |t|
    t.integer "item_id",                :null => false
    t.string  "loc_name",               :null => false
    t.string  "name",                   :null => false
    t.string  "sort_name",              :null => false
    t.integer "publish",   :limit => 1, :null => false
    t.integer "major",     :limit => 1, :null => false
    t.string  "locale",    :limit => 4, :null => false
  end

  create_table "item_translations", :force => true do |t|
    t.integer  "item_id"
    t.string   "locale"
    t.string   "display_date"
    t.text     "description"
    t.string   "title"
    t.string   "credit"
    t.string   "creator_label"
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
    t.boolean  "circa",            :default => false, :null => false
    t.string   "dimensions"
    t.text     "notes"
    t.integer  "place_id"
    t.boolean  "bound",            :default => false, :null => false
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

  create_table "panel_translations", :force => true do |t|
    t.integer  "panel_id"
    t.string   "locale"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "panel_translations", ["panel_id"], :name => "index_panel_translations_on_panel_id"

  create_table "panels", :force => true do |t|
    t.integer  "exhibition_id",                   :null => false
    t.integer  "item_id",                         :null => false
    t.integer  "position",      :default => 0,    :null => false
    t.boolean  "publish",       :default => true, :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "panels", ["exhibition_id"], :name => "index_panels_on_exhibition_id"
  add_index "panels", ["item_id"], :name => "index_panels_on_item_id"
  add_index "panels", ["position"], :name => "index_panels_on_position"
  add_index "panels", ["publish"], :name => "index_panels_on_publish"

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
    t.datetime "start_at"
    t.datetime "end_at"
  end

  add_index "periods", ["end_at"], :name => "index_periods_end_at"
  add_index "periods", ["position"], :name => "index_periods_on_position"
  add_index "periods", ["publish"], :name => "index_periods_on_publish"
  add_index "periods", ["start_at"], :name => "index_periods_start_at"

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

  create_table "subject_translations", :force => true do |t|
    t.integer  "subject_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subject_translations", ["name"], :name => "index_subject_translations_on_name"
  add_index "subject_translations", ["subject_id"], :name => "index_subject_translations_on_subject_id"

  create_table "subjects", :force => true do |t|
    t.boolean  "major",      :default => false
    t.boolean  "publish",    :default => true
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["major"], :name => "index_subjects_on_major"
  add_index "subjects", ["publish"], :name => "index_subjects_on_publish"

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

  create_table "util_import_images", :id => false, :force => true do |t|
    t.integer  "id",         :default => 0,     :null => false
    t.string   "dimensions",                    :null => false
    t.boolean  "verso",      :default => false, :null => false
    t.integer  "position",   :default => 1,     :null => false
    t.text     "notes",                         :null => false
    t.string   "file_name",                     :null => false
    t.integer  "item_id",                       :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "publish",    :default => 0,     :null => false
  end

  create_table "util_import_images_english", :id => false, :force => true do |t|
    t.integer  "image_id",                 :default => 0,  :null => false
    t.string   "title",                                    :null => false
    t.string   "description",                              :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "locale",      :limit => 2, :default => "", :null => false
  end

  create_table "util_import_images_persian", :id => false, :force => true do |t|
    t.integer  "image_id",                 :default => 0,  :null => false
    t.string   "title",                                    :null => false
    t.binary   "description",                              :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "locale",      :limit => 2, :default => "", :null => false
  end

  create_table "util_import_items", :id => false, :force => true do |t|
    t.integer "id",               :default => 0,     :null => false
    t.string  "accession_num",                       :null => false
    t.string  "urn",                                 :null => false
    t.integer "pages"
    t.integer "category_id",                         :null => false
    t.string  "dimensions",                          :null => false
    t.integer "calendar_type_id", :default => 2,     :null => false
    t.string  "source_date",                         :null => false
    t.boolean "circa",            :default => false, :null => false
    t.boolean "bound",            :default => false, :null => false
    t.integer "collection_id",    :default => 12,    :null => false
  end

  create_table "util_import_items_english", :id => false, :force => true do |t|
    t.integer "item_id",                                    :null => false
    t.string  "title",                                      :null => false
    t.string  "description",                                :null => false
    t.string  "credit",                                     :null => false
    t.string  "locale",        :limit => 2, :default => "", :null => false
    t.string  "display_date",                               :null => false
    t.string  "creator_label",                              :null => false
  end

  create_table "util_import_items_persian", :id => false, :force => true do |t|
    t.integer "item_id",                                    :null => false
    t.string  "title",                                      :null => false
    t.binary  "description",                                :null => false
    t.string  "credit",                                     :null => false
    t.string  "locale",        :limit => 2, :default => "", :null => false
    t.string  "display_date",                               :null => false
    t.string  "creator_label",                              :null => false
  end

  create_table "vs_import_people", :id => false, :force => true do |t|
    t.string  "loc_name",              :null => false
    t.integer "major",    :limit => 1, :null => false
    t.integer "publish",  :limit => 1, :null => false
  end

  create_table "vs_import_people_appearances", :id => false, :force => true do |t|
    t.integer "person_id", :default => 0, :null => false
    t.integer "item_id",                  :null => false
  end

  create_table "vs_import_people_translations", :id => false, :force => true do |t|
    t.string  "locale",      :limit => 4,                :null => false
    t.string  "name",                                    :null => false
    t.string  "sort_name",                               :null => false
    t.integer "person_id",                :default => 0, :null => false
    t.integer "count_names", :limit => 8, :default => 0, :null => false
  end

end
