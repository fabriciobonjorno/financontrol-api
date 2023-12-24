# frozen_string_literal: true

module Api
  module V1
    module AuthServices
      module Logout
        class UseCase < MainService
          step :destroy_session

          def destroy_session(payload)
            session = JWTSessions::Session.new(payload:)
            session.flush_by_access_payload
            if session.present?
              Success(message: I18n.t('login.success.sign_out'))
            else
              Failure(message: I18n.t('login.errors.sign_out'))
            end
          end
        end
      end
    end
  end
end
