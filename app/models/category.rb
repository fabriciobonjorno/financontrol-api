# frozen_string_literal: true

class Category < ApplicationRecord
  # Validates
  validates :name, :icon, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[user_id deleted_at] }, if: -> { will_save_change_to_name? }

  # Scopes
  scope :all_categories, -> { where(deleted_at: nil) }

  # Normalizes
  normalizes :name, with: -> { _1.strip }

  # Relationship
  belongs_to :user
  has_many :transactions
end
