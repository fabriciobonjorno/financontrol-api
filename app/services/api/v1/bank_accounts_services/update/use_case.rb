# frozen_string_literal: true

module Api
  module V1
    module BankAccountsServices
      module Update
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

            bank_account.name = params[:bank_account][:name] if params[:bank_account][:name].present?
            bank_account.initial_balance = params[:bank_account][:initial_balance] if params[:bank_account][:initial_balance].present?
            bank_account.account_type = params[:bank_account][:account_type] if params[:bank_account][:account_type].present?
            bank_account.color = params[:bank_account][:color] if params[:bank_account][:color].present?

            bank_account.save ? Success(bank_account) : Failure(bank_account.errors.full_messages.to_sentence)
          end

          def output(bank_account)
            response = Presenter.call(bank_account)
            response ? Success([I18n.t('bank_accounts.success.updated', name: bank_account&.name), response]) : Failure(bank_account.errors.full_messages.to_sentence)
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
