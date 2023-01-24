# frozen_string_literal: true

# controller for in-page likes
class LikeController < ApplicationController
  before_action :set_id

  def show
    @liked = Like.exists?(user: @current_user, episode_id: params[:id])
  end

  def create
    Like.where(user: @current_user, episode_id: params[:id]).first_or_create
    @liked = true
    render :show
  end

  def destroy
    Like.where(user: @current_user, episode_id: params[:id]).destroy_all
    @liked = false
    render :show
  end

  private

  def set_id
    @episode_id = params[:id]
  end
end
