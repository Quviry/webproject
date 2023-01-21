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
      current_page?(controller: "series", action: child) ? "item--selected" : "text-dark"
    end
  end
end
