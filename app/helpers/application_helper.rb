# frozen_string_literal: true

# Core applications helper, propogates to every other helper
module ApplicationHelper
  include Pagy::Frontend
  def loader
    content_tag(:div,
                content_tag(:div, content_tag(:span, "Loading...", class: "visually-hidden"),
                            class: "spinner-border", role: "status"), class: "d-flex justify-content-center")
  end

  def url_child_of(child)
    if child == "index"
      current_page?(controller: "home") ? "item--selected" : "text-dark"
    elsif %w[comics novels].include?(child)
      in_series_controller(child) || in_episode_controller(child) ? "item--selected" : "text-dark"
    end
  end

  def in_series_controller(child)
    current_page?(controller: "series", action: child)
  end

  def in_episode_controller(child)
    controller_name == "episode" && action_name == "show" &&
      instance_variable_get(:@series).type.downcase.pluralize == child
  end
end
