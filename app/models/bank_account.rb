# frozen_string_literal: true

class BankAccount < ApplicationRecord
  # Relationship
  belongs_to :user
  has_many :transactions
end