# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Create
        class Contract < ApplicationContract
          params do
            required(:name).value(:string)
            required(:initial_balance).value(:float)
            required(:account_type).value(:string)
            required(:color).value(:string)
          end
        end
      end
    end
  end
end
