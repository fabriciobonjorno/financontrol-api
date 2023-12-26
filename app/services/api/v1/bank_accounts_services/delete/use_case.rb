# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Delete
        class UseCase < MainService
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
            id = params[:bank_account][:id]
            user_id = params[:current_user][:id]

            bank_account = find_bank_account(id, user_id)
            return Failure(I18n.t('bank_accounts.errors.not_found')) unless bank_account

            bank_account.soft_delete ? Success(bank_account) : Failure(bank_account.errors.full_messages.to_sentence)
          end

          def output(bank_account)
            Success(message: I18n.t('bank_accounts.success.deleted', name: bank_account.name))
          end

          private

          def find_bank_account(id, user_id)
            OwnerServices::ValidOwner::FindOwner.call(id, user_id, BankAccount)
          end
        end
      end
    end
  end
end
