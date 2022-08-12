require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:current_user) { create(:confirmed_user) }
  let(:product) { create(:product) }
  let(:cart_item) { create(:cart_item, user: current_user, product: product) }

  it "has user" do
    cart_item.user = nil
    expect(cart_item).to_not be_valid
  end

  it "has product" do
    cart_item.product = nil
    expect(cart_item).to_not be_valid
  end

  it "has quantity" do
    cart_item.quantity = nil
    expect(cart_item).to_not be_valid
  end

  it "should check quantity of item before adding to cart" do
    expect{create(:cart_item, user: current_user, product: product, quantity: 6)}.to raise_error(ActiveRecord::RecordNotSaved)
  end
end
