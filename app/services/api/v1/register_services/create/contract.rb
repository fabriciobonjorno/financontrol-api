# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Create
        class Contract < ApplicationContract
          params do
            required(:name).filled(:string)
            required(:email).filled(:string)
            required(:password).filled(:string)
            required(:password_confirmation).filled(:string)
            required(:birth_date).filled(:date)
          end
        end
      end
    end
  end
end
