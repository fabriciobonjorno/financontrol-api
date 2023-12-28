# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Index
        class Presenter < MainService
          def call(bank_accounts)
            bank_accounts_map(bank_accounts)
          end

          def bank_accounts_map(bank_accounts)
            # TODO: After remove unnecessary fields from pagination
            {
              pagination: {
                count: bank_accounts.count,
                limit_value: bank_accounts.limit_value,
                total_pages: bank_accounts.total_pages,
                current_page: bank_accounts.current_page,
                next_page: bank_accounts.next_page,
                prev_page: bank_accounts.prev_page,
                first_page: bank_accounts.first_page?,
                last_page: bank_accounts.last_page?
              },
              bank_accounts: bank_accounts.map { |bank_account| bank_account_map(bank_account) }
            }
          end

          def bank_account_map(bank_account)
            incomes = bank_account.transactions.incomes
            expenses = bank_account.transactions.expenses
            total_balance = bank_account.initial_balance + (incomes - expenses)

            {
              id: bank_account.id,
              name: bank_account.name,
              total_balance: total_balance.to_f,
              account_type: bank_account.account_type,
              color: bank_account.color,
              created_at: Util.format_date(bank_account.created_at)
            }
          end
        end
      end
    end
  end
end
