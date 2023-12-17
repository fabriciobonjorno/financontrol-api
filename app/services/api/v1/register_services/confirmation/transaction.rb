# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Confirmation
        class Transaction < MainService
          step :validate_params
          step :validate_token
          step :account_confirmation
          step :output

          def validate_params(params)
            validation = Contract.call(params.permit!.to_h)
            validation.success? ? Success(params) : Failure(format_errors(validation.errors.to_h))
          end

          def validate_token(params)
            user = User.find_by(confirmation_token: params[:confirmation_token])
            return Failure(I18n.t('confirmation.errors.not_found')) if user.nil?
            return Failure(I18n.t('confirmation.errors.timeout')) unless user.token_is_valid?(params[:confirmation_token])
            return Failure(I18n.t('confirmation.errors.confirmed')) if user.confirmed?

            Success(user)
          end

          def account_confirmation(user)
            user.confirm_account
            if user
              Success(user)
            else
              Failure(I18n.t('confirmation.errors.unknown'))
            end
          end

          def output(user)
            response = Presenter.call(user)
            if response
              Success(response)
            else
              Failure(user.errors.full_messages.to_sentence)
            end
          end
        end
      end
    end
  end
end
