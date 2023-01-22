# frozen_string_literal: true

# User-describing model
class User < ApplicationRecord
  # relations
  has_many :series, dependent: :destroy
  has_many :episodes, through: :series, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :subscript_series, through: :subscriptions # maybe fall

  has_many :views, dependent: :nullify
  has_many :viewed_episodes, through: :views # TODO: fix relation

  has_many :likes, dependent: :nullify
  has_many :liked_episodes, through: :likes

  has_many :comments, dependent: :destroy
  has_many :commented_episodes, through: :comments

  # extra attributes
  attr_accessor :password, :confirm_password

  # validations
  validates :email, uniqueness: { message: I18n.t("user.login.taken") },
                    presence: { message: I18n.t("user.login.presence") }
  validates :password, length: { minimum: 8, message: I18n.t("user.password.short") },
                       presence: { message: I18n.t("user.password.presence") }

  before_save do
    self.login = email.split("@")[0] if login.nil? # TODO: take dif test
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

  def encrypt(data)
    Digest::SHA2.new(256).hexdigest data
  end
end
