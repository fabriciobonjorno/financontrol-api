# frozen_string_literal: true

module Api
  module V1
    module RegisterServices
      module Create
        class Presenter < MainService
          def call(user)
            {
              id: user.id.to_s,
              name: user.name,
              email: user.email,
              birth_date: user.birth_date,
              created_at: user.created_at
            }
          end
        end
      end
    end
  end
end
