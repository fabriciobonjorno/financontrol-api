# frozen_string_literal: true

class Category < ApplicationRecord
  # Callbacks
  before_save :capitalize_name

  # Validates
  validates :name, :icon, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[user_id deleted_at] }, if: -> { will_save_change_to_name? }

  # Scopes
  scope :all_categories, -> { where(deleted_at: nil) }

  # Normalizes
  normalizes :name, with: -> { _1.strip }

  # Relationship
  belongs_to :user
  has_many :transactions, dependent: :destroy
  has_many :bank_accounts, through: :transactions, dependent: :destroy

  # Public methods
  def soft_delete
    update(deleted_at: Time.now)
    transactions.update_all(deleted_at: Time.now)
  end

  # Private methods
  private

  def capitalize_name
    self.name = Util.capitalize_name(name) if name_changed?
  end
end
