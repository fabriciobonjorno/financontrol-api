# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Create
        class Contract < ApplicationContract
          params do
            required(:name).value(:string)
            required(:email).value(:string)
            required(:password).value(:string)
            required(:password_confirmation).value(:string)
            required(:birth_date).value(:date)
          end
        end
      end
    end
  end
end
