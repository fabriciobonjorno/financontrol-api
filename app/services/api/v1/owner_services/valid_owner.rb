# frozen_string_literal: true

module Api
  module V1
    module OwnerServices
      module ValidOwner
        class FindOwner < MainService
          def call(id, user_id, model)
            model.find_by(id:, user_id:, deleted_at: nil)
          end
        end
      end
    end
  end
end
