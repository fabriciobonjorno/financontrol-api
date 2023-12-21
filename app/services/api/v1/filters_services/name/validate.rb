# frozen_string_literal: true

module Api
  module V1
    module FiltersServices
      module Name
        class Validate < MainService
          step :validate_inputs
          def validate_inputs(params)
            filter_params, current_user = params
            hash_params = {
              filter_params:,
              current_user:
            }.compact

            validation = Contract.call(filter_params.permit!.to_h)
            validation.success? ? Success(hash_params) : Failure(format_errors(validation.errors.to_h))
          end
        end
      end
    end
  end
end
