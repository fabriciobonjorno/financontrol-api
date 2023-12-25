# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module Index
        class UseCase < MainService
          step :check_exists
          step :validate_params
          step :paginate_filters
          step :output

          def check_exists(params)
            transactions = FiltersServices::Filters::CheckEmpty.call(params, Transaction)
            return Failure(I18n.t('transactions.errors.not_exists')) if transactions.empty?

            Success(params)
          end

          def validate_params(params)
            FiltersServices::Filters::ValidateTransaction.call(params)
          end

          def paginate_filters(params)
            transactions = FiltersServices::Filters::FilterTransaction.call(params, Transaction)
            transactions = transactions.all_transactions
            return Failure(I18n.t('transactions.errors.not_exists')) if transactions.empty?

            Success(transactions)
          end

          def output(transactions)
            response = Presenter.call(transactions)
            Success(response)
          end
        end
      end
    end
  end
end
