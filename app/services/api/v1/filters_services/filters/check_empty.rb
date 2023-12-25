# frozen_string_literal: true

module Api
  module V1
    module FiltersServices
      module Filters
        class CheckEmpty < MainService
          def call(params, model)
            _, current_user = params
            user_id = current_user.id
            model.where(user_id:)
          end
        end
      end
    end
  end
end
