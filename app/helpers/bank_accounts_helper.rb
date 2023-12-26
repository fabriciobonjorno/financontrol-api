# frozen_string_literal: true

module BankAccountsHelper
  def self.map_bank_accounts_types
    [
      { title: I18n.t('bank_accounts.types.checking'), id: 'checking' },
      { title: I18n.t('bank_accounts.types.saving'), id: 'saving' },
      { title: I18n.t('bank_accounts.types.investment'), id: 'investment' },
      { title: I18n.t('bank_accounts.types.cash'), id: 'cash' }
    ].freeze
  end
end
