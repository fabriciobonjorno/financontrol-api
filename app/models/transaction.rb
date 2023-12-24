# frozen_string_literal: true

class Transaction < ApplicationRecord
  # Validates
  validates :name, :amount, :transaction_date, :transaction_type, presence: true
  validates :amount, numericality: { greater_than: 0 }

  # Relationship
  belongs_to :bank_account
  belongs_to :category
  belongs_to :user

  # Enum
  enum transaction_type: %i[income expense]
end
