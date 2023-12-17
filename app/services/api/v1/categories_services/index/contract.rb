# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Index
        class Contract < ApplicationContract
          params do
            optional(:current_page).filled(:integer)
            optional(:per_page).filled(:integer)
            optional(:name).filled(:string)
            optional(:order).filled(:string)
          end
        end
      end
    end
  end
end
