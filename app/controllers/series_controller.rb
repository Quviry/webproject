# frozen_string_literal: true

# Controller for comic/novel series
class SeriesController < ApplicationController
  before_action :set_series, only: %i[create update]
  def index; end

  def comics
    @series = if params[:genre] == "all" || params[:genre].nil?
                Comics.all
              else
                Comics.joins(:genres).where(genres: { title: params[:genre] })
              end
    render :index
  end

  def novels
    @series = if params[:genre] == "all" || params[:genre].nil?
                Novel.all
              else
                Novel.joins(:genres).where(genres: { title: params[:genre] })
              end
    render :index
  end

  def show
    episode = Series.where(url: params[:title]).first.episodes.first
    redirect_to episode_url(episode.id) and return unless episode.nil?

    redirect_to :series_info
  end

  def info
    @series = Series.where(url: params[:title]).first
  end

  def new
    case params[:type]
    when "comics"
      @series = Comics.new
    when "novel"
      @series = Novel.new
    end
  end

  def edit
    @series = Series.includes(:genres).find(params[:id])
  end

  def create
    respond_to do |format|
      if @series.save
        format.html { redirect_to dashboard_path, notice: I18n.t("user.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if update_series
        format.html { redirect_to dashboard_path, notice: I18n.t("user.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Series.find(params[:id]).destroy
    redirect_to dashboard_path
  end

  private

  def novel_params
    n_params = params.require(:novel).permit(:thumbnail, :cover, :title, :url, :description, :type, :genre_id,
                                             { genres_list: %w[], tags_list: %w[] })
    n_params[:user_id] = @current_user.id
    n_params
  end

  def comics_params
    c_params = params.require(:comics).permit(:thumbnail, :cover, :title, :url, :description, :type, :genre_id,
                                              { genres_list: %w[], tags_list: %w[] })
    c_params[:user_id] = @current_user.id
    c_params
  end

  def set_series
    case params[:type]
    when "comics"
      @series = Comics.new(comics_params)
    when "novel"
      @series = Novel.new(novel_params)
    end
  end

  def update_series
    @series = Series.find(params[:id])
    if @series.type == "Comics"
      @series.update(comics_params)
    else
      @series.upadte(novel_params)
    end
  end
end
