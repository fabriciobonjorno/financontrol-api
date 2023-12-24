# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Update
        class UseCase < MainService
          step :validate_inputs
          step :update
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

          def update(params)
            id = params[:category][:id]
            user_id =  params[:current_user][:id]
            category = find_category(id, user_id)
            return Failure(I18n.t('categories.errors.not_found')) unless category

            category.name = params[:category][:name] if params[:category][:name].present?
            category.icon = params[:category][:icon] if params[:category][:icon].present?

            category.save ? Success(category) : Failure(category.errors.full_messages.to_sentence)
          end

          def output(category)
            response = Presenter.call(category)
            response ? Success([I18n.t('categories.success.updated', name: category&.name), response]) : Failure(category.errors.full_messages.to_sentence)
          end

          private

          def find_category(id, user_id)
            OwnerServices::ValidOwner::FindOwner.call(id, user_id, Category)
          end
        end
      end
    end
  end
end
