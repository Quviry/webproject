# frozen_string_literal: true

# User account controller
class UserController < ApplicationController
  # before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate, except: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:current_user_id] = @user.id
        format.html { redirect_to root_path, notice: I18n.t("user.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    # @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def authenticate
    # @user = User.find(params[:id])
  end
end
