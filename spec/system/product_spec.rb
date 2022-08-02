require "rails_helper"

RSpec.describe "Products", type: :system do
    let (:user) { create(:user) }

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
    end
end