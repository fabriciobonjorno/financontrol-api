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
            validation.success? ? Success(hash_params) : Failure(validation.errors.to_h)
          end

          def create(params)
            category_params = params[:category]
            user_id = params[:current_user].id
            category = Category.new
            category.name = category_params[:name]
            category.icon = category_params[:icon]
            category.user_id = user_id

            if category.save
              Success(category)
            else
              Failure(category.errors.full_messages)
            end
          end

          def output(category)
            response = Presenter.call(category)
            if response
              Success(response)
            else
              Failure(category.errors.full_messages)
            end
          end
        end
      end
    end
  end
end
