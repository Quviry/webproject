# frozen_string_literal: true

# User-describing model
class User < ApplicationRecord
  # relations
  has_many :series, dependent: :destroy
  has_many :episodes, through: :series, dependent: :destroy
  has_many :collected_likes, through: :episodes, source: :likes
  has_many :collected_views, through: :episodes, source: :views
  has_many :collected_comments, through: :episodes, source: :comments

  has_many :subscriptions, dependent: :destroy
  has_many :subscript_series, through: :subscriptions, source: :series
  has_many :subscript_episodes, through: :subscript_series, source: :episodes

  has_many :views, dependent: :nullify
  has_many :viewed_episodes, through: :views, source: :episode

  has_many :likes, dependent: :nullify
  has_many :liked_episodes, through: :likes, source: :episode

  has_many :comments, dependent: :destroy
  has_many :commented_episodes, through: :comments, source: :episode

  has_one :profile_activator, dependent: :destroy_async
  has_one :profile, dependent: :destroy_async

  # extra attributes
  attr_accessor :password, :confirm_password

  after_create :create_profile_activator

  # validations
  validates :email, uniqueness: { message: I18n.t("user.login.taken") },
                    presence: { message: I18n.t("user.login.presence") }
  validates :password, length: { minimum: 8, message: I18n.t("user.password.short") },
                       presence: { message: I18n.t("user.password.presence") }, if: :should_validate_password?

  before_save do
    self.login = email.split("@")[0] if login.nil?  # TODO: take dif test
    self.confirmed = false if confirmed.nil?
    self.encrypted_password = encrypt(password) unless password.nil?
  end

  def password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authentificate(email, submitted_password)
    user = find_by(email:)
    return nil if user.nil?

    user.password?(submitted_password) ? user : nil
  end

  private

  def should_validate_password?
    new_record? || password.present?
  end

  def encrypt(data)
    Digest::SHA2.new(256).hexdigest data
  end
end
