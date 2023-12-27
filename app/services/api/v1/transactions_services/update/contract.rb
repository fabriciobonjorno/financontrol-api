# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module Update
        class Contract < ApplicationContract
          params do
            required(:id).value(:string)
            required(:transaction).hash do
              optional(:name).value(:string)
              optional(:amount).value(:float)
              optional(:transaction_type).value(:string)
              optional(:transaction_date).value(:string)
              optional(:bank_account_id).value(:string)
              optional(:category_id).value(:string)
            end
          end
        end
      end
    end
  end
end
