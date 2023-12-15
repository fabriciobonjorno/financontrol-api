# frozen_string_literal: true

class BankAccount < ApplicationRecord
  # Relationship
  belongs_to :user
  has_many :transactions

  # Enum
  enum types: %i[checking saving investiment cash]
end
