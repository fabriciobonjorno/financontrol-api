# frozen_string_literal: true

module Api
  module V1
    module AuthServices
      module Login
        class Presenter < MainService
          def call(token)
            {
              csrf: token[:csrf],
              access_token: token[:access],
              refresh_token: token[:refresh]
            }
          end
        end
      end
    end
  end
end
