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
            validation.success? ? Success(params) : Failure(validation.errors.to_h)
          end

          def send_token(params)
            user = User.find_by(email: params[:email])
            return Failure(I18n.t('confirmation.errors.not_found')) if user.nil?
            return Failure(I18n.t('confirmation.errors.confirmed')) if user.confirmed?

            send_confirmation_email(user)
            Success(user)
          end

          def output(user)
            response = Presenter.call(user)
            if response
              Success(response)
            else
              Failure(user.errors.full_messages)
            end
          end

          private

          def send_confirmation_email(user)
            user = User.find_by_email(user.email)
            user.generate_confirmation_token
            Thread.new do
              SendConfirmationMailer.send_confirmation_token(user).deliver
            end
          end
        end
      end
    end
  end
end
