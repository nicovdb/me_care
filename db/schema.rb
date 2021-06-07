# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_17_145627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "alternative_therapies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "displayed", default: false
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_answers_on_subject_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.text "content"
    t.integer "media_type"
    t.integer "category"
    t.string "reading_time"
    t.string "cover_credit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "author"
    t.boolean "published", default: false
    t.datetime "publication_date"
    t.string "tags"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "coupon_codes", force: :cascade do |t|
    t.string "code"
    t.boolean "used", default: false
    t.integer "free_months"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "daily_symptoms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "day"
    t.integer "pain_level", default: 0
    t.integer "blood_level", default: 0
    t.integer "digestive_trouble_level", default: 0
    t.integer "stress_level", default: 0
    t.integer "insomnia_level", default: 0
    t.boolean "sport", default: false
    t.boolean "emergency", default: false
    t.boolean "analgesic", default: false
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_daily_symptoms_on_user_id"
  end

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "displayed", default: false
  end

  create_table "fam_member_antes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "article_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "infoendo_id"
    t.index ["article_id"], name: "index_favorites_on_article_id"
    t.index ["infoendo_id"], name: "index_favorites_on_infoendo_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "follow_subjects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subject_id", null: false
    t.boolean "seen", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_follow_subjects_on_subject_id"
    t.index ["user_id"], name: "index_follow_subjects_on_user_id"
  end

  create_table "forum_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "info_alternative_therapies", force: :cascade do |t|
    t.bigint "information_id", null: false
    t.bigint "alternative_therapy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["alternative_therapy_id"], name: "index_info_alternative_therapies_on_alternative_therapy_id"
    t.index ["information_id"], name: "index_info_alternative_therapies_on_information_id"
  end

  create_table "info_diseases", force: :cascade do |t|
    t.bigint "information_id", null: false
    t.bigint "disease_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["disease_id"], name: "index_info_diseases_on_disease_id"
    t.index ["information_id"], name: "index_info_diseases_on_information_id"
  end

  create_table "info_fam_member_antes", force: :cascade do |t|
    t.bigint "information_id", null: false
    t.bigint "fam_member_ante_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fam_member_ante_id"], name: "index_info_fam_member_antes_on_fam_member_ante_id"
    t.index ["information_id"], name: "index_info_fam_member_antes_on_information_id"
  end

  create_table "infoendos", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.integer "category"
    t.string "reading_time"
    t.text "content"
    t.integer "media_type"
    t.string "cover_credit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "published", default: false
    t.datetime "publication_date"
    t.string "video"
    t.index ["user_id"], name: "index_infoendos_on_user_id"
  end

  create_table "information", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date_of_birth"
    t.integer "family_situation"
    t.string "job"
    t.integer "diagnosis_age"
    t.integer "size"
    t.float "weight"
    t.float "imc"
    t.boolean "family_antecedent"
    t.integer "family_antecedent_origin"
    t.boolean "children"
    t.integer "children_number"
    t.boolean "abortion"
    t.integer "abortion_number"
    t.boolean "pma"
    t.boolean "endo_surgery"
    t.integer "endo_surgery_number"
    t.boolean "pain_center"
    t.boolean "physiotherapist"
    t.boolean "ostheopath"
    t.boolean "terms_conditions"
    t.boolean "auto_immune_antecedent"
    t.boolean "alternative_therapy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "miscarriage"
    t.integer "miscarriage_number"
    t.string "other_alternative_therapy"
    t.string "other_disease"
    t.index ["user_id"], name: "index_information_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "forum_category_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["forum_category_id"], name: "index_subjects_on_forum_category_id"
    t.index ["user_id"], name: "index_subjects_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_date"
    t.string "stripe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "end_date"
    t.integer "status", default: 0
    t.string "nickname"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_id"
    t.boolean "admin", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "pseudo"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean "forum_consent", default: false
    t.boolean "superadmin", default: false
    t.index "lower((email)::text) text_pattern_ops", name: "users_email_lower", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "webinar_subscriptions", force: :cascade do |t|
    t.bigint "webinar_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state"
    t.integer "amount_cents", default: 0, null: false
    t.string "checkout_session_id"
    t.index ["user_id"], name: "index_webinar_subscriptions_on_user_id"
    t.index ["webinar_id"], name: "index_webinar_subscriptions_on_webinar_id"
  end

  create_table "webinars", force: :cascade do |t|
    t.string "speaker_name"
    t.string "title"
    t.datetime "start_at"
    t.text "description"
    t.integer "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price_cents", default: 500, null: false
    t.boolean "published", default: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "subjects"
  add_foreign_key "answers", "users"
  add_foreign_key "articles", "users"
  add_foreign_key "daily_symptoms", "users"
  add_foreign_key "favorites", "articles"
  add_foreign_key "favorites", "infoendos"
  add_foreign_key "favorites", "users"
  add_foreign_key "follow_subjects", "subjects"
  add_foreign_key "follow_subjects", "users"
  add_foreign_key "info_alternative_therapies", "alternative_therapies"
  add_foreign_key "info_alternative_therapies", "information"
  add_foreign_key "info_diseases", "diseases"
  add_foreign_key "info_diseases", "information"
  add_foreign_key "info_fam_member_antes", "fam_member_antes"
  add_foreign_key "info_fam_member_antes", "information"
  add_foreign_key "infoendos", "users"
  add_foreign_key "information", "users"
  add_foreign_key "subjects", "forum_categories"
  add_foreign_key "subjects", "users"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "webinar_subscriptions", "users"
  add_foreign_key "webinar_subscriptions", "webinars"
end
