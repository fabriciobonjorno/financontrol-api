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
            categories = FiltersServices::Filters::CheckEmpty.call(params, Category)

            return Failure(I18n.t('categories.errors.not_exists')) if categories.empty?

            Success(params)
          end

          def validate_params(params)
            FiltersServices::Filters::ValidateName.call(params)
          end

          def paginate_filters(params)
            categories = FiltersServices::Filters::FilterName.call(params, Category)
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
