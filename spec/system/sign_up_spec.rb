require "rails_helper"

RSpec.describe "Sign up", type: :system do
    let (:user) { build(:user) }

    it "will sign a user up with valid details" do
        visit root_path
        click_on "Create Account"
        expect(current_path).to eq(new_user_registration_path)
        expect(page).to have_content("Sign up")
        fill_in "Full name", with: user.full_name
        select user.gender, from: "Gender"
        fill_in "Date of Birth", with: user.dob
        fill_in "Contact No.", with: user.contact_no
        fill_in "Address", with: user.address
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Sign up"
        expect(page).to have_content("A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.")
    end
end