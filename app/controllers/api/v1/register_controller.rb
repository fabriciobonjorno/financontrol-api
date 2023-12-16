# frozen_string_literal: true

module Api
  module V1
    class RegisterController < ApplicationController
      def create
        Api::V1::RegisterServices::Create::Transaction.call(params) do |on|
          on.failure(:validate_params) { |message| render json: { message: }, status: 400 }
          on.failure(:create) { |message| render json: { message: }, status: 400 }
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end

      def confirmation
        Api::V1::RegisterServices::Confirmation::Transaction.call(params) do |on|
          on.failure(:validate_params) { |message| render json: { message: }, status: 400 }
          on.failure(:validate_token) { |message| render json: { message: }, status: 400 }
          on.failure(:account_confirmation) { |message| render json: { message: }, status: 400 }
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end
    end
  end
end
