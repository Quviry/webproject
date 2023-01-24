# frozen_string_literal: true

# Controller for in-page subscriptions
class SubscriptionController < ApplicationController
  before_action :set_id

  def show
    @subscribed = Subscription.exists?(user: @current_user, series_id: @series_id)
  end

  def create
    Subscription.where(user: @current_user, series_id: @series_id).first_or_create
    @subscribed = true
    render :show
  end

  def destroy
    Subscription.where(user: @current_user, series_id: @series_id).destroy_all
    @subscribed = false
    render :show
  end

  private

  def set_id
    @series_id = params[:id]
  end
end
