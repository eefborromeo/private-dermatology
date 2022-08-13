require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { create(:product) }
  subject(:product_image) { create(:product).product_image }

  it "has a product image" do
    expect(product_image).to be_attached
  end

  it "has a product name" do
    product.product_name = ""
    expect(product).to_not be_valid
  end

  it "has a product description" do
    product.product_desc = ""
    expect(product).to_not be_valid
  end

  it "has a price" do
    product.price = 0
    expect(product).to_not be_valid
  end

  it "has stocks" do
    product.stocks = 0
    expect(product).to_not be_valid
  end
end
