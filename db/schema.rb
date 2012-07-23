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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120723180552) do

  create_table "books", :force => true do |t|
    t.string   "isbn",        :default => "", :null => false
    t.string   "title",       :default => "", :null => false
    t.string   "image",       :default => "", :null => false
    t.string   "place",       :default => "", :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "authors",     :default => "", :null => false
    t.string   "publisher",   :default => "", :null => false
    t.datetime "published"
    t.text     "description"
    t.string   "google",      :default => "", :null => false
  end

  add_index "books", ["title"], :name => "index_books_on_title"
  add_index "books", ["updated_at"], :name => "index_books_on_updated_at"

  create_table "entities", :force => true do |t|
    t.string   "memo",       :default => "", :null => false
    t.integer  "book_id",                    :null => false
    t.integer  "place_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "entities", ["book_id"], :name => "index_entities_on_book_id"
  add_index "entities", ["place_id"], :name => "index_entities_on_place_id"

  create_table "places", :force => true do |t|
    t.string  "name",                          :null => false
    t.integer "entities_count", :default => 0, :null => false
  end

  add_index "places", ["name"], :name => "index_places_on_name", :unique => true

  create_table "relevants", :force => true do |t|
    t.string   "what",       :default => "link", :null => false
    t.string   "url",                            :null => false
    t.integer  "book_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "relevants", ["book_id"], :name => "index_relevants_on_book_id"

end
