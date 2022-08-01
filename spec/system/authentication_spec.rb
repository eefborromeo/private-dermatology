require "rails_helper"

RSpec.describe "Login with logout", type: :system do
    let (:user) { create(:confirmed_user) }

    it "logs in with correct details" do
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"
        expect(page).to have_content('Signed in successfully.')
        click_on "Sign Out"
        expect(page).to have_content('Signed out successfully.')
    end
end