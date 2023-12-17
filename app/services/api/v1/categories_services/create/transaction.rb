# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Create
        class Transaction < MainService
          step :validate_inputs
          step :create
          step :output

          def validate_inputs(params)
            category, current_user = params

            hash_params = {
              category:,
              current_user:
            }.compact
            validation = Contract.call(category.permit!.to_h)
            validation.success? ? Success(hash_params) : Failure(format_errors(validation.errors.to_h))
          end

          def create(params)
            category_params = params[:category]
            user_id = params[:current_user].id
            category = Category.new(
              name: category_params[:name],
              icon: category_params[:icon],
              user_id:
            )

            category.save ? Success(category) : Failure(category.errors.full_messages.to_sentence)
          end

          def output(category)
            response = Presenter.call(category)
            response ? Success(response) : Failure(category.errors.full_messages.to_sentence)
          end
        end
      end
    end
  end
end
