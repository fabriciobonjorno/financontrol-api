# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Index
        class Contract < ApplicationContract
          params do
            optional(:current_page).filled(:integer)
            optional(:per_page).filled(:integer)
          end
        end
      end
    end
  end
end
