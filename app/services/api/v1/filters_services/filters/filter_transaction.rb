# frozen_string_literal: true

module Api
  module V1
    module FiltersServices
      module Filters
        class FilterTransaction < MainService
          def call(params, model)
            user_id = params[:current_user].id
            filter_params = params[:filter_params] || {}
            current_page = filter_params[:current_page] || 1
            per_page = filter_params[:per_page] || 10
            order = filter_params[:order] || 'asc'
            name = filter_params[:name]
            month = filter_params[:month]
            year = filter_params[:year]
            transaction_type = filter_params[:transaction_type]
            category_id = filter_params[:category_id]
            bank_account_id = filter_params[:bank_account_id]

            start_date = Date.new(year, month, 1)
            end_date = start_date.end_of_month if start_date

            find_list = model.where(user_id:)
            find_list = find_list.order(transaction_date: order)
            find_list = find_list.where('transaction_date between ? AND ?', start_date, end_date) if start_date && end_date
            find_list = find_list.where(transaction_type:) unless transaction_type.nil?
            find_list = find_list.where(category_id:) unless category_id.nil?
            find_list = find_list.where(bank_account_id:) unless bank_account_id.nil?
            find_list = find_list.where('unaccent(name) ilike unaccent(?)', "%#{name.upcase}%") unless name.nil?
            find_list.page(current_page).per(per_page)
          end
        end
      end
    end
  end
end
