# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  # Relationship
  has_many :bank_accounts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy
end
