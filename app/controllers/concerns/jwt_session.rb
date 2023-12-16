# frozen_string_literal: true

module JwtSession
  extend ActiveSupport::Concern
  include JWTSessions::RailsAuthorization

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
