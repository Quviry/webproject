# frozen_string_literal: true

# Test controller
class HomeController < ApplicationController
  def index
    @popular = Series.order(:like_count).limit(10)
    @subscribed = @current_user.subscript_series.order(:like_count).limit(10) unless @current_user.nil?
    return if @current_user.nil?

    @subscribed_new = Series.where(id: @current_user.subscript_episodes.where.not(id:
      View.where(user: @current_user).select(:episode_id)).select(:series_id)).limit(10)
  end
end
