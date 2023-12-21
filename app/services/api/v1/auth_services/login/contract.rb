# frozen_string_literal: true

module Api
  module V1
    module AuthServices
      module Login
        class Contract < ApplicationContract
          params do
            required(:email).value(:string)
            required(:password).value(:string)
          end
        end
      end
    end
  end
end
