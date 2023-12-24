# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Create
        class UseCase < MainService
          step :validate_inputs
          step :create
          step :output

          def validate_inputs(params)
            bank_account, current_user = params

            hash_params = {
              bank_account:,
              current_user:
            }.compact
            validation = Contract.call(bank_account.permit!.to_h)
            validation.success? ? Success(hash_params) : Failure(format_errors(validation.errors.to_h))
          end

          def create(params)
            bank_account_params = params[:bank_account]
            user_id = params[:current_user].id
            bank_account = BankAccount.new(
              name: bank_account_params[:name],
              initial_balance: bank_account_params[:initial_balance],
              account_type: bank_account_params[:account_type],
              color: bank_account_params[:color],
              user_id:
            )

            bank_account.save ? Success(bank_account) : Failure(bank_account.errors.full_messages.to_sentence)
          end

          def output(bank_account)
            response = Presenter.call(bank_account)
            response ? Success([I18n.t('bank_accounts.success.created', name: bank_account&.name), response]) : Failure(category.errors.full_messages.to_sentence)
          end
        end
      end
    end
  end
end
