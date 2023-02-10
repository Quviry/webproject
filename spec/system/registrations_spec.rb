# frozen_string_literal: true

require "application_system_test_case"

RSpec.describe "Registrations", type: :system do
  context "when unauthorised user" do
    before do
      visit "/"
    end

    it "contain registration button" do
      expect(page).to have_content "Sign up"
    end

    describe "when on modal" do
      before do
        click_on "header_signup_btn"
      end

      it "has modal" do
        expect(page).to have_css "#exampleModal"
      end

      it "opens modal" do
        expect(page).to have_content "Register"
      end

      it "has registration button" do
        expect(page).to have_button "Создать Аккаунт"
      end
    end
  end
end
