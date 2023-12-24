# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Delete
        class Transaction < MainService
          step :validate_inputs
          step :update
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

          def update(params)
            bank_account = BankAccount.find(params[:bank_account][:id])
            return Failure(I18n.t('bank_accounts.errors.not_found')) if bank_account.nil?
            return Failure(I18n.t('bank_accounts.errors.not_found')) if bank_account.user != params[:current_user]

            bank_account.deleted_at = Time.now

            bank_account.save ? Success(bank_account) : Failure(bank_account.errors.full_messages.to_sentence)
          end

          def output(bank_account)
            Success(message: I18n.t('bank_accounts.success.deleted', name: bank_account.name))
          end
        end
      end
    end
  end
end
