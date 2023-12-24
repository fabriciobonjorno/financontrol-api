# frozen_string_literal: true

module Api
  module V1
    module AuthServices
      module Login
        class UseCase < MainService
          step :validate_params
          step :find_user
          step :verify_confirmation
          step :verify_block
          step :create_session
          step :output

          def validate_params(params)
            validation = Contract.call(params.permit!.to_h)
            validation.success? ? Success(params) : Failure(format_errors(validation.errors.to_h))
          end

          def find_user(params)
            user = User.find_by(email: params[:email])
            if user
              Success(user:, params:)
            else
              Failure(I18n.t('login.errors.invalid_credentials'))
            end
          end

          def verify_confirmation(params)
            user = params[:user]
            if user.confirmed?
              Success(params)
            else
              Failure(I18n.t('login.errors.not_confirmed'))
            end
          end

          def verify_block(params)
            user = params[:user]
            time = timeout(user) if user.locked_at.present?
            if user.locked && time.to_i.positive?
              Failure(I18n.t('login.errors.blocked', time:))
            elsif user.locked && time.to_i.negative?
              user&.reset_attempts
              Success(params)
            else
              Success(params)
            end
          end

          def create_session(params)
            user_params = params[:params]
            user = params[:user]

            if user&.authenticate(user_params[:password])
              payload = { user_id: user.id }
              session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true)
              token = session.login
              user&.reset_attempts if user.login_attempts.positive?
              Success(token)
            else
              user&.update_attempts
              time = timeout(user) if user.locked_at.present?
              attempts = user ? 5 - user.login_attempts : 0
              message = attempts.zero? ? I18n.t('login.errors.blocked', time:) : I18n.t('login.errors.attempts', attempts:)
              Failure(message)
            end
          end

          def output(token)
            response = Presenter.call(token)
            if response
              Success(response)
            else
              Failure(token.errors.full_messages.to_sentence)
            end
          end

          private

          def timeout(user)
            Util.calculate_time(user.locked_at, 2.hours, Time.now)
          end
        end
      end
    end
  end
end
