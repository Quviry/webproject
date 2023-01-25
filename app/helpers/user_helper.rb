# frozen_string_literal: true

# Helper for user data
module UserHelper
  def user_avatar(_user, class_ = "", *args, **kwargs, &)
    image_tag("/images/defaultuser.png", *args, class: "avatar #{class_}", **kwargs, &)
  end
end
