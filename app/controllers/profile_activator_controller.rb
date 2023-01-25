# frozen_string_literal: true

# User actiovations controller
class ProfileActivatorController < ApplicationController
  def show
    @activator = ProfileActivator.find_by(code: params[:code])
    return if @activator.nil?

    @activator.user.confirmed = true
    @activator.user.save
    @current_user.reload
    @activator.destroy
  end

  def new
    ProfileActivator.create(user: @current_user)
  end
end
