# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Confirmation
        class Presenter < MainService
          def call(user)
            {
              id: user.id,
              name: user.name,
              confirmed: user.confirmed,
              confirmed_at: Util.format_date(user.updated_at)
            }
          end
        end
      end
    end
  end
end
