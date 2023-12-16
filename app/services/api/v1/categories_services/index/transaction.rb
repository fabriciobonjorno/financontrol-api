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
            paginate, current_user = params

            hash_params = {
              paginate:,
              current_user:
            }.compact

            validation = Contract.call(paginate.permit!.to_h)
            validation.success? ? Success(hash_params) : Failure(validation.errors.to_h)
          end

          def paginate_categories(params)
            current_page = params.dig(:paginate, :current_page) || 1
            per_page = params.dig(:paginate, :per_page) || 10
            user_id = params[:current_user].id

            categories = Category.where(user_id:)
                                 .page(current_page)
                                 .per(per_page)

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
        end
      end
    end
  end
end
