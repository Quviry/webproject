# frozen_string_literal: true

# Core applications helper, propogates to every other helper
module ApplicationHelper
  def loader
    content_tag(:div,
                content_tag(:div, content_tag(:span, "Loading...", class: "visually-hidden"),
                            class: "spinner-border", role: "status"), class: "d-flex justify-content-center")
  end
end
