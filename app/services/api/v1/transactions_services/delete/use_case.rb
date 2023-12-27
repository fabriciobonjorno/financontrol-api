# frozen_string_literal: true

module Api
  module V1
    module TransactionsServices
      module Delete
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

            transaction.soft_delete ? Success(transaction) : Failure(transaction.errors.full_messages.to_sentence)
          end

          def output(transaction)
            Success(message: I18n.t('transactions.success.deleted', name: transaction.name))
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
