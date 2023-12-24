# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      def create
        Api::V1::TransactionsServices::Create::UseCase.call([params, current_user]) do |on|
          on.failure(:validate_params) { |message| render json: { message: }, status: 400 }
          on.failure(:check_category_account) { |message| render json: { message: }, status: 400 }
          on.failure(:create) { |message| render json: { message: }, status: 400 }
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |message, transaction| render json: { message:, transaction: }, status: 200 }
        end
      end
    end
  end
end
