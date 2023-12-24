# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module ResetConfirmationToken
        class Transaction < MainService
          step :validate_params
          step :send_token
          step :output

          def validate_params(params)
            validation = Contract.call(params.permit!.to_h)
            validation.success? ? Success(params) : Failure(format_errors(validation.errors.to_h))
          end

          def send_token(params)
            user = User.find_by(email: params[:email])
            return Failure(I18n.t('confirmation.errors.not_found')) if user.nil?
            return Failure(I18n.t('confirmation.errors.confirmed')) if user.confirmed?

            send_confirmation_email(user)
            Success(user)
          end

          def output(user)
            Success(message: I18n.t('confirmation.success.reset_token', email: user&.email))
          end

          private

          def send_confirmation_email(user)
            user.generate_confirmation_token
            Thread.new { SendConfirmationMailer.send_confirmation_token(user).deliver }
          end
        end
      end
    end
  end
end
