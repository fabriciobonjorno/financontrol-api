# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Create
        class Presenter < MainService
          def call(bank_account)
            {
              id: bank_account.id,
              name: bank_account.name,
              initial_balance: bank_account.initial_balance,
              account_type: bank_account.account_type,
              color: bank_account.color,
              registered_at: Util.format_date(bank_account.created_at)
            }
          end
        end
      end
    end
  end
end
