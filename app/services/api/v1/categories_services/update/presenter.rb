# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Update
        class Presenter < MainService
          def call(category)
            {
              id: category.id,
              name: category.name,
              icon: category.icon,
              updated_at: Util.format_date(category.updated_at)
            }
          end
        end
      end
    end
  end
end
