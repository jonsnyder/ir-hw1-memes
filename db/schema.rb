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

ActiveRecord::Schema.define(:version => 20120304233147) do

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "positions", :force => true do |t|
    t.integer  "posting_id"
    t.integer  "offset"
    t.integer  "length"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "positions", ["offset"], :name => "index_positions_on_offset"
  add_index "positions", ["posting_id"], :name => "index_positions_on_posting_id"

  create_table "postings", :force => true do |t|
    t.integer  "document_id"
    t.integer  "term_id"
    t.integer  "term_freq"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "postings", ["document_id"], :name => "index_postings_on_document_id"
  add_index "postings", ["term_id"], :name => "index_postings_on_term_id"

  create_table "terms", :force => true do |t|
    t.string   "term"
    t.integer  "doc_freq"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "freq"
    t.boolean  "stopword",   :default => true
  end

  add_index "terms", ["term"], :name => "index_terms_on_term", :unique => true

end
