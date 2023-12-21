# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Update
        class Contract < ApplicationContract
          params do
            required(:id).value(:string)
            required(:category).hash do
              optional(:name).value(:string)
              optional(:icon).value(:string)
            end
          end
        end
      end
    end
  end
end
