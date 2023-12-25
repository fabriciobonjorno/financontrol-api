# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module Index
        class Presenter < MainService
          def call(transactions)
            transactions_map(transactions)
          end

          def transactions_map(transactions)
            # TODO: After remove unnecessary fields from pagination
            {
              pagination: {
                count: transactions.count,
                limit_value: transactions.limit_value,
                total_pages: transactions.total_pages,
                current_page: transactions.current_page,
                next_page: transactions.next_page,
                prev_page: transactions.prev_page,
                first_page: transactions.first_page?,
                last_page: transactions.last_page?
              },
              transactions: transactions.map { |transaction| transaction_map(transaction) }
            }
          end

          def transaction_map(transaction)
            {
              id: transaction.id,
              name: transaction.name,
              amount: transaction.amount,
              transaction_date: Util.format_date(transaction.transaction_date),
              transaction_type: transaction.transaction_type,
              icon: transaction.category.icon,
              category: transaction.category.name,
              bank_account: transaction.bank_account.name,
              created_at: Util.format_date(transaction.created_at)
            }
          end
        end
      end
    end
  end
end
