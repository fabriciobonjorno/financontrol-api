# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JwtSession
  include LocaleConcern
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  before_action :set_locale, unless: -> { action_name == 'check_locale' }
end
