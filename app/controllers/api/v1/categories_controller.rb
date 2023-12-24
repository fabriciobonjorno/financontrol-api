# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApiController
      def index
        Api::V1::CategoriesServices::Index::Transaction.call([params, current_user]) do |on|
          on.failure(:check_exists) { |message| render json: { message: }, status: 400 }
          on.failure(:validate_params) { |message| render json: message, status: 400 }
          on.failure(:paginate_filters) { |message| render json: { message: }, status: 400 }
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end

      def create
        Api::V1::CategoriesServices::Create::Transaction.call([params, current_user]) do |on|
          on.failure(:validate_params) { |message| render json: { message: }, status: 400 }
          on.failure(:create) { |message| render json: { message: }, status: 400 }
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |message, category| render json: { message:, category: }, status: 200 }
        end
      end

      def update
        Api::V1::CategoriesServices::Update::Transaction.call([params, current_user]) do |on|
          on.failure(:validate_params) { |message| render json: { message: }, status: 400 }
          on.failure(:update) { |message| render json: { message: }, status: 400 }
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end

      def destroy
        Api::V1::CategoriesServices::Delete::Transaction.call([params, current_user]) do |on|
          on.failure(:validate_params) { |message| render json: { message: }, status: 400 }
          on.failure(:delete) { |message| render json: { message: }, status: 400 }
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end
    end
  end
end
