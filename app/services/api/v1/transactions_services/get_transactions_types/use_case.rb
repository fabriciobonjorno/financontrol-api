# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module GetTransactionsTypes
        class UseCase < MainService
          step :transactions_types

          def transactions_types
            if TransactionsHelper.map_transactions_types.present?
              Success(TransactionsHelper.map_transactions_types)
            else
              Failure(I18n.t('transactions.errors.type_not_found'))
            end
          end
        end
      end
    end
  end
end
