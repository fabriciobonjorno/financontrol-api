# frozen_string_literal: true

class SendConfirmationMailer < ApplicationMailer
  def send_confirmation_token(user)
    @user = user
    attachments.inline['logo.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'logo.png'))
    mail(
      from: ENV['EMAIL_DEFAULT'],
      to: @user.email,
      subject: 'Email de confirmação'
    )
  end
end
