# frozen_string_literal: true

module Api
  module V1
    module AuthServices
      module Login
        class Contract < ApplicationContract
          params do
            required(:email).filled(:string)
            required(:password).filled(:string)
          end
        end
      end
    end
  end
end
