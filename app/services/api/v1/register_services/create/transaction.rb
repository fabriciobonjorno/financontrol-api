# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Create
        class Transaction < MainService
          step :validate_params
          step :create
          step :output

          def validate_params(params)
            validation = Contract.call(params.permit!.to_h)
            validation.success? ? Success(params) : Failure(format_errors(validation.errors.to_h))
          end

          def create(params)
            user = User.new(
              name: params[:name],
              email: params[:email],
              password: params[:password],
              password_confirmation: params[:password_confirmation],
              birth_date: params[:birth_date]
            )

            if user.save
              send_confirmation_email(user)
              Success(user)
            else
              Failure(user.errors.full_messages.to_sentence)
            end
          end

          def output(user)
            response = Presenter.call(user)
            response ? Success(response) : Failure(user.errors.full_messages.to_sentence)
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
