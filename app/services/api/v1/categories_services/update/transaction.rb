# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Update
        class Transaction < MainService
          step :validate_inputs
          step :update
          step :output

          def validate_inputs(params)
            validation = Contract.call(params.permit!.to_h)
            validation.success? ? Success(params) : Failure(format_errors(validation.errors.to_h))
          end

          def update(params)
            category = Category.find(params[:id])
            return Failure(I18n.t('categories.errors.not_found')) if category.nil?

            category.name = params[:name]
            category.icon = params[:icon]

            if category.save
              Success(category)
            else
              Failure(category.errors.full_messages.to_sentence)
            end
          end

          def output(category)
            response = Presenter.call(category)
            if response
              Success(response)
            else
              Failure(category.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
