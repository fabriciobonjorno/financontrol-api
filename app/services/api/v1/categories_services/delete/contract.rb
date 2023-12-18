# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Delete
        class Contract < ApplicationContract
          params do
            required(:id).filled(:string)
          end
        end
      end
    end
  end
end
