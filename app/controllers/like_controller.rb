# frozen_string_literal: true

# controller for in-page likes
class LikeController < ApplicationController
  before_action :set_episode

  def show
    @liked = Like.exists?(user: @current_user, episode_id: @episode_id)
  end

  def create
    @like = Like.where(user: @current_user, episode_id: @episode_id).first_or_create
    @liked = @like.valid?
    render :show
  end

  def destroy
    @liked = !Like.find_by(user: @current_user, episode_id: @episode_id).destroy
    render :show
  end

  private

  def set_episode
    @episode_id = params[:id]
  end
end
