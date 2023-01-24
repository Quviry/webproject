# frozen_string_literal: true

# dashboard controller - to operate dashboard data
class DashboardController < ApplicationController
  before_action :prevent_unauthorised
  def index
    @series = Series.where(user: @current_user)
  end

  def episodes
    redirect_to episodes_path(@current_user.series.first)
  end
end
