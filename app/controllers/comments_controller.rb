# frozen_string_literal: true

# Controller for comments
class CommentsController < ApplicationController
  before_action :set_turbo_stream_format, only: %i[create update]
  def index
    @episode = Episode.find(params[:episode_id])
    @comments = @episode.comments.where(comment_id: nil)
    @new_comment = Comment.new(episode: @episode, user: @current_user)
  end

  def new; end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render turbo_stream: [helpers.turbo_flash("info", I18n.t("Comment added")),
                            turbo_stream.prepend("comments_container", comment)]
    else
      render turbo_stream: helpers.turbo_flash("warning", I18n.t("Error on comment creation"))
    end
  end

  def update
    @comment = Comment.find(params[:id])
    render and return if params["commit"] == "cencel"

    return if @comment.update(comment_params)

    render turbo_stream: helpers.turbo_flash("error", I18n.t("Error on comment update"))
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      render turbo_stream: turbo_stream.remove(helpers.dom_id(comment))
    else
      render turbo_stream: helpers.turbo_flash("error", I18n.t("Error on comment delete"))
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :episode_id, :body)
  end

  def set_turbo_stream_format
    request.format = "turbo_stream"
  end
end
