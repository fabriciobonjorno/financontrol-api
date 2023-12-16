# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Confirmation
        class Contract < ApplicationContract
          params do
            required(:confirmation_token).filled(:string)
          end
        end
      end
    end
  end
end
