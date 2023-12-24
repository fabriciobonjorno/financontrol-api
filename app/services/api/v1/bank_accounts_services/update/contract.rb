# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Update
        class Contract < ApplicationContract
          params do
            required(:id).value(:string)
            required(:bank_account).hash do
              optional(:name).value(:string)
              optional(:initial_balance).value(:string)
              optional(:account_type).value(:string)
              optional(:color).value(:string)
            end
          end
        end
      end
    end
  end
end
