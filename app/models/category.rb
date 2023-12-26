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
    update_total_transactions
  end

  # Private methods
  private

  def capitalize_name
    self.name = Util.capitalize_name(name) if name_changed?
  end

  def update_total_transactions
    return unless saved_change_to_deleted_at?

    transactions.each do |transaction|
      next unless transaction.bank_account.present?

      incomes = transaction.income? ? transaction.amount : 0
      expenses = transaction.expense? ? transaction.amount : 0
      total_difference = incomes - expenses
      transaction.bank_account.total_transactions -= total_difference
      transaction.bank_account.save
    end
  end
end
