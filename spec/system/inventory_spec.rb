require "rails_helper"

RSpec.describe "Inventory", type: :system do
    let (:admin) { create(:admin) }
    let (:product) { build(:product) }

    context "when admin interacts with inventory" do
        before do
            login admin
            click_on "Inventory"
        end

        it "will add products to inventory" do
            click_on "Add Product"
            attach_file('Product image', './spec/support/acnecream.png')
            fill_in "Product name", with: product.product_name
            fill_in "Product description", with: product.product_desc
            fill_in "Price", with: product.price
            fill_in "Stocks", with: product.stocks
            click_on "Create Product"
            expect(page).to have_content("Product added to inventory")
            page.find('table')
            expect(page).to have_css('img')
            expect(page).to have_content("Acne Cream")
            page.find('a', text: 'Edit')
            page.find('a', text: 'Delete')
        end

        it "will edit products in inventory" do
            add_product
            click_on "Edit"
            fill_in "Product name", with: "Edited Name"
            click_on "Update Product"
            expect(page).to have_content("Product successfully edited")
            expect(page).to have_content("Edited Name")
        end

        it "will delete products from inventory" do
            add_product
            click_on "Delete"
            page.driver.browser.switch_to.alert.accept
            expect(page).to have_content("Product deleted")
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

    def add_product
        click_on "Add Product"
        attach_file('Product image', './spec/support/acnecream.png')
        fill_in "Product name", with: product.product_name
        fill_in "Product description", with: product.product_desc
        fill_in "Price", with: product.price
        fill_in "Stocks", with: product.stocks
        click_on "Create Product"
    end
end