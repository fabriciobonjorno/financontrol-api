# frozen_string_literal: true

module LocaleConcern
  extend ActiveSupport::Concern
  include ActionController::Cookies

  def set_locale
    locale = params[:locale].to_sym if params[:locale].present?
    if I18n.available_locales.include?(locale)
      cookies[:locale] = { value: locale, expires: 1.year.from_now }
      cookies[:locale_expires_at] = { value: 1.year.from_now.to_s, expires: 1.year.from_now }
      message = I18n.t('locale.changed')
      render json: { message: } and return
    end

    I18n.locale = cookies[:locale] || I18n.default_locale
  end

  def check_locale
    locale = cookies[:locale]
    expiration_time = cookies[:locale_expires_at]

    if expiration_time && Time.parse(expiration_time) < Time.now
      render json: { message: 'Locale cookie has expired' }, status: :unauthorized
    else
      render json: { locale:, expires_at: expiration_time }
    end
  end
end
