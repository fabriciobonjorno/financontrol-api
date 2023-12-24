# frozen_string_literal: true

require 'api_constraints'

Rails.application.routes.draw do
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      namespace :register do
        post :create
        post :confirmation
        post :reset_confirmation_token
      end

      namespace :auth do
        post :login
        delete :logout
      end
      resources :categories
      resources :bank_accounts
      resources :transactions
    end
  end
  post 'set_locale/:locale', to: 'application#set_locale'
  get 'check_locale', to: 'application#check_locale'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
