# frozen_string_literal: true

# Controller for login/logout operations
class SessionController < ApplicationController
  before_action :check_anauthorised, only: %i[create new]

  # login
  def new
    @user = User.new
  end

  def create
    if (user = User.authentificate(params[:user][:email], params[:user][:password]))
      redirect_to root_url
      session[:current_user_id] = user.id
    else
      @user = User.new
      @user.errors.add(:base, "Неверный логин или пароль")
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def check_anauthorised
    redirect_to root_path unless @current_user.nil?
  end
end
