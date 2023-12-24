# frozen_string_literal: true

class CreateBankAccounts < ActiveRecord::Migration[7.1]
  def change
    return if table_exists? 'bank_accounts'

    create_table :bank_accounts, id: :uuid do |t|
      t.string :name, default: '', null: false
      t.decimal :initial_balance, precision: 10, scale: 2, default: 0
      t.decimal :total_transactions, precision: 10, scale: 2, default: 0
      t.integer :account_type, default: 0
      t.string :color
      t.datetime :deleted_at
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :bank_accounts, :name
    add_index :bank_accounts, :account_type
    add_index :bank_accounts, :initial_balance
    add_index :bank_accounts, :total_transactions
    add_index :bank_accounts, :color
    add_index :bank_accounts, :deleted_at
  end
end
