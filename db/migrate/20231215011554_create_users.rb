# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    return if table_exists? 'users'

    create_table :users, id: :uuid do |t|
      t.string :name, default: '', null: false
      t.string :password_digest, default: '', null: false
      t.string :email, default: '', null: false
      t.date :birth_date
      t.boolean :confirmed, default: false
      t.boolean :locked, default: false
      t.integer :login_attempts, default: 0
      t.string :confirmation_token
      t.string :password_reset_token
      t.datetime :locked_at
      t.datetime :password_reset_sent_at
      t.datetime :confirmation_token_sent_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :users, :name
    add_index :users, :password_digest
    add_index :users, :email, unique: true
    add_index :users, :birth_date
    add_index :users, :confirmed
    add_index :users, :locked
    add_index :users, :login_attempts
    add_index :users, :confirmation_token, unique: true
    add_index :users, :password_reset_token, unique: true
    add_index :users, :locked_at
    add_index :users, :password_reset_sent_at
    add_index :users, :confirmation_token_sent_at
    add_index :users, :deleted_at
  end
end
