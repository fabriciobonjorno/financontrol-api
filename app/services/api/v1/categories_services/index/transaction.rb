# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Index
        class Transaction < MainService
          step :validate_inputs
          step :paginate_categories
          step :output

          def validate_inputs(params)
            filter_params, current_user = params

            hash_params = {
              filter_params:,
              current_user:
            }.compact

            validation = Contract.call(filter_params.permit!.to_h)
            validation.success? ? Success(hash_params) : Failure(validation.errors.to_h)
          end

          def paginate_categories(params)
            current_page = params.dig(:filter_params, :current_page) || 1
            per_page = params.dig(:filter_params, :per_page) || 10
            order = params.dig(:filter_params, :order) || 'asc'
            filter = params.dig(:filter_params, :name)
            user_id = params[:current_user].id

            categories = find_by_search(user_id, order, filter)
            categories = categories.page(current_page).per(per_page)

            Success(categories)
          end

          def output(categories)
            response = Presenter.call(categories)
            if response
              Success(response)
            else
              Failure(I18n.t('categories.errors.not_exists'))
            end
          end

          private

          def find_by_search(user_id, order, filter)
            categories = Category.where(user_id:)
            categories = categories.order(name: order)
            categories = categories.where('UPPER(name) LIKE ?', "%#{filter.upcase}%") if filter.present?
            categories
          end
        end
      end
    end
  end
end
