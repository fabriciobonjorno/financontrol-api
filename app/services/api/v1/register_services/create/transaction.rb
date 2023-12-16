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
            validation.success? ? Success(params) : Failure(validation.errors.to_h)
          end

          def create(params)
            user = User.new
            user.name = params[:name]
            user.email = params[:email]
            user.password = params[:password]
            user.password_confirmation = params[:password_confirmation]
            user.birth_date = params[:birth_date]

            if user.save
              send_confirmation_email(user)
              Success(user)
            else
              Failure(user.errors.full_messages)
            end
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
