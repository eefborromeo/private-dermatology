require "rails_helper"

RSpec.describe "Products", type: :system do
    let (:user) { create(:confirmed_user) }

    context "when user interacts with product" do
        it "will be able to view products without logging in" do
            product = create(:product)
            visit products_path
            expect(page).to have_content(product.product_name)
            click_on product.product_name
            expect(page).to have_content(product.product_name)
            expect(page).to have_content(product.price)
            expect(page).to have_content(product.product_desc)
        end

        it "will not be able to add products to their cart without logging in" do
            product = create(:product)
            visit products_path
            expect(page).to have_content(product.product_name)
            click_on product.product_name
            fill_in "Quantity", with: "3"
            click_on "Add to Cart"
            expect(page).to have_content("You need to sign in or sign up before continuing.")
        end

        it "will be able to add products to cart if they are logged in" do
            product = create(:product)
            login(user)
            add_to_cart(product)
        end

        it "will be able to remove products to cart if they are logged in" do
            product = create(:product)
            login(user)
            add_to_cart(product)
            click_on "Remove"
            expect(page).to have_content("Item removed from cart.")
            expect(page).not_to have_content(product.product_name)
        end

        private

        def login(user)
            visit new_user_session_path
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Log in"
        end

        def add_to_cart(product)
            click_on "Products"
            click_on product.product_name
            fill_in "Quantity", with: "1"
            click_on "Add to Cart"
            expect(page).to have_content("Cart")
            expect(page).to have_content(product.product_name)
        end
    end
end