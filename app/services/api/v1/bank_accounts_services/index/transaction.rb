# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Index
        class Transaction < MainService
          step :validate_params
          step :paginate_filters
          step :output

          def validate_params(params)
            FiltersServices::Name::Validate.call(params)
          end

          def paginate_filters(params)
            bank_accounts = FiltersServices::Name::Filter.call(params, BankAccount)

            return Failure(I18n.t('bank_accounts.errors.not_exists')) if bank_accounts.empty?

            Success(bank_accounts)
          end

          def output(bank_accounts)
            response = Presenter.call(bank_accounts)
            Success(response)
          end
        end
      end
    end
  end
end
