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
            fill_in "Product name", with: "Acne Cream"
            fill_in "Product description", with: "Acne Cream is used to treat acne"
            fill_in "Price", with: 200.00
            fill_in "Stocks", with: 5
            click_on "Add"
            expect(page).to have_content("Product added to inventory")
            page.find('table')
            expect(page).to have_content("Acne Cream")
            page.find('a', text: 'Edit')
            page.find('a', text: 'Delete')
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