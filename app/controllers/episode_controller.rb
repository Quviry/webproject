# frozen_string_literal: true

require "pagy/extras/countless"

# Controller for episodes
class EpisodeController < ApplicationController
  before_action :set_episode_from_params, only: %w[show edit update destroy summary]
  before_action :set_series
  before_action :set_episode, only: ["create"]

  def index
    @episodes = Series.find(params[:series_id]).episodes
  end

  def show
    @next_episode = Episode.where(series: @series, scene: @episode.scene + 1).first unless params[:page] == "prev"
    @prev_episode = Episode.where(series: @series, scene: @episode.scene - 1).first unless params[:page] == "next"
    respond_to do |format|
      format.html
      format.turbo_stream { View.create(episode: @episode, user: @current_user) }
    end
  end

  def new
    case @series.type
    when "Comics"
      @episode = ComicEpisode.new(series: @series)
    when "Novel"
      @episode = NovelEpisode.new(series: @series)
    end
  end

  def edit
    @episode = Episode.find(params[:id])
  end

  def create
    respond_to do |format|
      if @episode.save
        format.html { redirect_to dashboard_path, notice: I18n.t("user.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def summary; end

  def update
    @episode = Episode.find(params[:id])
    respond_to do |format|
      if @episode.update(update_params)
        flash[:notice] = I18n.t "Post was successfully updated."
        format.html { redirect_to(episodes_path(@series)) }
      else
        format.html { render action: :edit }
      end
    end
  end

  def destroy
    redirect_to episodes_path(@series)
    @episode.destroy
  end

  private

  def set_series
    @series = Series.find(params[:series_id]) unless params[:series_id].nil?
    @series = @episode.series unless @episode.nil?
  end

  def set_novel_episode
    params.require(:novel_episode).permit(:title, :schedule_date, :nsfw, :story, :thumbnail,
                                          :comments_enabled).merge(series: @series)
  end

  def set_comic_episode
    params.require(:comic_episode).permit(:title, :schedule_date, :nsfw, :thumbnail,
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

  def update_params
    param = { "ComicEpisode" => method(:set_comic_episode),
              "NovelEpisode" => method(:set_novel_episode) }[@episode.type].call
    param.delete(:pages) if param[:pages] == [""]
    param
  end
end
