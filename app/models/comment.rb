# frozen_string_literal: true

# Page comment under episode (to comment)
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  has_many :replies, class_name: "Comment", dependent: :destroy
  belongs_to :topic_starter, class_name: "Comment", optional: true

  validates :body, presence: true

  before_destroy :user_allowed?

  def user_allowed?
    user == @current_user
  end
end
