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

ActiveRecord::Schema.define(version: 20170222143946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "candidates", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "job_offer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "position"
    t.index ["job_offer_id"], name: "index_candidates_on_job_offer_id", using: :btree
    t.index ["user_id"], name: "index_candidates_on_user_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "website"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "company_companies", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "black_listed_company_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["black_listed_company_id"], name: "index_company_companies_on_black_listed_company_id", using: :btree
    t.index ["company_id"], name: "index_company_companies_on_company_id", using: :btree
  end

  create_table "contacted_candidates", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "job_offer_id"
    t.integer  "candidate_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["candidate_id"], name: "index_contacted_candidates_on_candidate_id", using: :btree
    t.index ["company_id"], name: "index_contacted_candidates_on_company_id", using: :btree
    t.index ["job_offer_id"], name: "index_contacted_candidates_on_job_offer_id", using: :btree
  end

  create_table "job_offers", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb    "tfidf"
    t.index ["user_id"], name: "index_job_offers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "company_admin"
    t.integer  "company_id"
    t.boolean  "admin"
    t.index ["company_id"], name: "index_users_on_company_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "candidates", "job_offers"
  add_foreign_key "candidates", "users"
  add_foreign_key "contacted_candidates", "candidates"
  add_foreign_key "contacted_candidates", "companies"
  add_foreign_key "contacted_candidates", "job_offers"
  add_foreign_key "job_offers", "users"
  add_foreign_key "users", "companies"
end
