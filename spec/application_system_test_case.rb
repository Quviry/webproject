# frozen_string_literal: true

require "rails_helper"

# Global test browser setup
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless")

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options:
    )
  end

  Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new(args: %w[window-size=1400,1000 no-sandbox test-type])

    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options:
    )
  end

  Capybara.default_driver = :chrome
end
