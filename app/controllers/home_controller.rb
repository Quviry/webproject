# frozen_string_literal: true

# Test controller
class HomeController < ApplicationController
  def index
    @popular = Series.likes_order.limit(10)
    return if @current_user.nil?

    @subscribed = @current_user.subscript_series.likes_order.limit(10)
    @subscribed_new = Series.where(id: @current_user.subscript_episodes.where.not(id:
      View.where(user: @current_user).select(:episode_id)).select(:series_id)).limit(10)
  end
end
