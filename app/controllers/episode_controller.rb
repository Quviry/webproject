# frozen_string_literal: true

# Controller for episodes
class EpisodeController < ApplicationController
  before_action :set_episode_from_params, only: ["show"]
  before_action :set_series, except: ["show"]
  before_action :set_episode, only: ["create"]

  def index
    @episodes = Series.find(params[:series_id]).episodes
  end

  def show; end

  def new
    case @series.type
    when "Comics"
      @episode = ComicEpisode.new(series: @series)
    when "Novel"
      @episode = NovelEpisode.new(series: @series)
    end
  end

  def edit; end

  def create
    respond_to do |format|
      if @episode.save
        format.html { redirect_to dashboard_path, notice: I18n.t("user.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy; end

  private

  def set_series
    @series = Series.find(params[:series_id])
  end

  def set_novel_episode
    params.require(:novel_episode).permit(:title, :schedule_date, :nsfw, :story,
                                          :comments_enabled).merge(series: @series)
  end

  def set_comic_episode
    params.require(:comic_episode).permit(:title, :schedule_date, :nsfw,
                                          :comments_enabled, pages: []).merge(series: @series)
  end

  def set_episode
    case @series.type
    when "Comics"
      @episode = ComicEpisode.new(set_comic_episode)
    when "Novel"
      @episode = NovelEpisode.new(set_novel_episode)
    end
  end

  def set_episode_from_params
    @episode = Episode.find(params[:id])
  end
end
