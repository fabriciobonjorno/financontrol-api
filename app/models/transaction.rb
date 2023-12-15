# frozen_string_literal: true

class Transaction < ApplicationRecord
  # Relationship
  belongs_to :bank_account
  belongs_to :category
  belongs_to :user

  # Enum
  enum types: %i[income expense]
end
