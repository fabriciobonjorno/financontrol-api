# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Create
        class Contract < ApplicationContract
          params do
            required(:name).filled(:string)
            required(:initial_balance).filled(:float)
            required(:account_type).filled(:string)
            required(:color).filled(:string)
          end
        end
      end
    end
  end
end
