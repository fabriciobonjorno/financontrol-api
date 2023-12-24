# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module Create
        class Contract < ApplicationContract
          params do
            required(:name).value(:string)
            required(:amount).value(:float)
            required(:transaction_type).value(:string)
            required(:transaction_date).value(:date)
            required(:bank_account_id).value(:string)
            required(:category_id).value(:string)
          end
        end
      end
    end
  end
end
