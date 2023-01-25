# frozen_string_literal: true

# Single-mail activator
class ProfileActivatorMailer < ApplicationMailer
  default from: "noreply@satap.com"

  def activation_email
    @user = params[:user]
    @url  = activate_url(code: params[:code])
    mail(to: @user.email, subject: I18n.t("Activate your email on satap.com"))
  end
end
