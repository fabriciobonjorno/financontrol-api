# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module Update
        class UseCase < MainService
          step :validate_inputs
          step :update
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

          def update(params)
            id = params[:transaction][:id]
            user_id = params[:current_user][:id]
            transaction = find_transaction(id, user_id)
            return Failure(I18n.t('transactions.errors.not_found')) unless transaction

            transaction.name = params[:transaction][:name] if params[:transaction][:name].present?
            transaction.amount = params[:transaction][:amount] if params[:transaction][:amount].present?
            transaction.transaction_type = params[:transaction][:transaction_type] if params[:transaction][:transaction_type].present?
            transaction.transaction_date = params[:transaction][:transaction_date] if params[:transaction][:transaction_date].present?
            transaction.bank_account_id = params[:transaction][:bank_account_id] if params[:transaction][:bank_account_id].present?
            transaction.category_id = params[:transaction][:category_id] if params[:transaction][:category_id].present?

            transaction.save ? Success(transaction) : Failure(transaction.errors.full_messages.to_sentence)
          end

          def output(transaction)
            response = Presenter.call(transaction)
            response ? Success([I18n.t('transactions.success.updated', name: transaction&.name), response]) : Failure(transaction.errors.full_messages.to_sentence)
          end

          private

          def find_transaction(id, user_id)
            OwnerServices::ValidOwner::FindOwner.call(id, user_id, Transaction)
          end
        end
      end
    end
  end
end
