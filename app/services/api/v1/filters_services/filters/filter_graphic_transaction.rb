# frozen_string_literal: true

module Api
  module V1
    module FiltersServices
      module Filters
        class FilterGraphicTransaction < MainService
          def call(params, model)
            user_id = params[:current_user].id
            filter_params = params[:filter_params] || {}

            month = filter_params[:month]
            year = filter_params[:year]
            bank_account_id = filter_params[:bank_account_id]

            start_date = Date.new(year, month, 1) if year && month
            end_date = start_date.end_of_month if start_date

            find_list = model.where(user_id:)

            find_list = find_list.where('transaction_date between ? AND ?', start_date, end_date) if start_date && end_date

            find_list = find_list.where(bank_account_id:) unless bank_account_id.nil?

            find_list
          end
        end
      end
    end
  end
end
