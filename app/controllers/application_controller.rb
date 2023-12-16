# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JwtSession
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
end
