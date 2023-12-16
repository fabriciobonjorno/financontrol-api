# frozen_string_literal: true

class Category < ApplicationRecord
  # Validates
  validates :name, :icon, presence: true
  validates :name, uniqueness: { case_sensitive: false }, if: -> { category_exists? }

  # Normalizes
  normalizes :name, with: -> { _1.strip }

  # Relationship
  belongs_to :user
  has_many :transactions

  # Public methods
  def category_exists?
    user = User.find_by(id: user_id)
    return false if user.nil?

    category_name = Util.capitalize_name(name)
    user.categories.exists?(name: category_name)
  end
end
