# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module GraphicData
        class Presenter < MainService
          def call(graphic_results)
            transactions_map(graphic_results)
          end

          private

          def transactions_map(graphic_results)
            incomes_category = graphic_results[:incomes_by_category]
            expenses_category = graphic_results[:expenses_by_category]
            total_incomes = graphic_results[:incomes]
            total_expenses = graphic_results[:expenses]

            incomes = incomes_category.map do |category, total_category|
              {
                category: category.name,
                total: total_category.to_f,
                percentage: ((total_category.to_f / total_incomes) * 100).round(2)
              }
            end

            expenses = expenses_category.map do |category, total_category|
              {
                category: category.name,
                total: total_category.to_f,
                percentage: ((total_category.to_f / total_expenses) * 100).round(2)
              }
            end

            {
              incomes:,
              expenses:
            }
          end
        end
      end
    end
  end
end
