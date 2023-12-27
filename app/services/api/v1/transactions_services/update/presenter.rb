# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module Update
        class Presenter < MainService
          def call(transaction)
            {
              id: transaction.id,
              name: transaction.name,
              amount: transaction.amount,
              transaction_date: transaction.transaction_date,
              transaction_type: transaction.transaction_type,
              registered_at: Util.format_date(transaction.created_at)
            }
          end
        end
      end
    end
  end
end
