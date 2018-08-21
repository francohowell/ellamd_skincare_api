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

ActiveRecord::Schema.define(version: 20180410064223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "action_tokens", id: :serial, force: :cascade do |t|
    t.string "token"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "tokenable_type"
    t.integer "tokenable_id"
    t.datetime "used_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_action_tokens_on_owner_type_and_owner_id"
    t.index ["token"], name: "index_action_tokens_on_token"
    t.index ["tokenable_type", "tokenable_id"], name: "index_action_tokens_on_tokenable_type_and_tokenable_id"
  end

  create_table "administrators", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "annotations", id: :serial, force: :cascade do |t|
    t.integer "photo_id"
    t.integer "physician_id"
    t.float "position_x", null: false
    t.float "position_y", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_annotations_on_photo_id"
    t.index ["physician_id"], name: "index_annotations_on_physician_id"
  end

  create_table "audits", id: :serial, force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "conditions", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.integer "physician_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "zip_code"
    t.string "state"
    t.string "city"
    t.string "phone"
    t.datetime "archived_at"
    t.integer "last_onboarding_step", default: 1, null: false
    t.datetime "onboarding_completed_at"
    t.index ["physician_id"], name: "index_customers_on_physician_id"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "diagnoses", id: :serial, force: :cascade do |t|
    t.integer "physician_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visit_id"
    t.index ["physician_id"], name: "index_diagnoses_on_physician_id"
    t.index ["visit_id"], name: "index_diagnoses_on_visit_id"
  end

  create_table "diagnosis_conditions", id: :serial, force: :cascade do |t|
    t.integer "diagnosis_id"
    t.integer "condition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["condition_id"], name: "index_diagnosis_conditions_on_condition_id"
    t.index ["diagnosis_id"], name: "index_diagnosis_conditions_on_diagnosis_id"
  end

  create_table "emailings", id: :serial, force: :cascade do |t|
    t.integer "identity_id"
    t.string "template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_emailings_on_identity_id"
  end

  create_table "formulation_ingredients", id: :serial, force: :cascade do |t|
    t.integer "formulation_id"
    t.integer "ingredient_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formulation_id"], name: "index_formulation_ingredients_on_formulation_id"
    t.index ["ingredient_id"], name: "index_formulation_ingredients_on_ingredient_id"
  end

  create_table "formulations", id: :serial, force: :cascade do |t|
    t.integer "number"
    t.text "main_tag"
    t.string "cream_base"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", id: :serial, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type"
    t.integer "user_id"
    t.index ["confirmation_token"], name: "index_identities_on_confirmation_token", unique: true
    t.index ["email"], name: "index_identities_on_email", unique: true
    t.index ["reset_password_token"], name: "index_identities_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_identities_on_uid_and_provider", unique: true
    t.index ["user_type", "user_id"], name: "index_identities_on_user_type_and_user_id"
  end

  create_table "ingredients", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.float "minimum_amount", null: false
    t.float "maximum_amount", null: false
    t.string "unit", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "classes", default: [], null: false, array: true
    t.boolean "is_premium", default: false, null: false
    t.boolean "is_prescription_required", default: false, null: false
  end

  create_table "medical_profiles", id: :serial, force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "sex"
    t.datetime "date_of_birth"
    t.text "is_smoker"
    t.text "is_pregnant"
    t.text "is_breast_feeding"
    t.text "is_on_birth_control"
    t.text "known_allergies"
    t.text "current_prescription_oral_medications"
    t.text "current_prescription_topical_medications"
    t.text "current_nonprescription_topical_medications"
    t.text "past_prescription_oral_medications"
    t.text "past_prescription_topical_medications"
    t.text "past_nonprescription_topical_medications"
    t.text "using_peels"
    t.text "using_retinol"
    t.text "has_been_on_accutane"
    t.text "has_hormonal_issues"
    t.text "other_concerns"
    t.integer "preferred_fragrance"
    t.integer "skin_type"
    t.jsonb "skin_concerns"
    t.integer "sunscreen_frequency"
    t.string "sunscreen_brand"
    t.string "user_skin_extra_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_medical_profiles_on_customer_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "physician_id", null: false
    t.boolean "from_customer", default: true, null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_messages_on_customer_id"
    t.index ["physician_id"], name: "index_messages_on_physician_id"
  end

  create_table "pharmacists", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photo_conditions", force: :cascade do |t|
    t.bigint "photo_id"
    t.bigint "condition_id"
    t.text "note"
    t.text "canvas_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["condition_id"], name: "index_photo_conditions_on_condition_id"
    t.index ["photo_id"], name: "index_photo_conditions_on_photo_id"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visit_id"
    t.index ["customer_id"], name: "index_photos_on_customer_id"
    t.index ["visit_id"], name: "index_photos_on_visit_id"
  end

  create_table "physicians", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "signature_image_file_name"
    t.string "signature_image_content_type"
    t.integer "signature_image_file_size"
    t.datetime "signature_image_updated_at"
    t.string "state_license"
    t.string "dea_license"
    t.text "address"
    t.string "phone"
  end

  create_table "prescription_ingredients", id: :serial, force: :cascade do |t|
    t.integer "prescription_id"
    t.integer "ingredient_id"
    t.float "amount", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_prescription_ingredients_on_ingredient_id"
    t.index ["prescription_id"], name: "index_prescription_ingredients_on_prescription_id"
  end

  create_table "prescriptions", id: :serial, force: :cascade do |t|
    t.integer "physician_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.text "signa", default: "", null: false
    t.text "customer_instructions", default: "", null: false
    t.text "pharmacist_instructions", default: "", null: false
    t.text "tracking_number"
    t.string "fragrance"
    t.string "cream_base"
    t.integer "volume_in_ml", default: 15, null: false
    t.integer "formulation_id"
    t.datetime "fulfilled_at"
    t.integer "visit_id"
    t.datetime "not_downloaded_alerted_at"
    t.datetime "no_tracking_alerted_at"
    t.boolean "is_copy", default: false, null: false
    t.index ["formulation_id"], name: "index_prescriptions_on_formulation_id"
    t.index ["physician_id"], name: "index_prescriptions_on_physician_id"
    t.index ["visit_id"], name: "index_prescriptions_on_visit_id"
  end

  create_table "product_ingredients", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "origin_id"
    t.boolean "is_key", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "constraint_product_ingredients_on_name", unique: true
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "store", null: false
    t.integer "origin_id"
    t.string "image_url"
    t.string "product_url"
    t.text "description"
    t.text "diagnoses"
    t.text "instructions"
    t.jsonb "tags"
    t.jsonb "packages"
    t.float "average_rating"
    t.integer "number_of_reviews"
    t.jsonb "raw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand"
    t.string "store_id"
    t.boolean "is_pending", default: false, null: false
    t.index ["store", "store_id"], name: "index_products_on_store_and_store_id_unique", unique: true
  end

  create_table "products_product_ingredients", id: :serial, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "product_ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "product_ingredient_id"], name: "constraint_products_product_ingredients_on_both_keys", unique: true
  end

  create_table "regimen_products", id: :serial, force: :cascade do |t|
    t.integer "regimen_id", null: false
    t.integer "product_id", null: false
    t.integer "period", limit: 2, null: false
    t.integer "position", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["regimen_id"], name: "index_regimen_products_on_regimen_id"
  end

  create_table "regimens", id: :serial, force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "physician_id"
    t.integer "visit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_regimens_on_customer_id"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "customer_id", null: false
    t.string "stripe_subscription_id"
    t.datetime "next_visit_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_customer_id"
    t.boolean "initial_treatment_plan_is_free", default: false, null: false
    t.string "stripe_coupon_id"
    t.boolean "needs_treatment_plan", default: true, null: false
    t.boolean "has_payment_source", default: false, null: false
    t.datetime "next_charge_at"
    t.boolean "needs_profile_update", default: false, null: false
  end

  create_table "visits", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_status", limit: 2, default: 0, null: false
    t.string "stripe_invoice_id"
    t.index ["customer_id"], name: "index_visits_on_customer_id"
  end

  add_foreign_key "annotations", "photos"
  add_foreign_key "annotations", "physicians"
  add_foreign_key "customers", "physicians"
  add_foreign_key "diagnoses", "physicians"
  add_foreign_key "diagnoses", "visits"
  add_foreign_key "diagnosis_conditions", "conditions"
  add_foreign_key "diagnosis_conditions", "diagnoses"
  add_foreign_key "emailings", "identities"
  add_foreign_key "formulation_ingredients", "formulations"
  add_foreign_key "formulation_ingredients", "ingredients"
  add_foreign_key "medical_profiles", "customers", name: "medical_profiles_customer_id_fkey", on_delete: :cascade
  add_foreign_key "messages", "customers"
  add_foreign_key "messages", "physicians"
  add_foreign_key "photo_conditions", "conditions"
  add_foreign_key "photo_conditions", "photos"
  add_foreign_key "photos", "customers"
  add_foreign_key "photos", "visits"
  add_foreign_key "prescription_ingredients", "ingredients"
  add_foreign_key "prescription_ingredients", "prescriptions"
  add_foreign_key "prescriptions", "formulations"
  add_foreign_key "prescriptions", "physicians"
  add_foreign_key "prescriptions", "visits"
  add_foreign_key "product_ingredients", "product_ingredients", column: "origin_id", name: "product_ingredients_origin_id_fkey", on_delete: :cascade
  add_foreign_key "products", "products", column: "origin_id", name: "products_origin_id_fkey", on_delete: :cascade
  add_foreign_key "products_product_ingredients", "product_ingredients", name: "products_product_ingredients_product_ingredient_id_fkey", on_delete: :cascade
  add_foreign_key "products_product_ingredients", "products", name: "products_product_ingredients_product_id_fkey", on_delete: :cascade
  add_foreign_key "regimen_products", "products", name: "regimen_products_product_id_fkey", on_delete: :cascade
  add_foreign_key "regimen_products", "regimens", name: "regimen_products_regimen_id_fkey", on_delete: :cascade
  add_foreign_key "regimens", "customers", name: "regimens_customer_id_fkey", on_delete: :cascade
  add_foreign_key "regimens", "physicians", name: "regimens_physician_id_fkey", on_delete: :cascade
  add_foreign_key "regimens", "visits", name: "regimens_visit_id_fkey", on_delete: :cascade
  add_foreign_key "subscriptions", "customers", name: "subscriptions_customer_id_fkey", on_delete: :cascade
  add_foreign_key "visits", "customers"
end
