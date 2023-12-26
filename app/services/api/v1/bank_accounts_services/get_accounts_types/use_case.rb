# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module GetAccountsTypes
        class UseCase < MainService
          step :accounts_types

          def accounts_types
            if BankAccountsHelper.map_bank_accounts_types.present?
              Success(BankAccountsHelper.map_bank_accounts_types)
            else
              Failure(I18n.t('bank_accounts.errors.type_not_found'))
            end
          end
        end
      end
    end
  end
end
