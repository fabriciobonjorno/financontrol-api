# frozen_string_literal: true

module Api
  module V1
    module FiltersServices
      module Name
        class Contract < ApplicationContract
          params do
            optional(:current_page).value(:integer)
            optional(:per_page).value(:integer)
            optional(:filter_name).value(:string)
            optional(:order).value(:string)
          end
        end
      end
    end
  end
end
