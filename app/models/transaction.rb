# frozen_string_literal: true

class Transaction < ApplicationRecord
  before_save :update_total_transactions

  # Validates
  validates :name, :amount, :transaction_date, :transaction_type, presence: true
  validates :amount, numericality: { greater_than: 0 }

  # Scopes
  scope :all_transactions, -> { where(deleted_at: nil) }
  scope :incomes, -> { all_transactions.where(transaction_type: 'income') }
  scope :expenses, -> { all_transactions.where(transaction_type: 'expense') }

  # Relationship
  belongs_to :bank_account
  belongs_to :category
  belongs_to :user

  # Enum
  enum transaction_type: %i[income expense]

  # Public methods
  def income?
    transaction_type == 'income'
  end

  def expense?
    transaction_type == 'expense'
  end

  # Private methods
  private

  def update_total_transactions
    adjustment = income? ? amount : -amount
    bank_account.total_transactions += adjustment
    bank_account.save
  end
end
