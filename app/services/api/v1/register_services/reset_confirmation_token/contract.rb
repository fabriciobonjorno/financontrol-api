# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module ResetConfirmationToken
        class Contract < ApplicationContract
          params do
            required(:email).filled(:string)
          end
        end
      end
    end
  end
end
