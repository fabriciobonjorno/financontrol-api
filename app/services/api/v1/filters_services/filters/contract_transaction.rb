# frozen_string_literal: true

module Api
  module V1
    module FiltersServices
      module Filters
        class ContractTransaction < ApplicationContract
          params do
            required(:month).value(:integer)
            required(:year).value(:integer)
            optional(:current_page).value(:integer)
            optional(:per_page).value(:integer)
            optional(:name).value(:string)
            optional(:bank_account_id).value(:string)
            optional(:category_id).value(:string)
            optional(:transaction_type).value(:string)
          end
        end
      end
    end
  end
end
