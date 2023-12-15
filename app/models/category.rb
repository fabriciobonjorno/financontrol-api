# frozen_string_literal: true

class Category < ApplicationRecord
  # Relationship
  belongs_to :user
  has_many :transactions
end
