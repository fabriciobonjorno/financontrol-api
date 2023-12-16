# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApiController
      def index
        Api::V1::CategoriesServices::Index::Transaction.call([params, current_user]) do |on|
          on.failure(:validate_params) { |message| render json: { message: }, status: 400 }
          on.failure(:paginate_categories) { |message| render json: { message: }, status: 400 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end

      def create
        Api::V1::CategoriesServices::Create::Transaction.call([params, current_user]) do |on|
          on.failure(:validate_params) { |message| render json: { message: }, status: 400 }
          on.failure(:create_category) { |message| render json: { message: }, status: 400 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end
    end
  end
end
