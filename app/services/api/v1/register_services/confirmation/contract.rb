# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Confirmation
        class Contract < ApplicationContract
          params do
            required(:confirmation_token).value(:string)
          end
        end
      end
    end
  end
end
