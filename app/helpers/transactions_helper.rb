# frozen_string_literal: true

module TransactionsHelper
  def self.map_transactions_types
    [
      { title: I18n.t('transactions.types.income'), id: 'income' },
      { title: I18n.t('transactions.types.expense'), id: 'expense' }
    ].freeze
  end
end
