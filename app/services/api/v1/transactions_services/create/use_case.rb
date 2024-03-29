# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module Create
        class UseCase < MainService
          step :validate_inputs
          step :check_category_account
          step :create
          step :output

          def validate_inputs(params)
            transaction, current_user = params

            hash_params = {
              transaction:,
              current_user:
            }.compact
            validation = Contract.call(transaction.permit!.to_h)
            validation.success? ? Success(hash_params) : Failure(format_errors(validation.errors.to_h))
          end

          def check_category_account(params)
            account_id = params[:transaction][:bank_account_id]
            category_id = params[:transaction][:category_id]
            user_id = params[:current_user][:id]

            category = find_category(category_id, user_id)
            return Failure(I18n.t('categories.errors.not_found')) unless category

            bank_account = find_bank_account(account_id, user_id)
            return Failure(I18n.t('bank_accounts.errors.not_found')) unless bank_account

            Success(params)
          end

          def create(params)
            transaction_params = params[:transaction]
            category_id = params[:transaction][:category_id]
            bank_account_id = params[:transaction][:bank_account_id]
            user_id = params[:current_user][:id]
            transaction = Transaction.new(
              name: transaction_params[:name],
              amount: transaction_params[:amount],
              transaction_type: transaction_params[:transaction_type],
              transaction_date: transaction_params[:transaction_date],
              user_id:,
              category_id:,
              bank_account_id:
            )

            transaction.save ? Success(transaction) : Failure(transaction.errors.full_messages.to_sentence)
          end

          def output(transaction)
            response = Presenter.call(transaction)
            response ? Success([I18n.t('transactions.success.created', name: transaction&.name), response]) : Failure(transaction.errors.full_messages.to_sentence)
          end

          private

          def find_category(category_id, user_id)
            OwnerServices::ValidOwner::FindOwner.call(category_id, user_id, Category)
          end

          def find_bank_account(account_id, user_id)
            OwnerServices::ValidOwner::FindOwner.call(account_id, user_id, BankAccount)
          end
        end
      end
    end
  end
end
