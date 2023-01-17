# frozen_string_literal: true

# Whole-app controller
class ApplicationController < ActionController::Base
  before_action :set_user, :current_user

  private

  def set_user
    @user = User.new
  end

  def current_user
    @current_user ||= session[:current_user_id] &&
                      User.find_by(id: session[:current_user_id])
  end
end
