# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    return if table_exists? 'transactions'

    create_table :transactions, id: :uuid do |t|
      t.string :name, default: '', null: false
      t.decimal :amount, precision: 10, scale: 2, default: 0
      t.date :transaction_date
      t.integer :transaction_type, default: 0
      t.datetime :deleted_at
      t.references :bank_account, null: false, foreign_key: true, type: :uuid
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :transactions, :name
    add_index :transactions, :amount
    add_index :transactions, :transaction_date
    add_index :transactions, :transaction_type
    add_index :transactions, :deleted_at
  end
end
