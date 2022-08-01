require "rails_helper"

RSpec.describe "Inventory", type: :system do
    let (:admin) { create(:admin) }

    context "when admin interacts with inventory" do
        before do
            login admin
        end

        it "will add products to inventory" do
            click_on "Inventory"
            click_on "Add Product"
            fill_in "product_name", with: trader.first_name
            fill_in "product_desc", with: trader.last_name
            fill_in "price", with: trader.username
            fill_in "stocks", with: trader.email
            click_on "Add Product"
            expect(page).to have_content("Product added to inventory")
        end
    end

    private

    def login(user)
        visit new_user_session_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"
        expect(current_path).to eq(admin_dashboard_index_path)
    end
end