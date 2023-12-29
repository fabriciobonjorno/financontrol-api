# frozen_string_literal: true

class Transaction < ApplicationRecord
  # Validates
  validates :name, :amount, :transaction_date, :transaction_type, presence: true
  validates :amount, numericality: { greater_than: 0 }

  # Scopes
  scope :all_transactions, -> { where(deleted_at: nil) }
  scope :incomes, -> { all_transactions.where(transaction_type: 'income').sum(:amount) }
  scope :expenses, -> { all_transactions.where(transaction_type: 'expense').sum(:amount) }
  scope :incomes_by_category, -> { all_transactions.where(transaction_type: 'income').group(:category).sum(:amount) }
  scope :expenses_by_category, -> { all_transactions.where(transaction_type: 'expense').group(:category).sum(:amount) }

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

  def soft_delete
    update(deleted_at: Time.now)
  end

  # Private methods
  def capitalize_name
    self.name = Util.capitalize_name(name) if name_changed?
  end
end
