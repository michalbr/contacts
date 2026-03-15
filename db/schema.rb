# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_01_26_081801) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "note"
    t.datetime "updated_at", null: false
  end

  create_table "contacts_labels", id: false, force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.bigint "label_id", null: false
    t.index ["contact_id", "label_id"], name: "index_contacts_labels_on_contact_id_and_label_id", unique: true
    t.index ["label_id", "contact_id"], name: "index_contacts_labels_on_label_id_and_contact_id"
  end

  create_table "labels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_labels_on_lower_name", unique: true
  end

  add_foreign_key "contacts_labels", "contacts"
  add_foreign_key "contacts_labels", "labels"
end
