# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApplicationController
      before_action :authorize_access_request!, only: [:logout]
      def login
        Api::V1::AuthServices::Login::UseCase.call(params) do |on|
          on.failure(:validate_params) { |message, _content| render json: { message: }, status: 400 }
          on.failure(:find_user) { |message| render json: { message: }, status: 401 }
          on.failure(:verify_confirmation) { |message| render json: { message: }, status: 401 }
          on.failure(:verify_block) { |message| render json: { message: }, status: 401 }
          on.failure(:create_session) { |message| render json: { message: }, status: 401 }
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 500 }
          on.success { |response| render json: response, status: 200 }
        end
      end

      def logout
        Api::V1::AuthServices::Logout::UseCase.call(payload) do |on|
          on.failure(:output) { |message| render json: { message: }, status: 500 }
          on.failure { |response| render json: response, status: 401 }
          on.success { |response| render json: response, status: 200 }
        end
      end
    end
  end
end
