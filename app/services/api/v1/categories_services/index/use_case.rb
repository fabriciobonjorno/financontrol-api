# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Index
        class UseCase < MainService
          step :check_exists
          step :validate_params
          step :paginate_filters
          step :output

          def check_exists(params)
            bank_accounts = FiltersServices::Name::InitialFilter.call(params, Category)

            return Failure(I18n.t('bank_accounts.errors.not_exists')) if bank_accounts.empty?

            Success(params)
          end

          def validate_params(params)
            FiltersServices::Name::Validate.call(params)
          end

          def paginate_filters(params)
            categories = FiltersServices::Name::Filter.call(params, Category)
            categories = categories.all_categories

            return Failure(I18n.t('categories.errors.not_exists')) if categories.empty?

            Success(categories)
          end

          def output(categories)
            response = Presenter.call(categories)
            Success(response)
          end
        end
      end
    end
  end
end
