# frozen_string_literal: true

# Whole-app controller
class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_user, :current_user, :track_page

  private

  def set_user
    @user = User.new
  end

  def current_user
    @current_user ||= session[:current_user_id] &&
                      User.find_by(id: session[:current_user_id])
  end

  def track_page
    session[:return_to] ||= request.referer
  end

  def prevent_unauthorised
    return unless current_user.nil?

    redirect_back(fallback_location: root_path, notice: I18n.t("session.unauthorised.error"))
  end
end
