# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Create
        class Presenter < MainService
          def call(category)
            {
              id: category.id,
              name: category.name,
              icon: category.icon,
              registered_at: Util.format_date(category.created_at)
            }
          end
        end
      end
    end
  end
end
