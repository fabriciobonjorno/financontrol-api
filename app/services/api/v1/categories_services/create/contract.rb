# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Create
        class Contract < ApplicationContract
          params do
            required(:name).filled(:string)
            required(:icon).filled(:string)
          end
        end
      end
    end
  end
end
