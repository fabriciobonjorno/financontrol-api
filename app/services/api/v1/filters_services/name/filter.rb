# frozen_string_literal: true

module Api
  module V1
    module FiltersServices
      module Name
        class Filter < MainService
          def call(params, model)
            user_id = params[:current_user].id
            filter_params = params[:filter_params] || {}
            current_page = filter_params[:current_page] || 1
            per_page = filter_params[:per_page] || 10
            order = filter_params[:order] || 'asc'
            filter = filter_params[:filter_name]

            find_list = model.where(user_id:)
            find_list = find_list.order(name: order)
            find_list = find_list.where('unaccent(name) ilike unaccent(?)', "%#{filter.upcase}%") if filter.present?
            find_list.page(current_page).per(per_page)
          end
        end
      end
    end
  end
end
