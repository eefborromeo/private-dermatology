class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  before_create :check_quantity

  private

  def check_quantity
    specific_product = Product.find(self.product_id)
    if self.quantity > specific_product.stocks 
      errors.add(:base, 'Insufficient stocks, please try again.')
      throw :abort
    end
  end
end
