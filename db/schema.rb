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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110127034146) do

  create_table "activities", :force => true do |t|
    t.string   "browser",                            :null => false
    t.string   "session_id",                         :null => false
    t.string   "ip_address",                         :null => false
    t.integer  "user_id"
    t.string   "action"
    t.string   "params"
    t.integer  "collection_id"
    t.integer  "period_id"
    t.integer  "item_id"
    t.integer  "page_id"
    t.integer  "person_id"
    t.integer  "subject_id"
    t.integer  "subject_type_id"
    t.integer  "place_id"
    t.boolean  "success",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["collection_id"], :name => "index_activities_on_collection_id"
  add_index "activities", ["item_id"], :name => "index_activities_on_item_id"
  add_index "activities", ["page_id"], :name => "index_activities_on_page_id"
  add_index "activities", ["period_id"], :name => "index_activities_on_period_id"
  add_index "activities", ["person_id"], :name => "index_activities_on_person_id"
  add_index "activities", ["place_id"], :name => "index_activities_on_place_id"
  add_index "activities", ["subject_id"], :name => "index_activities_on_subject_id"
  add_index "activities", ["subject_type_id"], :name => "index_activities_on_subject_type_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "alternate_title_translations", :force => true do |t|
    t.integer  "alternate_title_id", :default => 0,    :null => false
    t.string   "locale",             :default => "en", :null => false
    t.string   "title"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alternate_title_translations", ["alternate_title_id"], :name => "index_9fc7d2daa22862304c3f93457c5762fa67f887a5"
  add_index "alternate_title_translations", ["caption"], :name => "index_alternate_title_translations_on_caption"
  add_index "alternate_title_translations", ["locale"], :name => "in_alternate_title_translations_locale"
  add_index "alternate_title_translations", ["title"], :name => "index_alternate_title_translations_on_title"

  create_table "alternate_titles", :force => true do |t|
    t.integer  "item_id",    :default => 0,    :null => false
    t.boolean  "publish",    :default => true, :null => false
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alternate_titles", ["item_id"], :name => "index_alternate_titles_on_item_id"
  add_index "alternate_titles", ["publish"], :name => "index_alternate_titles_on_publish"

  create_table "appearance_translations", :force => true do |t|
    t.integer  "appearance_id", :default => 0,    :null => false
    t.string   "locale",        :default => "en", :null => false
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appearance_translations", ["appearance_id", "locale"], :name => "index_appearance_translations_unique", :unique => true
  add_index "appearance_translations", ["appearance_id"], :name => "index_appearance_translations_on_appearance_id"
  add_index "appearance_translations", ["locale"], :name => "index_appearance_translations_locale"

  create_table "appearances", :force => true do |t|
    t.integer  "item_id",      :default => 0,    :null => false
    t.integer  "person_id",    :default => 0,    :null => false
    t.boolean  "publish",      :default => true, :null => false
    t.integer  "position",     :default => 0,    :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0,    :null => false
  end

  add_index "appearances", ["item_id", "person_id"], :name => "index_appearances_unique", :unique => true
  add_index "appearances", ["item_id"], :name => "index_appearances_on_item_id"
  add_index "appearances", ["person_id"], :name => "index_appearances_on_person_id"
  add_index "appearances", ["position"], :name => "index_appearances_on_position"
  add_index "appearances", ["publish"], :name => "index_appearances_on_publish"

  create_table "appellation_translations", :force => true do |t|
    t.integer  "appellation_id", :default => 0,    :null => false
    t.string   "locale",         :default => "en", :null => false
    t.string   "sort_name"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appellation_translations", ["appellation_id", "locale"], :name => "index_appellations_translations_unique", :unique => true
  add_index "appellation_translations", ["appellation_id"], :name => "index_appellation_translations_on_appellation_id"
  add_index "appellation_translations", ["locale"], :name => "index_appeallation_translations_locale"
  add_index "appellation_translations", ["sort_name"], :name => "in_sort_name"

  create_table "appellations", :force => true do |t|
    t.text     "notes"
    t.boolean  "publish",      :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",                      :null => false
    t.integer  "position",     :default => 1,    :null => false
    t.integer  "lock_version", :default => 0,    :null => false
  end

  add_index "appellations", ["person_id"], :name => "fk_appellations_people"
  add_index "appellations", ["person_id"], :name => "fk_relatives_people"
  add_index "appellations", ["position"], :name => "index_appellations_on_position"
  add_index "appellations", ["publish"], :name => "publish"

  create_table "calendar_types", :force => true do |t|
    t.string   "name",         :default => "",   :null => false
    t.boolean  "publish",      :default => true, :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0,    :null => false
  end

  add_index "calendar_types", ["name"], :name => "in_calendar_types_name", :unique => true
  add_index "calendar_types", ["publish"], :name => "in_calendar_types_publish"

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "position"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0, :null => false
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["position"], :name => "index_categories_on_position"
  add_index "categories", ["publish"], :name => "index_categories_on_publish"

  create_table "categorizations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0, :null => false
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
    t.integer  "subject_id",   :default => 0,    :null => false
    t.integer  "item_id",      :default => 0,    :null => false
    t.boolean  "publish",      :default => true, :null => false
    t.integer  "position",     :default => 0,    :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0,    :null => false
  end

  add_index "classifications", ["item_id", "subject_id"], :name => "index_classifications_on_item_id_and_subject_id", :unique => true
  add_index "classifications", ["item_id"], :name => "index_classifications_on_item_id"
  add_index "classifications", ["position"], :name => "index_classifications_on_position"
  add_index "classifications", ["publish"], :name => "index_classifications_on_publish"
  add_index "classifications", ["subject_id"], :name => "index_classifications_on_subject_id"

  create_table "clip_translations", :force => true do |t|
    t.integer  "clip_id",     :default => 0,    :null => false
    t.string   "locale",      :default => "en", :null => false
    t.text     "caption",                       :null => false
    t.string   "title",       :default => "",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "interviewer"
    t.string   "interviewee"
    t.string   "location"
  end

  add_index "clip_translations", ["clip_id", "locale"], :name => "in_clip_translations_unique", :unique => true
  add_index "clip_translations", ["clip_id"], :name => "index_clip_translations_on_clip_id"
  add_index "clip_translations", ["locale"], :name => "in_clip_translations_locale"

  create_table "clip_types", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "extension",    :default => "",   :null => false
    t.boolean  "publish",      :default => true, :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0,    :null => false
  end

  add_index "clip_types", ["name"], :name => "in_clip_types_name", :unique => true
  add_index "clip_types", ["publish"], :name => "index_clip_types_on_publish"

  create_table "clips", :force => true do |t|
    t.integer  "item_id",                        :null => false
    t.integer  "clip_type_id", :default => 1,    :null => false
    t.boolean  "publish",      :default => true, :null => false
    t.text     "notes"
    t.date     "recorded_on"
    t.integer  "position",     :default => 0,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0,    :null => false
    t.integer  "duration"
    t.integer  "owner_id"
  end

  add_index "clips", ["clip_type_id"], :name => "index_clips_on_clip_type_id"
  add_index "clips", ["item_id"], :name => "index_clips_on_item_id"
  add_index "clips", ["owner_id"], :name => "fk_clips_owners"
  add_index "clips", ["position"], :name => "index_clips_on_position"
  add_index "clips", ["publish"], :name => "index_clips_on_publish"

  create_table "collection_translations", :force => true do |t|
    t.integer  "collection_id", :default => 0,    :null => false
    t.string   "locale",        :default => "en", :null => false
    t.string   "caption"
    t.string   "name",          :default => "",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sort_name",     :default => "",   :null => false
    t.text     "description"
    t.string   "dates"
    t.text     "materials"
    t.text     "repository"
    t.text     "tips"
    t.string   "creator"
    t.text     "restrictions"
    t.text     "history"
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
    t.boolean  "publish",           :default => true,  :null => false
    t.boolean  "private",           :default => false, :null => false
    t.boolean  "finding_aid",       :default => false, :null => false
    t.integer  "lock_version",      :default => 0,     :null => false
    t.date     "acquired_on"
    t.integer  "interview_id"
    t.string   "acquired_by"
    t.string   "processed_by"
    t.text     "acquisition_notes"
    t.date     "last_edited"
    t.boolean  "major",             :default => false
  end

  add_index "collections", ["last_edited"], :name => "index_collections_on_last_edited"
  add_index "collections", ["major"], :name => "index_collections_on_major"
  add_index "collections", ["publish"], :name => "index_collections_on_publish"

  create_table "comments", :force => true do |t|
    t.string   "subject"
    t.text     "body",                         :null => false
    t.datetime "submitted_at"
    t.string   "ip"
    t.datetime "replied_at"
    t.string   "name",         :default => "", :null => false
    t.string   "email",        :default => "", :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["submitted_at"], :name => "index_comments_on_submitted_at"

  create_table "comp_translations", :force => true do |t|
    t.integer  "comp_id",    :default => 0,    :null => false
    t.string   "locale",     :default => "en", :null => false
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comp_translations", ["caption"], :name => "index_comp_translations_on_caption"
  add_index "comp_translations", ["comp_id"], :name => "index_comp_translations_on_comp_id"
  add_index "comp_translations", ["locale"], :name => "in_comp_translations_locale"

  create_table "comps", :force => true do |t|
    t.integer  "item_id",                      :null => false
    t.integer  "comp_id",                      :null => false
    t.integer  "position",   :default => 1,    :null => false
    t.boolean  "publish",    :default => true, :null => false
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comps", ["comp_id"], :name => "index_comps_on_comp_id"
  add_index "comps", ["item_id", "comp_id"], :name => "index_comps_on_item_id_and_comp_id", :unique => true
  add_index "comps", ["item_id"], :name => "index_comps_on_item_id"
  add_index "comps", ["position"], :name => "index_comps_on_position"
  add_index "comps", ["publish"], :name => "index_comps_on_publish"

  create_table "era_translations", :force => true do |t|
    t.integer  "era_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "era_translations", ["era_id"], :name => "index_era_translations_on_era_id"
  add_index "era_translations", ["title"], :name => "index_era_translations_on_title"

  create_table "eras", :force => true do |t|
    t.integer  "year"
    t.boolean  "publish",    :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "position",     :default => 0, :null => false
    t.integer  "lock_version", :default => 0, :null => false
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
    t.integer  "item_id",                                     :default => 0,     :null => false
    t.string   "file_name"
    t.boolean  "verso",                                       :default => false, :null => false
    t.integer  "position",                                    :default => 0,     :null => false
    t.text     "notes"
    t.boolean  "publish",                                     :default => true,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",                                :default => 0,     :null => false
    t.decimal  "width",        :precision => 10, :scale => 1, :default => 0.0,   :null => false
    t.decimal  "height",       :precision => 10, :scale => 1, :default => 0.0,   :null => false
    t.decimal  "depth",        :precision => 10, :scale => 1, :default => 0.0,   :null => false
  end

  add_index "images", ["item_id"], :name => "index_images_on_item_id"
  add_index "images", ["position"], :name => "index_images_on_position"
  add_index "images", ["publish"], :name => "index_images_on_publish"

  create_table "item_translations", :force => true do |t|
    t.integer  "item_id",                       :null => false
    t.string   "locale",        :default => "", :null => false
    t.string   "display_date"
    t.text     "description"
    t.string   "title",         :default => "", :null => false
    t.string   "credit"
    t.string   "creator_label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "published"
    t.text     "transcript"
    t.text     "remarks"
    t.string   "owner_tag"
  end

  add_index "item_translations", ["item_id", "locale"], :name => "in_item_translations_unique", :unique => true
  add_index "item_translations", ["item_id"], :name => "index_item_translations_on_item_id"
  add_index "item_translations", ["locale"], :name => "in_item_translations_locale"
  add_index "item_translations", ["owner_tag"], :name => "in_item_translations_owner_tag"
  add_index "item_translations", ["title"], :name => "title"

  create_table "items", :force => true do |t|
    t.string   "accession_num",                                   :default => "",    :null => false
    t.string   "urn"
    t.integer  "owner_id"
    t.integer  "collection_id"
    t.integer  "pages",                                           :default => 1,     :null => false
    t.integer  "format_id"
    t.boolean  "circa",                                           :default => false, :null => false
    t.text     "notes"
    t.boolean  "bound",                                           :default => false, :null => false
    t.boolean  "publish",                                         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_date"
    t.integer  "calendar_type_id"
    t.boolean  "favorite",                                        :default => false, :null => false
    t.decimal  "width",            :precision => 10, :scale => 1, :default => 0.0,   :null => false
    t.decimal  "height",           :precision => 10, :scale => 1, :default => 0.0,   :null => false
    t.decimal  "depth",            :precision => 10, :scale => 1, :default => 0.0,   :null => false
    t.integer  "lock_version",                                    :default => 0,     :null => false
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.boolean  "editorial_dating",                                :default => false
    t.integer  "era_id"
    t.integer  "sort_year"
    t.integer  "sort_month"
    t.integer  "sort_day"
    t.boolean  "editorial_date",                                  :default => false, :null => false
  end

  add_index "items", ["accession_num"], :name => "accession_num", :unique => true
  add_index "items", ["calendar_type_id"], :name => "calendar_type_id"
  add_index "items", ["collection_id"], :name => "collection_id"
  add_index "items", ["editorial_dating"], :name => "index_items_on_editorial_dating"
  add_index "items", ["favorite"], :name => "index_items_on_favorite"
  add_index "items", ["owner_id"], :name => "owner_id"
  add_index "items", ["publish"], :name => "publish"
  add_index "items", ["sort_year", "sort_month", "sort_day"], :name => "index_items_on_sort_year_and_sort_month_and_sort_day"
  add_index "items", ["year", "month", "day"], :name => "index_items_on_year_and_month_and_day"

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

  create_table "month_translations", :force => true do |t|
    t.integer  "month_id",   :default => 0,    :null => false
    t.string   "locale",     :default => "en", :null => false
    t.string   "name",       :default => "",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "month_translations", ["month_id"], :name => "index_month_translations_on_month_id"
  add_index "month_translations", ["name"], :name => "index_month_translations_on_name"

  create_table "months", :force => true do |t|
    t.integer  "calendar_type_id",                   :null => false
    t.integer  "position",         :default => 1,    :null => false
    t.boolean  "publish",          :default => true, :null => false
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "months", ["calendar_type_id"], :name => "index_months_on_calendar_type_id"
  add_index "months", ["position"], :name => "index_months_on_position"
  add_index "months", ["publish"], :name => "index_months_on_publish"

  create_table "owner_translations", :force => true do |t|
    t.integer  "owner_id",     :default => 0,    :null => false
    t.string   "locale",       :default => "en", :null => false
    t.string   "name",         :default => "",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "credit"
    t.text     "restrictions"
  end

  add_index "owner_translations", ["locale"], :name => "in_owner_translations_locale"
  add_index "owner_translations", ["name"], :name => "in_owner_translations_name"
  add_index "owner_translations", ["owner_id", "locale"], :name => "in_owner_translations_unique"
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
    t.integer  "lock_version",   :default => 0,     :null => false
    t.boolean  "private",        :default => false, :null => false
    t.string   "city"
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
    t.integer  "lock_version", :default => 0, :null => false
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
    t.integer  "lock_version",  :default => 0,    :null => false
  end

  add_index "panels", ["exhibition_id"], :name => "index_panels_on_exhibition_id"
  add_index "panels", ["item_id"], :name => "index_panels_on_item_id"
  add_index "panels", ["position"], :name => "index_panels_on_position"
  add_index "panels", ["publish"], :name => "index_panels_on_publish"

  create_table "passports", :force => true do |t|
    t.string   "tag"
    t.integer  "repository_id"
    t.integer  "item_id"
    t.boolean  "publish"
    t.boolean  "primary"
    t.integer  "position"
    t.text     "notes"
    t.string   "custom_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",  :default => 0, :null => false
  end

  add_index "passports", ["item_id"], :name => "fk_passports_items"
  add_index "passports", ["position"], :name => "index_passports_on_position"
  add_index "passports", ["primary"], :name => "index_passports_on_primary"
  add_index "passports", ["publish"], :name => "index_passports_on_publish"
  add_index "passports", ["repository_id"], :name => "fk_passports_repositories"
  add_index "passports", ["tag"], :name => "index_passports_on_tag"

  create_table "people", :force => true do |t|
    t.string   "loc_name"
    t.boolean  "major",        :default => false, :null => false
    t.integer  "dob"
    t.integer  "dod"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.boolean  "publish",      :default => true,  :null => false
    t.integer  "lock_version", :default => 0,     :null => false
  end

  add_index "people", ["major"], :name => "in_people_on_major"
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
    t.integer  "lock_version", :default => 0,     :null => false
    t.boolean  "major",        :default => false
  end

  add_index "periods", ["end_at"], :name => "index_periods_end_at"
  add_index "periods", ["major"], :name => "index_periods_on_major"
  add_index "periods", ["position"], :name => "index_periods_on_position"
  add_index "periods", ["publish"], :name => "index_periods_on_publish"
  add_index "periods", ["start_at"], :name => "index_periods_start_at"

  create_table "person_translations", :force => true do |t|
    t.integer  "person_id",   :default => 0,    :null => false
    t.string   "locale",      :default => "en", :null => false
    t.text     "description"
    t.string   "sort_name",   :default => "",   :null => false
    t.string   "vitals"
    t.string   "name",        :default => "",   :null => false
    t.string   "birth_place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_translations", ["locale"], :name => "in_person_translations_locale"
  add_index "person_translations", ["name"], :name => "in_person_translations_name"
  add_index "person_translations", ["person_id", "locale"], :name => "in_person_translations_unique", :unique => true
  add_index "person_translations", ["person_id"], :name => "index_person_translations_on_person_id"
  add_index "person_translations", ["sort_name"], :name => "in_person_translations_sort_name"

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
    t.integer  "lock_version", :default => 0,     :null => false
    t.boolean  "major",        :default => false
  end

  add_index "places", ["major"], :name => "index_places_on_major"
  add_index "places", ["publish"], :name => "index_places_on_publish"

  create_table "plot_translations", :force => true do |t|
    t.integer  "plot_id",    :default => 0,    :null => false
    t.string   "locale",     :default => "en", :null => false
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plot_translations", ["caption"], :name => "index_plot_translations_on_caption"
  add_index "plot_translations", ["locale", "plot_id"], :name => "index_plot_translations_on_locale_and_plot_id", :unique => true
  add_index "plot_translations", ["locale"], :name => "index_plot_translations_on_locale"
  add_index "plot_translations", ["plot_id"], :name => "index_plot_translations_on_plot_id"

  create_table "plots", :force => true do |t|
    t.integer  "item_id",    :default => 0,    :null => false
    t.integer  "place_id",   :default => 0,    :null => false
    t.text     "notes"
    t.boolean  "publish",    :default => true, :null => false
    t.integer  "position",   :default => 1,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plots", ["item_id", "place_id"], :name => "index_plots_places_unique", :unique => true
  add_index "plots", ["item_id"], :name => "fk_plots_items"
  add_index "plots", ["place_id"], :name => "fk_plots_places"
  add_index "plots", ["position"], :name => "index_plots_on_position"
  add_index "plots", ["publish"], :name => "index_plots_on_publish"

  create_table "relationship_translations", :force => true do |t|
    t.integer  "relationship_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationship_translations", ["relationship_id"], :name => "index_fa4a91c2469692f691e7cf7811ef182d444c29b7"

  create_table "relationships", :force => true do |t|
    t.integer  "position"
    t.boolean  "publish"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "relative_id"
    t.integer  "lock_version", :default => 0, :null => false
  end

  create_table "repositories", :force => true do |t|
    t.integer  "owner_id",                       :null => false
    t.string   "url",                            :null => false
    t.boolean  "publish",      :default => true, :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0,    :null => false
  end

  add_index "repositories", ["owner_id"], :name => "fk_repositories_owners"
  add_index "repositories", ["publish"], :name => "index_repositories_on_publish"

  create_table "repository_translations", :force => true do |t|
    t.integer  "repository_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repository_translations", ["name"], :name => "index_repository_translations_on_name"
  add_index "repository_translations", ["repository_id"], :name => "index_repository_translations_on_repository_id"

  create_table "section_translations", :force => true do |t|
    t.integer  "section_id"
    t.string   "locale"
    t.string   "title"
    t.text     "caption"
    t.string   "start_page_label"
    t.string   "end_page_label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "section_translations", ["section_id"], :name => "index_section_translations_on_section_id"
  add_index "section_translations", ["title"], :name => "index_section_translations_on_title"

  create_table "sections", :force => true do |t|
    t.integer  "item_id",                      :null => false
    t.integer  "start_page",                   :null => false
    t.integer  "end_page",                     :null => false
    t.integer  "parent_id"
    t.boolean  "publish",    :default => true, :null => false
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["end_page"], :name => "index_sections_on_end_page"
  add_index "sections", ["item_id"], :name => "fk_sections_items"
  add_index "sections", ["parent_id"], :name => "index_sections_on_parent_id"
  add_index "sections", ["publish"], :name => "index_sections_on_publish"
  add_index "sections", ["start_page"], :name => "index_sections_on_start_page"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "subject_translations", :force => true do |t|
    t.integer  "subject_id", :default => 0,    :null => false
    t.string   "locale",     :default => "en", :null => false
    t.string   "name",       :default => "",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subject_translations", ["locale"], :name => "in_subject_translations_locale"
  add_index "subject_translations", ["name"], :name => "index_subject_translations_on_name"
  add_index "subject_translations", ["subject_id"], :name => "index_subject_translations_on_subject_id"

  create_table "subject_type_translations", :force => true do |t|
    t.integer  "subject_type_id", :default => 0,    :null => false
    t.string   "locale",          :default => "en", :null => false
    t.string   "name",            :default => "",   :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subject_type_translations", ["locale"], :name => "in_subject_type_translations_locale"
  add_index "subject_type_translations", ["name"], :name => "index_subject_type_translations_on_name"
  add_index "subject_type_translations", ["subject_type_id"], :name => "index_40e3198922c547fbecf36d5442b606191b8975c3"

  create_table "subject_types", :force => true do |t|
    t.boolean  "publish",      :default => true, :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", :default => 0,    :null => false
  end

  add_index "subject_types", ["publish"], :name => "index_subject_types_on_publish"

  create_table "subjects", :force => true do |t|
    t.boolean  "major",           :default => false, :null => false
    t.boolean  "publish",         :default => true,  :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_type_id", :default => 7,     :null => false
    t.integer  "lock_version",    :default => 0,     :null => false
  end

  add_index "subjects", ["major"], :name => "index_subjects_on_major"
  add_index "subjects", ["publish"], :name => "index_subjects_on_publish"
  add_index "subjects", ["subject_type_id"], :name => "subject_type_id_2"

  create_table "translations", :force => true do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version",   :default => 0,     :null => false
  end

  add_index "translations", ["key"], :name => "index_translations_on_key"
  add_index "translations", ["locale", "key"], :name => "index_translations_on_locale_key", :unique => true
  add_index "translations", ["locale"], :name => "index_translations_on_locale"

end
