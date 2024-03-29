# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_714_165_209) do
  create_table 'batches', force: :cascade do |t|
    t.string 'code'
    t.date 'start_date'
    t.date 'final_date'
    t.integer 'minimum_value'
    t.integer 'minimum_difference'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'approved', default: false
    t.integer 'approved_by_id'
    t.integer 'created_by_id'
    t.integer 'winner_id'
    t.index ['approved_by_id'], name: 'index_batches_on_approved_by_id'
    t.index ['created_by_id'], name: 'index_batches_on_created_by_id'
    t.index ['winner_id'], name: 'index_batches_on_winner_id'
  end

  create_table 'bids', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'batch_id', null: false
    t.integer 'value'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['batch_id'], name: 'index_bids_on_batch_id'
    t.index ['user_id'], name: 'index_bids_on_user_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'items', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.integer 'weight'
    t.integer 'width'
    t.integer 'height'
    t.integer 'depth'
    t.integer 'category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'code'
    t.integer 'batch_id'
    t.index ['batch_id'], name: 'index_items_on_batch_id'
    t.index ['category_id'], name: 'index_items_on_category_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'cpf'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'role'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'batches', 'users', column: 'approved_by_id'
  add_foreign_key 'batches', 'users', column: 'created_by_id'
  add_foreign_key 'batches', 'users', column: 'winner_id'
  add_foreign_key 'bids', 'batches'
  add_foreign_key 'bids', 'users'
  add_foreign_key 'items', 'categories'
end
