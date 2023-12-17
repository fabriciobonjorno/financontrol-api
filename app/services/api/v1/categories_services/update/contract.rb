# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Update
        class Contract < ApplicationContract
          params do
            required(:id).filled(:string)
            required(:category).hash do
              required(:name).filled(:string)
              optional(:icon).filled(:string)
            end
          end
        end
      end
    end
  end
end
