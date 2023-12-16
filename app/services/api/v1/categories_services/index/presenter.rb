# frozen_string_literal: true

module Api
  module V1
    module CategoriesServices
      module Index
        class Presenter < MainService
          def call(categories)
            profiles_map(categories)
          end

          def profiles_map(categories)
            # TODO: After remove unnecessary fields from pagination
            {
              pagination: {
                count: categories.count,
                limit_value: categories.limit_value,
                total_pages: categories.total_pages,
                current_page: categories.current_page,
                next_page: categories.next_page,
                prev_page: categories.prev_page,
                first_page: categories.first_page?,
                last_page: categories.last_page?
              },
              categories: categories.map { |category| category_map(category) }
            }
          end

          def category_map(category)
            {
              id: category.id,
              name: category.name,
              icon: category.icon,
              created_at: Util.format_date(category.created_at)
            }
          end
        end
      end
    end
  end
end
