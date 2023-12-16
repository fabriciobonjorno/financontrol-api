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

ActiveRecord::Schema[7.1].define(version: 20_231_215_014_812) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'bank_accounts', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.decimal 'initial_balance', precision: 10, scale: 2, default: '0.0'
    t.integer 'type', default: 0
    t.string 'color'
    t.datetime 'deleted_at'
    t.uuid 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['color'], name: 'index_bank_accounts_on_color'
    t.index ['deleted_at'], name: 'index_bank_accounts_on_deleted_at'
    t.index ['initial_balance'], name: 'index_bank_accounts_on_initial_balance'
    t.index ['name'], name: 'index_bank_accounts_on_name'
    t.index ['type'], name: 'index_bank_accounts_on_type'
    t.index ['user_id'], name: 'index_bank_accounts_on_user_id'
  end

  create_table 'categories', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.string 'icon', default: '', null: false
    t.datetime 'deleted_at'
    t.uuid 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['deleted_at'], name: 'index_categories_on_deleted_at'
    t.index ['icon'], name: 'index_categories_on_icon'
    t.index ['name'], name: 'index_categories_on_name'
    t.index ['user_id'], name: 'index_categories_on_user_id'
  end

  create_table 'transactions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.decimal 'amount', precision: 10, scale: 2, default: '0.0'
    t.date 'date'
    t.integer 'type', default: 0
    t.datetime 'deleted_at'
    t.uuid 'bank_account_id', null: false
    t.uuid 'category_id', null: false
    t.uuid 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['amount'], name: 'index_transactions_on_amount'
    t.index ['bank_account_id'], name: 'index_transactions_on_bank_account_id'
    t.index ['category_id'], name: 'index_transactions_on_category_id'
    t.index ['date'], name: 'index_transactions_on_date'
    t.index ['deleted_at'], name: 'index_transactions_on_deleted_at'
    t.index ['name'], name: 'index_transactions_on_name'
    t.index ['type'], name: 'index_transactions_on_type'
    t.index ['user_id'], name: 'index_transactions_on_user_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.string 'password_digest', default: '', null: false
    t.string 'email', default: '', null: false
    t.date 'birth_date'
    t.boolean 'confirmed', default: false
    t.boolean 'locked', default: false
    t.integer 'login_attempts', default: 0
    t.string 'confirmation_token'
    t.string 'password_reset_token'
    t.datetime 'locked_at'
    t.datetime 'password_reset_sent_at'
    t.datetime 'confirmation_token_sent_at'
    t.datetime 'deleted_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['birth_date'], name: 'index_users_on_birth_date'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['confirmation_token_sent_at'], name: 'index_users_on_confirmation_token_sent_at'
    t.index ['confirmed'], name: 'index_users_on_confirmed'
    t.index ['deleted_at'], name: 'index_users_on_deleted_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['locked'], name: 'index_users_on_locked'
    t.index ['locked_at'], name: 'index_users_on_locked_at'
    t.index ['login_attempts'], name: 'index_users_on_login_attempts'
    t.index ['name'], name: 'index_users_on_name'
    t.index ['password_digest'], name: 'index_users_on_password_digest'
    t.index ['password_reset_sent_at'], name: 'index_users_on_password_reset_sent_at'
    t.index ['password_reset_token'], name: 'index_users_on_password_reset_token', unique: true
  end

  add_foreign_key 'bank_accounts', 'users'
  add_foreign_key 'categories', 'users'
  add_foreign_key 'transactions', 'bank_accounts'
  add_foreign_key 'transactions', 'categories'
  add_foreign_key 'transactions', 'users'
end
