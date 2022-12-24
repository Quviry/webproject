# frozen_string_literal: true

# Application mail reference
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
