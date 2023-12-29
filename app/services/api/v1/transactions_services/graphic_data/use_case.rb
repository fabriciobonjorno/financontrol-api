# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module GraphicData
        class UseCase < MainService
          step :validate_params
          step :paginate_filters
          step :output

          def validate_params(params)
            FiltersServices::Filters::ValidateTransaction.call(params)
          end

          def paginate_filters(params)
            transactions = FiltersServices::Filters::FilterGraphicTransaction.call(params, Transaction)
            return Failure(I18n.t('transactions.errors.not_exists')) if transactions.empty?

            graphic_results = {
              incomes_by_category: transactions.incomes_by_category,
              expenses_by_category: transactions.expenses_by_category,
              incomes: transactions.incomes,
              expenses: transactions.expenses
            }
            Success(graphic_results)
          end

          def output(graphic_results)
            response = Presenter.call(graphic_results)
            Success(response)
          end
        end
      end
    end
  end
end
